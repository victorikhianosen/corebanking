<?php

namespace App\Http\Controllers;

use App\Models\Bank;
use App\Models\Email;
use App\Models\Saving;
use App\Models\Setting;
use App\Models\Customer;
use App\Models\Exchangerate;
use App\Models\FixedDeposit;
use Illuminate\Http\Request;
use App\Models\GeneralLedger;
use App\Models\Accountofficer;
use Illuminate\Support\Carbon;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Http\Traites\UserTraite;
use App\Http\Traites\AuditTraite;
use App\Http\Traites\SavingTraite;
use App\Models\InvestmentSchedule;
use App\Models\InvestmetRepayment;
use Illuminate\Support\Facades\DB;
use App\Exports\FixedDepositExport;
use App\Models\FixedDepositProduct;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Cache;
use App\Http\Traites\InvestmentTraite;
use Illuminate\Contracts\Cache\LockTimeoutException;

class InvestmentController extends Controller
{
    use SavingTraite;
    use AuditTraite;
    use UserTraite;
    use InvestmentTraite;

    public function __construct()
    {
       $this->middleware('auth'); 
    }

    public function manage_fd(Request $request)
    {
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $query = FixedDeposit::with([
            'customer:id,first_name,last_name,acctno,phone,state,exchangerate_id',
            'accountofficer:id,full_name',
            'user:id,first_name,last_name',
            'fixed_deposit_product:id,name'
        ])->select(
            'id', 'fixed_deposit_code', 'principal', 'interest_method', 'interest_rate',
            'interest_period', 'release_date', 'maturity_date', 'status', 'customer_id',
            'user_id', 'accountofficer_id', 'fixed_deposit_product_id', 'enable_withholding_tax',
            'withholding_tax', 'system_approve', 'branch_id'
        );

        if ($request->filled('fx_filter')) {
            $filter = $request->fx_filter;
            $query->whereHas('customer', function ($q) use ($filter) {
                if ($filter === "Null") {
                    $q->whereNull('exchangerate_id');
                } else {
                    $q->where('exchangerate_id', $filter);
                }
            });
        }

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        if ($request->filled('start_date')) {
            $query->whereDate('release_date', '>=', $request->start_date);
        }

        if ($request->filled('end_date')) {
            $query->whereDate('release_date', '<=', $request->end_date);
        }

        if (Auth::user()->roles()->first()->name == 'account officer') {
            $acofficer = Accountofficer::where('user_id', Auth::user()->id)->first();
            if ($acofficer) {
                $query->where('accountofficer_id', $acofficer->id)
                      ->where('branch_id', $acofficer->branch_id);
            }
        }

        $data = $query->orderBy('id', 'DESC')->paginate(50);

        return view('investment.manage_fd')
            ->with('fixds', $data)
            ->with('exrate', Exchangerate::all());
    }

    public function view_fd(){
        if(request()->filter == true){
            $searchTerm = request()->invdetails;
            $invdata = FixedDeposit::where('fixed_deposit_code', $searchTerm)
                ->orWhereHas('customer', function ($q) use ($searchTerm) {
                    $q->where('first_name', 'like', '%' . $searchTerm . '%')
                      ->orWhere('last_name', 'like', '%' . $searchTerm . '%');
                })->get();
            return view('investment.view_fd')->with('fixds',$invdata);
        }else{
            return view('investment.view_fd');
        }
    }
    
    public function create_fd(){
        return view('investment.create_fd')
            ->with('fdprod', FixedDepositProduct::all())
            ->with('getofficers', Accountofficer::all());
    }
    
    public function show_fd($id){
        $fxds = FixedDeposit::findorfail($id);
        $schedules = InvestmentSchedule::where('fixed_deposit_id', $id)
            ->where('customer_id', $fxds->customer_id)
            ->orderBy('due_date', 'ASC')->get();
        $payments = InvestmetRepayment::where('fixed_deposit_id', $id)
            ->where('customer_id', $fxds->customer_id)
            ->orderBy('id', 'ASC')->get();
        $manuschedules = InvestmentSchedule::where('fixed_deposit_id', $id)
            ->where('closed', '0')
            ->whereDate('due_date', '<=', date("Y-m-d"))->get();
                                            
        return view('investment.fd_data')
            ->with('fxd', $fxds)
            ->with('banks', Bank::orderBy('bank_name', 'ASC')->get())
            ->with('payments', $payments)
            ->with('schedules', $schedules)
            ->with('manualschdelu', $manuschedules);
    }
    
    public function fd_duepayment(){
        if(request()->filter == true){
            $payments = InvestmentSchedule::whereBetween('due_date', [request()->datefrom, request()->dateto])
                ->orderBy('due_date', 'ASC')->get();
            return view('investment.fd_due')->with('fixdus', $payments);
        }else{
            return view('investment.fd_due');
        }
    }

    public function store_fd(Request $request){
        
        $lock = Cache::lock('bkfdiv-'.mt_rand('1111','9999'), 5);
             
        if($lock->get()){
                 
            $this->logInfo("creating fixed deposit", $request->all());
        
            $this->validate($request, [
                'principal'             => ['required','string'],
                'fd_product'            => ['required','string'],
                'duration'              => ['required','string'],
                'duration_type'         => ['required','string'],
                'payment_cycle'         => ['required','string'],
                'release_date'          => ['required','string'],
                'first_payment_date'    => ['required','string'],
                'interest_method'       => ['required','string'],
                'interest_rate'         => ['required','string'],
                'interest_period'       => ['required','string'],
                'officer'               => ['required','string'],
                'enable_withholding_tax'=> ['required','string'],
            ]);

            $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
            $bal    = str_replace(",", "", $request->balance);

            if($request->acno == ""){
                return ['status' => 'false', 'msg' => 'Please enter customer account number to continue'];
            } elseif($request->principal > $request->maxprincipal){
                $mxnm = number_format($request->maxprincipal, 2);
                return ['status' => 'false', 'msg' => 'Maximum Principal amount exceeded ' . $mxnm];
            } elseif($request->principal < $request->minprincipal){
                $minm = number_format($request->minprincipal, 2);
                return ['status' => 'false', 'msg' => 'Minimum Principal amount allowed ' . $minm];
            } elseif($bal <= 0 || $request->principal > $bal){
                return ['status' => 'false', 'msg' => 'Insufficient balance...please credit customer account to continue'];
            } else {

                $fd = FixedDeposit::create([
                    'user_id'                  => Auth::user()->id,
                    'customer_id'              => $request->customerid,
                    'fixed_deposit_product_id' => $request->fd_product,
                    'branch_id'                => $branch,
                    'accountofficer_id'        => $request->officer,
                    'fixed_deposit_code'       => mt_rand('11111111','99999999'),
                    'release_date'             => $request->release_date,
                    'first_payment_date'       => !empty($request->first_payment_date) ? $request->first_payment_date : null,
                    'principal'                => $request->principal,
                    'balance'                  => $request->principal,
                    'interest_method'          => $request->interest_method,
                    'interest_rate'            => $request->interest_rate,
                    'interest_period'          => $request->interest_period,
                    'duration'                 => $request->duration,
                    'duration_type'            => $request->duration_type,
                    'payment_cycle'            => $request->payment_cycle,
                    'applied_amount'           => $request->principal,
                    'enable_withholding_tax'   => $request->enable_withholding_tax,
                    'withholding_tax'          => $request->withholding_tax,
                    'auto_book_investment'     => !empty($request->auto_book_investment) ? $request->auto_book_investment : '0',
                ]);

                // ----------------------------------------------------------------
                // Calculate maturity date:
                // Maturity = last payment due date = first_payment_date advanced
                // by (period - 1) additional cycles.
                //
                // Example: first_payment = 24-Jul-2026, 3 months, monthly
                //   period = 3
                //   Cycle 1 due: 24-Jul-2026
                //   Cycle 2 due: 24-Aug-2026
                //   Cycle 3 due: 24-Sep-2026  ← maturity
                //
                // We advance (period-1) times from first_payment_date.
                // ----------------------------------------------------------------
                $period = $this->fd_period($fd->id);
                $fxd    = FixedDeposit::findorfail($fd->id);

                $maturityDate = Carbon::parse($request->first_payment_date);
                for ($x = 1; $x < $period; $x++) {
                    $this->advanceByPaymentCycle($maturityDate, $fxd->payment_cycle);
                }

                $fxd->maturity_date = $maturityDate->format('Y-m-d');
                $fxd->save();

                $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'fixed deposit',
                    'added a fixed deposit with code:' . $fd->fixed_deposit_code);

                return ['status' => 'success', 'msg' => 'Fixed deposit created awaiting approval'];
            }
        
            $lock->release();
        }
    }
    
    public function edit_fd($id){
        return view('investment.edit_fd')
            ->with('fdprod', FixedDepositProduct::all())
            ->with('getofficers', Accountofficer::all())
            ->with('edl', FixedDeposit::findorfail($id));
    }
    
    public function update_fd(Request $request, $id){
        $this->logInfo("updating fixed deposit", $request->all());

        $this->validate($request, [
            'principal'             => ['required','string'],
            'fd_product'            => ['required','string'],
            'duration'              => ['required','string'],
            'duration_type'         => ['required','string'],
            'payment_cycle'         => ['required','string'],
            'release_date'          => ['required','string'],
            'interest_method'       => ['required','string'],
            'interest_rate'         => ['required','string'],
            'interest_period'       => ['required','string'],
            'enable_withholding_tax'=> ['required','string'],
            'officer'               => ['required','string'],
        ]);

        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $fdd = FixedDeposit::findorfail($id);
            
        $fdd->user_id                  = Auth::user()->id;
        $fdd->customer_id              = $request->customerid;
        $fdd->fixed_deposit_product_id = $request->fd_product;
        $fdd->accountofficer_id        = $request->officer;
        $fdd->release_date             = $request->release_date;
        $fdd->first_payment_date       = !empty($request->first_payment_date) ? $request->first_payment_date : null;
        $fdd->principal                = $request->principal;
        $fdd->balance                  = $request->principal;
        $fdd->interest_method          = $request->interest_method;
        $fdd->interest_rate            = $request->interest_rate;
        $fdd->interest_period          = $request->interest_period;
        $fdd->duration                 = $request->duration;
        $fdd->duration_type            = $request->duration_type;
        $fdd->payment_cycle            = $request->payment_cycle;
        $fdd->applied_amount           = $request->principal;
        $fdd->enable_withholding_tax   = $request->enable_withholding_tax;
        $fdd->withholding_tax          = $request->withholding_tax;
        $fdd->auto_book_investment     = !empty($request->auto_book_investment) ? $request->auto_book_investment : '0';
        $fdd->save();

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'fixed deposit', 'updated fixed deposit');

        return ['status' => 'success', 'msg' => 'Fixed Deposit Updated'];
    }

    public function delete_fd($id){
        $fd = FixedDeposit::findorfail($id);
        if($fd->status == 'approved'){
            return ['status' => 'false', 'msg' => 'Fixed deposit investment already active and can\'t be deleted'];
        } else {
            $fd->delete();
            return ['status' => 'success', 'msg' => 'Fixed deposit investment deleted'];
        }
    }

    /**
     * Approve fixed deposit and generate schedule.
     *
     * KEY FIX: The due_date for each schedule row is set to $next_payment
     * BEFORE we advance it. This means:
     *   - Row 1 due_date = first_payment_date  (e.g. 24-Jul-2026)
     *   - Row 2 due_date = first_payment_date + 1 cycle  (24-Aug-2026)
     *   - Row 3 due_date = first_payment_date + 2 cycles (24-Sep-2026)  ← maturity
     *
     * We advance AFTER saving the row, so the next iteration has the correct date.
     */
    public function approve_fd(Request $request, $id){

        $lock = Cache::lock('appfdinv-'.mt_rand('1111','9999'), 5);
 
        if($lock->get()){
     
            DB::beginTransaction();
    
            $this->logInfo("investment approved", $request->all());
        
            $branch = null;
            $usern  = Auth::user()->last_name . " " . Auth::user()->first_name;
            $trxref = $this->generatetrnxref("intr");

            $fd           = FixedDeposit::findorfail($id);
            $customeracct = Saving::lockForUpdate()->where('customer_id', $fd->customer_id)->first();
            $customer     = Customer::where('id', $fd->customer_id)->first();

            $chkcres = $this->checkCustomerRestriction($fd->customer_id);
            if($chkcres == true){
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'customer', 'Account Restricted');
                return ['status' => 'false', 'msg' => 'Customer Account Has Been Restricted'];
            }
        
            $chklien = $this->checkCustomerLienStatus($fd->customer_id);
            if($chklien['status'] == true && $chklien['lien'] == 2){
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'customer', 'Account lien');
                return ['status' => 'false', 'msg' => 'Customer Account has been lien('.$chklien['message'].')...please contact support'];
            }
        
            $validateuserbalance = $this->validatecustomerbalance($fd->customer_id, $fd->principal);
            if($validateuserbalance["status"] == false){
                $this->tracktrails('1', '1', $usern, 'customer', $validateuserbalance["message"]);
                $this->logInfo("customer balance check", $validateuserbalance);
                return ['status' => false, 'msg' => $validateuserbalance['message']];
            }
                
            // GL accounts
            $glfixeddacct    = GeneralLedger::select('id','status','account_balance')->where('gl_code','20944548')->lockForUpdate()->first();
            $glinterestexpacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','50249457')->lockForUpdate()->first();
            $glwithhdtaxacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','20391084')->lockForUpdate()->first();
            $glsavingdacct   = GeneralLedger::select('id','status','account_balance')->where('gl_code','20993097')->lockForUpdate()->first();
            $glcurrentacct   = GeneralLedger::select('id','status','account_balance')->where('gl_code','20639526')->lockForUpdate()->first();

            $trnxinv = $this->generatetrnxref("inv");
           
            // Debit customer for investment
            $customeracct->account_balance -= $fd->principal;
            $customeracct->save();
   
            $this->create_saving_transaction(
                Auth::user()->id, $fd->customer_id, $branch, $fd->principal,
                'debit', 'core', '0', null, null, null, null, $trnxinv,
                "fixed deposit " . $fd->fixed_deposit_code . "--" . $request->approved_notes,
                'approved', '2', 'trnsfer', $usern
            );

            if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id, $fd->principal, $trnxinv, 'debit');
                $this->foreigncurrncyinvestment($customer->exchangerate_id, $fd->principal, $trnxinv, 'credit', $usern);
            } else {
                if($glsavingdacct->status == '1'){
                    $this->gltransaction('deposit', $glsavingdacct, $fd->principal, null);
                    $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $fd->principal, 'debit', 'core', $trnxinv, $this->generatetrnxref('svgl'), 'customer debited', 'approved', $usern);
                }
                $this->gltransaction('withdrawal', $glfixeddacct, $fd->principal, null);
                $this->create_saving_transaction_gl(null, $glfixeddacct->id, null, $fd->principal, 'credit', 'core', $trnxinv, $this->generatetrnxref('inv'), 'credit investment', 'approved', $usern);
            }

            // ----------------------------------------------------------------
            // Calculate interest rate and period
            // ----------------------------------------------------------------
            $interest_rate = $this->fd_determine_interest_rate($id);
            $period        = $this->fd_period($id);

            // ----------------------------------------------------------------
            // Start from first_payment_date (NOT advanced before the first row)
            // The due_date is set FIRST, then we advance for the next iteration.
            //
            // For a 3-month monthly investment with first_payment = 24-Jul-2026:
            //   i=1: due_date = 24-Jul-2026, then advance → next = 24-Aug-2026
            //   i=2: due_date = 24-Aug-2026, then advance → next = 24-Sep-2026
            //   i=3: due_date = 24-Sep-2026  ← maturity (last period, principal due)
            // ----------------------------------------------------------------
            $next_payment = Carbon::parse($fd->first_payment_date);
            $upfrnt  = 0;
            $rollvr  = 0;
            $invsch  = null;

            for ($i = 1; $i <= $period; $i++) {

                $interest = round($interest_rate * $fd->principal, 2);

                $invsch = new InvestmentSchedule();
                $invsch->fixed_deposit_id = $fd->id;
                $invsch->customer_id      = $fd->customer_id;
                $invsch->branch_id        = $branch;
                $invsch->description      = "interest payment";
                $invsch->due_date         = $next_payment->format('Y-m-d'); // ← set BEFORE advancing
                $invsch->principal        = $fd->principal;
                $invsch->interest         = $interest;
                $invsch->rollover         = 0;
                $invsch->total_interest   = $interest;
                $invsch->total_due        = $interest;

                // ---- method-specific overrides ----
                if($fd->interest_method == "upfront"){
                    $invsch->total_due = "0";
                    $upfrnt += $interest;
                    if ($i == $period) {
                        $invsch->total_due = $fd->principal;
                    }
                }

                if($fd->interest_method == "monthly"){
                    $invsch->total_due = $interest;
                    if ($i == $period) {
                        $invsch->total_due = $fd->principal + $interest;
                    }
                }

                if($fd->interest_method == "rollover"){
                    $this->determine_rollover_periods($i, $invsch, $interest_rate);
                }

                if($fd->interest_method == "simple_rollover"){
                    $invsch->interest       = 0;
                    $invsch->rollover       = $interest;
                    $invsch->total_interest = $interest;
                    $invsch->total_due      = 0;
                    $rollvr += $interest;
                    if ($i == $period) {
                        $invsch->total_due = $rollvr + $fd->principal;
                    }
                }

                $invsch->save();

                // Upfront: also create a repayment record immediately
                if($fd->interest_method == "upfront"){
                    InvestmetRepayment::create([
                        'fixed_deposit_id'  => $fd->id,
                        'accountofficer_id' => $fd->accountofficer_id,
                        'customer_id'       => $fd->customer_id,
                        'branch_id'         => $branch,
                        'user_id'           => Auth::user()->id,
                        'amount'            => $interest,
                        'collection_date'   => Carbon::now(),
                        'notes'             => 'interest payment --' . $fd->fixed_deposit_code,
                        'payment_method'    => 'flat',
                        'due_date'          => $invsch->due_date,
                    ]);
                }

                // ← Advance AFTER saving, so the next row gets the correct date
                $this->advanceByPaymentCycle($next_payment, $fd->payment_cycle);
            }

            // Maturity date = due_date of the last schedule row saved
            $lastSchedule = InvestmentSchedule::where("fixed_deposit_id", $fd->id)
                ->orderBy('id', 'DESC')->first();

            $fd->status         = 'approved';
            $fd->maturity_date  = $lastSchedule->due_date;
            $fd->approved_date  = $request->approved_date;
            $fd->release_date   = $request->approved_date;
            $fd->approved_notes = "Fixed Deposit " . $fd->fixed_deposit_code . "--" . $request->approved_notes;
            $fd->approved_by_id = Auth::user()->id;
            $fd->approved_amount= $request->approved_amount;
            $fd->save();

            // ----------------------------------------------------------------
            // Upfront interest: credit customer immediately
            // ----------------------------------------------------------------
            if($fd->interest_method == "upfront"){

                $customeracct->account_balance += $upfrnt;
                $customeracct->save();

                $this->create_saving_transaction(
                    Auth::user()->id, $fd->customer_id, $branch, $upfrnt,
                    'credit', 'core', '0', null, null, null, null, $trxref,
                    'fixed deposit upfront interest --' . $fd->fixed_deposit_code,
                    'approved', '8', 'trnsfer', $usern
                );

                if(!is_null($customer->exchangerate_id)){
                    $this->checkforeigncurrncy($customer->exchangerate_id, $upfrnt, $trxref, 'credit');
                    $this->foreigncurrncyinterestExpense($customer->exchangerate_id, $upfrnt, $trxref, $fd->fixed_deposit_code);
                } else {
                    if($glsavingdacct->status == '1'){
                        $this->gltransaction('withdrawal', $glsavingdacct, $upfrnt, null);
                        $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $upfrnt, 'credit', 'core', $trxref, $this->generatetrnxref('svgl'), 'customer credited', 'approved', $usern.'(c)');
                    }
                    $this->gltransaction('withdrawal', $glinterestexpacct, $upfrnt, null);
                    $this->create_saving_transaction_gl(null, $glinterestexpacct->id, null, $upfrnt, 'debit', 'core', $trxref, $this->generatetrnxref('intrexp'), 'fixed deposit investment interest - ' . $fd->fixed_deposit_code, 'approved', $usern);
                }

                if($fd->enable_withholding_tax == '1'){
                    $withhdtax = $fd->withholding_tax / 100 * $upfrnt;

                    $customeracct->account_balance -= $withhdtax;
                    $customeracct->save();
        
                    $this->create_saving_transaction(
                        Auth::user()->id, $fd->customer_id, $branch, $withhdtax,
                        'debit', 'core', '0', null, null, null, null, $trxref,
                        'withholding tax --' . $fd->fixed_deposit_code,
                        'approved', '11', 'trnsfer', $usern
                    );
        
                    if(!is_null($customer->exchangerate_id)){
                        $this->checkforeigncurrncy($customer->exchangerate_id, $withhdtax, $trxref, 'debit');
                        $this->foreigncurrncywtholdingTax($customer->exchangerate_id, $withhdtax, $trxref);
                    } else {
                        if($glsavingdacct->status == '1'){
                            $this->gltransaction('deposit', $glsavingdacct, $withhdtax, null);
                            $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $withhdtax, 'debit', 'core', $trxref, $this->generatetrnxref('svgl'), 'customer debited', 'approved', $usern.'(c)');
                        }
                        $this->gltransaction('withdrawal', $glwithhdtaxacct, $withhdtax, null);
                        $this->create_saving_transaction_gl(null, $glwithhdtaxacct->id, null, $withhdtax, 'credit', 'core', $trxref, $this->generatetrnxref('withtx'), 'withholding tax', 'approved', $usern);
                    }
                }
            }

            $this->tracktrails(Auth::user()->id, $branch, $usern, 'investment',
                'Approved a Fixed Deposit with code:' . $fd->fixed_deposit_code);

            DB::commit();

            $lock->release();

            return ['status' => 'success', 'msg' => 'Fixed Deposit Investment Approved'];
        }
    }

    public function decline_fd(Request $request, $id)
    {
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $fd = FixedDeposit::findorfail($id);
        $fd->status        = 'declined';
        $fd->declined_date = $request->declined_date;
        $fd->declined_notes= $request->declined_notes;
        $fd->declined_by_id= Auth::user()->id;
        $fd->save();

        InvestmentSchedule::where('fixed_deposit_id', $id)->delete();

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'loan',
            'Declined a Fixed Deposit with code:' . $fd->fixed_deposit_code);

        return ['status' => 'success', 'msg' => 'Fixed Deposit Investment Declined'];
    }

    // ----------------------------------------------------------------
    // Fixed deposit products
    // ----------------------------------------------------------------

    public function manage_fd_product(){
        return view('investment.fdproduct.index')
            ->with('fixproducts', FixedDepositProduct::orderBy('created_at','DESC')->get());
    }

    public function create_fd_product(){
        return view('investment.fdproduct.create');
    }

    public function store_fd_product(Request $r){
        $this->logInfo("creating fixed deposit product", $r->all());

        $this->validate($r, [
            'product_name'    => ['required','string'],
            'interest_method' => ['required','string'],
            'interest_period' => ['required','string'],
            'default_duration'=> ['required','string'],
            'repayment_cycle' => ['required','string'],
        ]);

        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $usern  = Auth::user()->last_name . " " . Auth::user()->first_name;

        $ckprod = FixedDepositProduct::where('name', strtolower($r->product_name))->first();
        if($ckprod){
            return redirect()->back()->with('error', 'product name already exist');
        } else {
            FixedDepositProduct::firstOrCreate([
                'user_id'              => Auth::user()->id,
                'name'                 => strtolower($r->product_name),
                'minimum_principal'    => $r->minimum_principal,
                'default_principal'    => $r->default_principal,
                'maximum_principal'    => $r->maximum_principal,
                'interest_method'      => $r->interest_method,
                'default_interest_rate'=> $r->default_interest_rate,
                'interest_period'      => $r->interest_period,
                'minimum_interest_rate'=> $r->minimum_interest_rate,
                'maximum_interest_rate'=> $r->maximum_interest_rate,
                'default_duration'     => $r->default_duration,
                'default_duration_type'=> $r->default_duration_type,
                'interest_payment'     => $r->repayment_cycle,
            ]);
       
            $this->tracktrails(Auth::user()->id, $branch, $usern,
                'investment/fixed-deposit-product', 'created a fixed-deposit product');
        }

        return ['status' => 'success', 'msg' => 'Record Created', 'redirect' => route('manage.fdproduct')];
    }

    public function edit_fd_product($id){
        return view('investment.fdproduct.edit')->with('ed', FixedDepositProduct::findorfail($id));
    }

    public function update_fd_product(Request $r, $id){
        $this->logInfo("updating fixed deposit product", $r->all());

        $this->validate($r, [
            'product_name'    => ['required','string'],
            'interest_method' => ['required','string'],
            'interest_period' => ['required','string'],
            'default_duration'=> ['required','string'],
            'repayment_cycle' => ['required','string'],
        ]);

        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $usern  = Auth::user()->last_name . " " . Auth::user()->first_name;

        $fixproduct = FixedDepositProduct::findorfail($id);
        $fixproduct->update([
            'name'                 => strtolower($r->product_name),
            'minimum_principal'    => $r->minimum_principal,
            'default_principal'    => $r->default_principal,
            'maximum_principal'    => $r->maximum_principal,
            'interest_method'      => $r->interest_method,
            'default_interest_rate'=> $r->default_interest_rate,
            'interest_period'      => $r->interest_period,
            'minimum_interest_rate'=> $r->minimum_interest_rate,
            'maximum_interest_rate'=> $r->maximum_interest_rate,
            'default_duration'     => $r->default_duration,
            'default_duration_type'=> $r->default_duration_type,
            'interest_payment'     => $r->repayment_cycle,
        ]);

        $this->tracktrails(Auth::user()->id, $branch, $usern,
            'investment/fixed-deposit-product', 'updated a fixed-deposit product');

        return ['status' => 'success', 'msg' => 'Record Updated', 'redirect' => route('manage.fdproduct')];
    }

    public function fd_product_delete($id)
    {
        FixedDepositProduct::findorfail($id)->delete();
        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, Auth::user()->branch_id, $usern,
            'investment/fixed-deposit-product', 'deleted a fixed-deposit product');
        return ['status' => 'success', 'msg' => 'Record Deleted'];
    }

    public function fd_products_details(){
        $lprod = FixedDepositProduct::findorfail(request()->proidval);
        if(!empty($lprod)){
            return [
                'status'         => '1',
                'principal'      => $lprod->default_principal,
                'maxprincipal'   => $lprod->maximum_principal,
                'minprincipal'   => $lprod->minimum_principal,
                'duration'       => $lprod->default_duration,
                'durtype'        => $lprod->default_duration_type,
                'interestmethod' => $lprod->interest_method,
                'interestrate'   => $lprod->default_interest_rate,
                'interestperiod' => $lprod->interest_period,
            ];
        } else {
            return ['status' => '0', 'msg' => "Product details not available"];
        }
    }

    // ----------------------------------------------------------------
    // Schedule management
    // ----------------------------------------------------------------

    public function fdedit_schedule($id)
    {
        $schedules = InvestmentSchedule::where('fixed_deposit_id', $id)->orderBy('due_date', 'asc')->get();
        $fxds      = FixedDeposit::findorfail($id);
        return view('investment.edit_schedule')
            ->with('schedules', $schedules)
            ->with('fd', $fxds)
            ->with('rows', 0);
    }

    public function fdupdate_schedule(Request $request, $id)
    {
        $this->logInfo("update investment schedule", $request->all());
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        InvestmentSchedule::where('fixed_deposit_id', $id)->delete();
        $fd = FixedDeposit::findorfail($id);

        foreach($request->scheduleid as $key => $value){
            if (empty($request->due_date[$key]) && empty($request->principal[$key]) && empty($request->interest[$key]) && empty($request->total_interest[$key]) && empty($request->rollover[$key])) {
                return ['status' => 'false', 'msg' => 'Some fields are empty'];
            } elseif (empty($request->due_date)) {
                return ['status' => 'false', 'msg' => 'due date field is empty'];
            } else {
                InvestmentSchedule::updateOrCreate(['id' => $value], [
                    'due_date'         => $request->due_date[$key],
                    'principal'        => $request->principal[$key],
                    'description'      => $request->description[$key],
                    'fixed_deposit_id' => $id,
                    'customer_id'      => $fd->customer_id,
                    'branch_id'        => $branch,
                    'interest'         => $request->interest[$key],
                    'total_interest'   => $request->total_interest[$key],
                    'total_due'        => $request->total_due[$key],
                    'rollover'         => $request->rollover[$key],
                ]);
            }
        }
        
        $getdate = InvestmentSchedule::where('fixed_deposit_id', $id)->orderBy('id', 'DESC')->first();
        $fd->maturity_date = $getdate->due_date;
        $fd->save();
                
        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'investment',
            'Updated Schedule for investment with code: ' . $fd->fixed_deposit_code);
        
        return ['status' => 'success', 'msg' => 'Schedule Updated', 'redirect' => route('show.fd', ['id' => $id])];
    }

    public function print_investment_schedule($id){
        $schedules = InvestmentSchedule::where('fixed_deposit_id', $id)->orderBy('due_date', 'asc')->get();
        $fxd       = FixedDeposit::findorfail($id);
        return view('investment.print_investment_schedule')
            ->with('fd', $fxd)
            ->with('schedules', $schedules);
    }

    public function print_offer_letter($id)
    {
        $schedules = InvestmentSchedule::where('fixed_deposit_id', $id)->orderBy('due_date', 'asc')->get();
        $fxd       = FixedDeposit::findorfail($id);
        return view('investment.invest_letter')
            ->with('fd', $fxd)
            ->with('email', '0')
            ->with('schedules', $schedules);
    }

    public function pdf_investment_schedule($id)
    {
        $getsetvalue = new Setting();
        $schedules   = InvestmentSchedule::where('loan_id', $id)->orderBy('due_date', 'asc')->get();
        $fd          = FixedDeposit::findorfail($id);
        $data = [
            'title'     => $getsetvalue->getsettingskey('company_name') . " Investment BreakDown",
            'date'      => date('m/d/Y'),
            'fd'        => $fd,
            'schedules' => $schedules,
        ];
        $pdf = PDF::loadView("investment.pdf_investment_schedule", $data);
        return $pdf->download(ucfirst($fd->customer->title) . " " . $fd->customer->first_name . " " . $fd->customer->last_name . " - Investment Payment Schedule.pdf");
    }

    public function email_investment_schedule($id)
    {
        $branch      = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $getsetvalue = new Setting();
        $fxd         = FixedDeposit::findorfail($id);
        $customer    = Customer::where('id', $fxd->customer_id)->first();

        if (!empty($customer->email)) {
            $body      = "Dear " . $customer->last_name . " " . $customer->first_name . ",<br> find attached investment schedule with investment code " . $fxd->fixed_deposit_code . " Thank you";
            $schedules = InvestmentSchedule::where('fixed_deposit_id', $id)->orderBy('due_date', 'asc')->get();
            $data = [
                'title'     => $getsetvalue->getsettingskey('company_name') . " Investment BreakDown",
                'date'      => date('m/d/Y'),
                'fd'        => $fxd,
                'schedules' => $schedules,
                'custm'     => $customer,
            ];
            
            if($customer->enable_email_alert == '1'){
                $pdf      = PDF::loadView("investment.pdf_investment_statement", $data);
                $filename = time() . '_investment_schedule.pdf';
                file_put_contents($filename, $pdf->output());
            
                Mail::send(['html' => 'mails.sendmail'], ['msg' => $body, 'type' => "investment schedule"],
                    function($mail) use ($customer, $getsetvalue, $filename){
                        $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                        $mail->to($customer->email);
                        $mail->subject("investment schedule");
                        $mail->attach($filename);
                    }
                );
                unlink($filename);

                Email::create([
                    'user_id'   => Auth::user()->id,
                    'branch_id' => $branch,
                    'subject'   => "investment schedule",
                    'message'   => $body,
                    'recipient' => $customer->email,
                ]);
            } else {
                return ['status' => 'false', 'msg' => 'Email is not enabled for this customer'];
            }
              
            return ['status' => 'success', 'msg' => 'Investment schedule successfully sent'];
        } else {
            return ['status' => 'false', 'msg' => 'Customer has no email set'];
        }
    }

    public function email_investment_offer_letter($id)
    {
        $branch      = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $getsetvalue = new Setting();
        $fxd         = FixedDeposit::findorfail($id);
        $customer    = Customer::where('id', $fxd->customer_id)->first();

        if (!empty($customer->email)) {
            $body      = "Dear " . $customer->last_name . " " . $customer->first_name . ",<br> Please find attachment of your investment letter below <br> Thank you. <br>" . Auth::user()->last_name . " " . Auth::user()->first_name;
            $schedules = InvestmentSchedule::where('fixed_deposit_id', $id)->orderBy('due_date', 'asc')->get();
            $data = [
                'title'     => $getsetvalue->getsettingskey('company_name') . " Investment Letter",
                'date'      => date('m/d/Y'),
                'fd'        => $fxd,
                'schedules' => $schedules,
                'custm'     => $customer,
                'email'     => '1',
            ];

            if($customer->enable_email_alert == '1'){
                $pdf      = PDF::loadView("investment.email_investment_letter", $data);
                $filename = time() . '_investment_letter.pdf';
                file_put_contents($filename, $pdf->output());
           
                Mail::send(['html' => 'mails.sendmail'], ['msg' => $body, 'type' => "investment letter"],
                    function($mail) use ($customer, $getsetvalue, $filename){
                        $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                        $mail->to($customer->email);
                        $mail->subject("investment letter");
                        $mail->attach($filename);
                    }
                );
                unlink($filename);

                Email::create([
                    'user_id'   => Auth::user()->id,
                    'branch_id' => $branch,
                    'subject'   => "investment letter",
                    'message'   => $body,
                    'recipient' => $customer->email,
                ]);
            } else {
                return ['status' => 'false', 'msg' => 'Email is not enabled for this customer'];
            }
            
            return ['status' => 'success', 'msg' => 'Investment letter successfully sent'];
        } else {
            return ['status' => 'false', 'msg' => 'Customer has no email set'];
        }
    }

    // ----------------------------------------------------------------
    // Liquidation
    // ----------------------------------------------------------------

    public function fdliquidation(){
        $fdd = FixedDeposit::where('status','approved')->where('fd_status','open')->get();

        if(!empty(request()->fdcode)){
            $fdcodes  = FixedDeposit::where('status','approved')->where('fd_status','open')
                ->where('fixed_deposit_code', request()->fdcode)->first();
            $schedules = InvestmentSchedule::where('fixed_deposit_id', $fdcodes->id)->get();
            if(!empty($schedules)){
                return view('investment.liquidatefd')
                    ->with('fxds', $fdd)
                    ->with('fxdcd', $fdcodes)
                    ->with('schedules', $schedules);
            } else {
                return view('investment.liquidatefd')->with('fxds', $fdd);
            }
        } else {
            return view('investment.liquidatefd')->with('fxds', $fdd);
        }
    }

    public function fdliquidation_save(Request $r){
        $lock = Cache::lock('fdliqtin-' . $r->customerid, 2);
           
        if($lock->get()){
            $getsetvalue  = new Setting();
            $tref         = $this->generatetrnxref("fd");
            $branch       = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
            $usern        = Auth::user()->last_name . " " . Auth::user()->first_name;
            $customeracct = Saving::lockForUpdate()->where('customer_id', $r->customerid)->first();
            $customer     = Customer::where('id', $r->customerid)->first();
            $fxd          = FixedDeposit::findorfail($r->fxdid);
            $schedules    = InvestmentSchedule::where('fixed_deposit_id', $r->fxdid)->get();

            $glfixeddacct    = GeneralLedger::select('id','status','account_balance')->where('gl_code','20944548')->lockForUpdate()->first();
            $glinterestexpacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','50249457')->lockForUpdate()->first();
            $glwithhdtaxacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','20391084')->lockForUpdate()->first();
            $glfdchrgacct    = GeneralLedger::select('id','status','account_balance')->where('gl_code', $getsetvalue->getsettingskey('fdliquid_interest'))->lockForUpdate()->first();
            $glsavingdacct   = GeneralLedger::select('id','status','account_balance')->where('gl_code','20993097')->lockForUpdate()->first();
            $glcurrentacct   = GeneralLedger::select('id','status','account_balance')->where('gl_code','20639526')->lockForUpdate()->first();

            if($r->liqoption == "upfront"){
                foreach($schedules as $itemclose){
                    $sched = InvestmentSchedule::where('id', $itemclose->id)->first();
                    $sched->payment_date  = Carbon::now();
                    $sched->payment_method= "liquidated";
                    $sched->posted_by     = Auth::user()->last_name . " " . Auth::user()->first_name;
                    $sched->closed        = '1';
                    $sched->save();
                }

                $fxd->closed_by_id = Auth::user()->id;
                $fxd->closed_notes = 'fixed deposit liquidated';
                $fxd->closed_date  = Carbon::now();
                $fxd->fd_status    = 'fully_paid';
                $fxd->status       = 'closed';
                $fxd->save();

                $customeracct->account_balance += $r->principal;
                $customeracct->save();
            
                $this->create_saving_transaction(Auth::user()->id, $r->customerid, $branch, $r->principal,
                    'credit', 'core', '0', null, null, null, null, $tref,
                    'fixed deposit investment liquidation--' . $fxd->fixed_deposit_code, 'approved', '12', 'trnsfer', $usern);
    
                if(!is_null($customer->exchangerate_id)){
                    $this->checkforeigncurrncy($customer->exchangerate_id, $r->principal, $tref, 'credit');
                    $this->foreigncurrncyinvestment($customer->exchangerate_id, $r->principal, $tref, 'debit', $usern);
                } else {
                    if($glsavingdacct->status == '1'){
                        $this->gltransaction('withdrawal', $glsavingdacct, $r->principal, null);
                        $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $r->principal, 'credit', 'core', $tref, $this->generatetrnxref('svgl'), 'customer credited', 'approved', $usern);
                    }
                    if($glfixeddacct->status == '1'){
                        $this->gltransaction('deposit', $glfixeddacct, $r->principal, null);
                        $this->create_saving_transaction_gl(null, $glfixeddacct->id, null, $r->principal, 'debit', 'core', $tref, $this->generatetrnxref('inv'), 'debit investment', 'approved', $usern);
                    }
                }
 
                if($customer->enable_email_alert == '1'){
                    $msg = "Credit Amt: N" . number_format($r->principal, 2) . "<br> Desc: fixed deposit investment liquidation <br>Avail Bal: N" . number_format($customeracct->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $tref;
                    Email::create(['user_id' => $r->customerid, 'subject' => ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert', 'message' => $msg, 'recipient' => $customer->email]);
                    Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Credit Transaction'],
                        function($mail) use ($getsetvalue, $customer){
                            $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                            $mail->to($customer->email);
                            $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert');
                        }
                    );
                }

                return redirect()->back()->with('success', 'Fixed Deposit Investment Liquidated Successfully');

            } else {
                if($r->interest <= '0'){
                    foreach($schedules as $itemclose){
                        $sched = InvestmentSchedule::where('id', $itemclose->id)->first();
                        $sched->payment_date   = Carbon::now();
                        $sched->payment_method = "liquidated";
                        $sched->posted_by      = Auth::user()->last_name . " " . Auth::user()->first_name;
                        $sched->closed         = '1';
                        $sched->save();
                    }
                    $fxd->closed_by_id = Auth::user()->id;
                    $fxd->closed_notes = 'fixed deposit liquidated';
                    $fxd->closed_date  = Carbon::now();
                    $fxd->fd_status    = 'fully_paid';
                    $fxd->status       = 'closed';
                    $fxd->save();

                    $customeracct->account_balance += $r->principal;
                    $customeracct->save();
            
                    $this->create_saving_transaction(Auth::user()->id, $r->customerid, $branch, $r->principal,
                        'credit', 'core', '0', null, null, null, null, $tref,
                        'fixed deposit investment liquidation --' . $fxd->fixed_deposit_code, 'approved', '12', 'trnsfer', $usern);
    
                    if(!is_null($customer->exchangerate_id)){
                        $this->checkforeigncurrncy($customer->exchangerate_id, $r->principal, $tref, 'credit');
                        $this->foreigncurrncyinvestment($customer->exchangerate_id, $r->principal, $tref, 'debit', $usern);
                    } else {
                        if($glsavingdacct->status == '1'){
                            $this->gltransaction('withdrawal', $glsavingdacct, $r->principal, null);
                            $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $r->principal, 'credit', 'core', $tref, $this->generatetrnxref('svgl'), 'customer credited', 'approved', $usern);
                        }
                        if($glfixeddacct->status == '1'){
                            $this->gltransaction('deposit', $glfixeddacct, $r->principal, null);
                            $this->create_saving_transaction_gl(null, $glfixeddacct->id, null, $r->principal, 'debit', 'core', $tref, $this->generatetrnxref('inv'), 'debit investment', 'approved', $usern);
                        }
                    }

                    if($customer->enable_email_alert == '1'){
                        $msg = "Credit Amt: N" . number_format($r->principal, 2) . "<br> Desc: fixed deposit investment liquidation <br>Avail Bal: N" . number_format($customeracct->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $tref;
                        Email::create(['user_id' => $r->customerid, 'subject' => ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert', 'message' => $msg, 'recipient' => $customer->email]);
                        Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Credit Transaction'],
                            function($mail) use ($getsetvalue, $customer){
                                $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                                $mail->to($customer->email);
                                $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert');
                            }
                        );
                    }
                } else {
                    foreach($schedules as $itemclose){
                        $sched = InvestmentSchedule::where('id', $itemclose->id)->first();
                        $sched->payment_date   = Carbon::now();
                        $sched->payment_method = "liquidated";
                        $sched->posted_by      = Auth::user()->last_name . " " . Auth::user()->first_name;
                        $sched->closed         = '1';
                        $sched->save();
                    }
                    $fxd->closed_by_id = Auth::user()->id;
                    $fxd->closed_notes = 'fixed deposit liquidated';
                    $fxd->closed_date  = Carbon::now();
                    $fxd->fd_status    = 'fully_paid';
                    $fxd->status       = 'closed';
                    $fxd->save();

                    $customeracct->account_balance += $r->principal;
                    $customeracct->save();
            
                    $this->create_saving_transaction(Auth::user()->id, $r->customerid, $branch, $r->principal,
                        'credit', 'core', '0', null, null, null, null, $tref,
                        'fixed deposit investment liquidation --' . $fxd->fixed_deposit_code, 'approved', '12', 'trnsfer', $usern);
    
                    if(!is_null($customer->exchangerate_id)){
                        $this->checkforeigncurrncy($customer->exchangerate_id, $r->principal, $tref, 'credit');
                        $this->foreigncurrncyinvestment($customer->exchangerate_id, $r->principal, $tref, 'debit', $usern);
                    } else {
                        if($glsavingdacct->status == '1'){
                            $this->gltransaction('withdrawal', $glsavingdacct, $r->principal, null);
                            $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $r->principal, 'credit', 'core', $tref, $this->generatetrnxref('svgl'), 'customer credited', 'approved', $usern . '(c)');
                        }
                        if($glfixeddacct->status == '1'){
                            $this->gltransaction('deposit', $glfixeddacct, $r->principal, null);
                            $this->create_saving_transaction_gl(null, $glfixeddacct->id, null, $r->principal, 'debit', 'core', $tref, $this->generatetrnxref('inv'), 'debit investment', 'approved', $usern);
                        }
                    }

                    $customeracct->account_balance += $r->interest;
                    $customeracct->save();
         
                    $this->create_saving_transaction(Auth::user()->id, $r->customerid, $branch, $r->interest,
                        'credit', 'core', '0', null, null, null, null, $tref,
                        'fixed deposit investment interest --' . $fxd->fixed_deposit_code, 'approved', '8', 'trnsfer', $usern);
 
                    if(!is_null($customer->exchangerate_id)){
                        $this->checkforeigncurrncy($customer->exchangerate_id, $r->interest, $tref, 'credit');
                        $this->foreigncurrncyinterestExpense($customer->exchangerate_id, $r->interest, $tref, $fxd->fixed_deposit_code);
                    } else {
                        if($glsavingdacct->status == '1'){
                            $this->gltransaction('withdrawal', $glsavingdacct, $r->interest, null);
                            $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $r->interest, 'credit', 'core', $tref, $this->generatetrnxref('svgl'), 'customer credited', 'approved', $usern . '(c)');
                        }
                        if($glinterestexpacct->status == '1'){
                            $this->gltransaction('withdrawal', $glinterestexpacct, $r->interest, null);
                            $this->create_saving_transaction_gl(null, $glinterestexpacct->id, null, $r->interest, 'debit', 'core', $tref, $this->generatetrnxref('intrexp'), 'fixed deposit investment interest - ' . $fxd->fixed_deposit_code, 'approved', $usern);
                        }
                    }
            
                    if($customer->enable_email_alert == '1'){
                        $msg = "Credit Amt: N" . $r->principal . "<br> Desc: fixed deposit investment liquidation <br>Avail Bal: N" . number_format($customeracct->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $tref;
                        Email::create(['user_id' => $r->customerid, 'subject' => ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert', 'message' => $msg, 'recipient' => $customer->email]);
                        Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Credit Transaction'],
                            function($mail) use ($getsetvalue, $customer){
                                $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                                $mail->to($customer->email);
                                $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert');
                            }
                        );
                    }

                    if($fxd->enable_withholding_tax == '1' && !empty($r->wthtax)){
                        $wtref     = $this->generatetrnxref('whtx');
                        $withhdtax = $r->wthtax / 100 * $r->interest;

                        $customeracct->account_balance -= $withhdtax;
                        $customeracct->save();
        
                        $this->create_saving_transaction(Auth::user()->id, $r->customerid, $branch, $withhdtax,
                            'debit', 'core', '0', null, null, null, null, $wtref,
                            'withholding tax --' . $fxd->fixed_deposit_code, 'approved', '11', 'trnsfer', $usern);
        
                        if(!is_null($customer->exchangerate_id)){
                            $this->checkforeigncurrncy($customer->exchangerate_id, $withhdtax, $wtref, 'debit');
                            $this->foreigncurrncywtholdingTax($customer->exchangerate_id, $withhdtax, $wtref);
                        } else {
                            if($glsavingdacct->status == '1'){
                                $this->gltransaction('deposit', $glsavingdacct, $withhdtax, null);
                                $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $withhdtax, 'debit', 'core', $wtref, $this->generatetrnxref('svgl'), 'customer debited', 'approved', $usern);
                            }
                            if($glwithhdtaxacct->status == '1'){
                                $this->gltransaction('withdrawal', $glwithhdtaxacct, $withhdtax, null);
                                $this->create_saving_transaction_gl(null, $glwithhdtaxacct->id, null, $withhdtax, 'credit', 'core', $wtref, $this->generatetrnxref('withtx'), 'withholding tax', 'approved', $usern);
                            }
                        }

                        if($customer->enable_email_alert == '1'){
                            $msg = "Debit Amt: N" . $withhdtax . "<br> Desc: Fixed deposit withholding tax <br>Avail Bal: N" . number_format($customeracct->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $wtref;
                            Email::create(['user_id' => $r->customerid, 'subject' => ucwords($getsetvalue->getsettingskey('company_name')) . ' Debit Alert', 'message' => $msg, 'recipient' => $customer->email]);
                            Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Debit Transaction'],
                                function($mail) use ($getsetvalue, $customer){
                                    $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                                    $mail->to($customer->email);
                                    $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Debit Alert');
                                }
                            );
                        }
                    }

                    if($r->enable_fdcharge == '1'){
                        if(!empty($r->fdcharge)){
                            $fdcgref = $this->generatetrnxref('fdchrg');
                            $fdchrge = $r->fdcharge / 100 * $r->interest;

                            $customeracct->account_balance -= $fdchrge;
                            $customeracct->save();
        
                            $this->create_saving_transaction(Auth::user()->id, $r->customerid, $branch, $fdchrge,
                                'debit', 'core', '0', null, null, null, null, $fdcgref,
                                'fixed deposit charge --' . $fxd->fixed_deposit_code, 'approved', '5', 'trnsfer', $usern);
        
                            if(!is_null($customer->exchangerate_id)){
                                $this->checkforeigncurrncy($customer->exchangerate_id, $fdchrge, $fdcgref, 'debit');
                                $this->foreigncurrncyLiquidationCharge($customer->exchangerate_id, $fdchrge, $fdcgref);
                            } else {
                                if($glsavingdacct->status == '1'){
                                    $this->gltransaction('deposit', $glsavingdacct, $fdchrge, null);
                                    $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $fdchrge, 'debit', 'core', $fdcgref, $this->generatetrnxref('svgl'), 'customer debited', 'approved', $usern . '(c)');
                                }
                                if($glfdchrgacct->status == 1){
                                    $this->gltransaction('withdrawal', $glfdchrgacct, $fdchrge, null);
                                    $this->create_saving_transaction_gl(null, $glfdchrgacct->id, null, $fdchrge, 'credit', 'core', $fdcgref, $this->generatetrnxref('fdchrg'), 'fixed deposit charge', 'approved', $usern);
                                }
                            }
                
                            if($customer->enable_email_alert == '1'){
                                $msg = "Debit Amt: N" . $fdchrge . "<br> Desc: fixed deposit investment charge <br>Avail Bal: N" . number_format($customeracct->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $fdcgref;
                                Email::create(['user_id' => $r->customerid, 'subject' => ucwords($getsetvalue->getsettingskey('company_name')) . ' Debit Alert', 'message' => $msg, 'recipient' => $customer->email]);
                                Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Debit Transaction'],
                                    function($mail) use ($getsetvalue, $customer){
                                        $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                                        $mail->to($customer->email);
                                        $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Debit Alert');
                                    }
                                );
                            }
                        }
                    }
                }

                $this->tracktrails(Auth::user()->id, $branch, $usern, 'investment',
                    'Fixed Deposit liquidated with code:' . $fxd->fixed_deposit_code);
            }

            DB::commit();
            $lock->release();
            return redirect()->back()->with('success', 'Fixed Deposit Investment Liquidated Successfully');
        }
    }
    
    public function manual_repayment(){
        $lock = Cache::lock('manrepay-' . request()->schdelid, 3);
            
        if($lock->get()){
            $tref        = $this->generatetrnxref("fd");
            $usern       = Auth::user()->last_name . " " . Auth::user()->first_name;
            $branch      = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
            $getsetvalue = new Setting();

            $glinterestexpacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','50249457')->lockForUpdate()->first();
            $glwithhdtaxacct   = GeneralLedger::select('id','status','account_balance')->where('gl_code','20391084')->lockForUpdate()->first();
            $glsavingdacct     = GeneralLedger::select('id','status','account_balance')->where('gl_code','20993097')->lockForUpdate()->first();
            $glcurrentacct     = GeneralLedger::select('id','status','account_balance')->where('gl_code','20639526')->lockForUpdate()->first();

            $sches    = InvestmentSchedule::where('id', request()->schdelid)->first();
            $fxdcode  = $sches->fixed_deposit->fixed_deposit_code;
        
            $customeracct = Saving::lockForUpdate()->where('customer_id', $sches->customer_id)->first();
            $customer     = Customer::where('id', $sches->customer_id)->first();

            $customeracct->account_balance += $sches->interest;
            $customeracct->save();
          
            $this->create_saving_transaction(Auth::user()->id, $sches->customer_id, null, $sches->interest,
                'credit', 'core', '0', null, null, null, null, $tref,
                'fixed deposit investment interest--' . $fxdcode, 'approved', '8', 'trnsfer', $usern);

            if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id, $sches->interest, $tref, 'credit');
                $this->foreigncurrncyinterestExpense($customer->exchangerate_id, $sches->interest, $tref, $sches->fixed_deposit->fixed_deposit_code);
            } else {
                if($glsavingdacct->status == '1'){
                    $this->gltransaction('withdrawal', $glsavingdacct, $sches->interest, null);
                    $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $sches->interest, 'credit', 'core', $tref, $this->generatetrnxref('crgl'), 'customer credited', 'approved', $usern);
                }
                if($glinterestexpacct->status == '1'){
                    $this->gltransaction('withdrawal', $glinterestexpacct, $sches->interest, null);
                    $this->create_saving_transaction_gl(null, $glinterestexpacct->id, null, $sches->interest, 'debit', 'core', $tref, $this->generatetrnxref('intrexp'), 'fixed deposit investment interest - ' . $sches->fixed_deposit->fixed_deposit_code, 'approved', $usern);
                }
            }

            $sches->payment_date   = Carbon::now();
            $sches->payment_method = "manual";
            $sches->posted_by      = Auth::user()->last_name . " " . Auth::user()->first_name;
            $sches->closed         = '1';
            $sches->save();

            InvestmetRepayment::create([
                'fixed_deposit_id'  => $sches->fixed_deposit_id,
                'accountofficer_id' => $sches->fixed_deposit->accountofficer_id,
                'customer_id'       => $sches->customer_id,
                'amount'            => $sches->interest,
                'collection_date'   => Carbon::now(),
                'notes'             => 'interest paid--' . $fxdcode,
                'payment_method'    => 'flat',
                'due_date'          => Carbon::now(),
            ]);

            if($customer->enable_email_alert == "1"){
                $msg = "Credit Amt: N" . $sches->interest . "<br> Desc: fixed deposit investment interest<br>Avail Bal: N" . number_format($customeracct->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $tref;
                Email::create(['user_id' => $customer->id, 'subject' => ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert', 'message' => $msg, 'recipient' => $customer->email]);
                Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Credit Transaction'],
                    function($mail) use ($getsetvalue, $customer){
                        $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                        $mail->to($customer->email);
                        $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert');
                    }
                );
            }

            if($sches->fixed_deposit->enable_withholding_tax == '1'){
                $wtref     = $this->generatetrnxref('whtx');
                $withhdtax = $sches->fixed_deposit->withholding_tax / 100 * $sches->interest;

                $customeracct->account_balance -= $withhdtax;
                $customeracct->save();
        
                $this->create_saving_transaction(null, $customer->id, null, $withhdtax,
                    'debit', 'core', '0', null, null, null, null, $wtref,
                    'withholding tax--' . $fxdcode, 'approved', '11', 'trnsfer', $usern);
            
                if(!is_null($customer->exchangerate_id)){
                    $this->checkforeigncurrncy($customer->exchangerate_id, $withhdtax, $wtref, 'debit');
                    $this->foreigncurrncywtholdingTax($customer->exchangerate_id, $withhdtax, $wtref);
                } else {
                    if($glsavingdacct->status == '1'){
                        $this->gltransaction('deposit', $glsavingdacct, $withhdtax, null);
                        $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $withhdtax, 'debit', 'core', $wtref, $this->generatetrnxref('drgl'), 'customer debited', 'approved', $usern);
                    }
                    if($glwithhdtaxacct->status == '1'){
                        $this->gltransaction('withdrawal', $glwithhdtaxacct, $withhdtax, null);
                        $this->create_saving_transaction_gl(null, $glwithhdtaxacct->id, null, $withhdtax, 'credit', 'core', $wtref, $this->generatetrnxref('withtx'), 'withholding tax', 'approved', $usern);
                    }
                }
        
                if($customer->enable_email_alert == "1"){
                    $msg = "Debit Amt: N" . $withhdtax . "<br> Desc: Fixed deposit withholding tax <br>Avail Bal: N" . number_format($customeracct->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $wtref;
                    Email::create(['user_id' => $customer->id, 'subject' => ucwords($getsetvalue->getsettingskey('company_name')) . ' Debit Alert', 'message' => $msg, 'recipient' => $customer->email]);
                    Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Debit Transaction'],
                        function($mail) use ($getsetvalue, $customer){
                            $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                            $mail->to($customer->email);
                            $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Debit Alert');
                        }
                    );
                }
            }

            $this->tracktrails(Auth::user()->id, $branch, $usern, 'investment',
                'Fixed Deposit interest with code:' . $sches->fixed_deposit->fixed_deposit_code);

            DB::commit();
            $lock->release();

            return ['status' => 'success', 'msg' => 'Interest Paid Successfully'];
        }
    }
    
    public function autoBookFixed_deposit($id, $principal){
        $fxd = FixedDeposit::findorfail($id);

        $firstPaymentDate = Carbon::now()->addMonthNoOverflow();

        $fd = FixedDeposit::create([
            'user_id'                  => null,
            'customer_id'              => $fxd->customer_id,
            'fixed_deposit_product_id' => $fxd->fixed_deposit_product_id,
            'branch_id'                => null,
            'accountofficer_id'        => $fxd->accountofficer_id,
            'fixed_deposit_code'       => mt_rand('11111111','99999999'),
            'release_date'             => Carbon::now(),
            'first_payment_date'       => $firstPaymentDate,
            'principal'                => $principal,
            'balance'                  => $principal,
            'interest_method'          => $fxd->interest_method,
            'interest_rate'            => $fxd->interest_rate,
            'interest_period'          => $fxd->interest_period,
            'duration'                 => $fxd->duration,
            'duration_type'            => $fxd->duration_type,
            'payment_cycle'            => $fxd->payment_cycle,
            'applied_amount'           => $principal,
            'enable_withholding_tax'   => $fxd->enable_withholding_tax,
            'withholding_tax'          => $fxd->withholding_tax,
            'auto_book_investment'     => $fxd->auto_book_investment,
        ]);

        // Calculate maturity date: advance (period-1) times from first_payment_date
        $period = $this->fd_period($fd->id);
        $fxds   = FixedDeposit::findorfail($fd->id);

        $maturityDate = Carbon::parse($firstPaymentDate);
        for ($x = 1; $x < $period; $x++) {
            $this->advanceByPaymentCycle($maturityDate, $fxds->payment_cycle);
        }

        $fxds->maturity_date = $maturityDate->format('Y-m-d');
        $fxds->save();

        $this->auto_approve_fd($fd->id);
    }

    public function auto_approve_fd($id){

        DB::beginTransaction();
        $this->logInfo("auto investment approved", "");
        
        $branch  = null;
        $trxref  = $this->generatetrnxref("intr");
        $fd      = FixedDeposit::findorfail($id);
        $customeracct = Saving::lockForUpdate()->where('customer_id', $fd->customer_id)->first();
        $customer     = Customer::where('id', $fd->customer_id)->first();
        $usern        = $customer->last_name . " " . $customer->first_name;

        $glfixeddacct    = GeneralLedger::select('id','status','account_balance')->where('gl_code','20944548')->lockForUpdate()->first();
        $glinterestexpacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','50249457')->lockForUpdate()->first();
        $glwithhdtaxacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','20391084')->lockForUpdate()->first();
        $glsavingdacct   = GeneralLedger::select('id','status','account_balance')->where('gl_code','20993097')->lockForUpdate()->first();
        $glcurrentacct   = GeneralLedger::select('id','status','account_balance')->where('gl_code','20639526')->lockForUpdate()->first();

        $trnxinv = $this->generatetrnxref("inv");
           
        $customeracct->account_balance -= $fd->principal;
        $customeracct->save();
   
        $this->create_saving_transaction($fd->user_id, $fd->customer_id, $branch, $fd->principal,
            'debit', 'core', '0', null, null, null, null, $trnxinv,
            "fixed deposit -" . $fd->fixed_deposit_code . "--Approved", 'approved', '2', 'trnsfer', $usern);

        if(!is_null($customer->exchangerate_id)){
            $this->checkforeigncurrncy($customer->exchangerate_id, $fd->principal, $trnxinv, 'debit');
            $this->foreigncurrncyinvestment($customer->exchangerate_id, $fd->principal, $trnxinv, 'credit', $usern);
        } else {
            if($glsavingdacct->status == '1'){
                $this->gltransaction('deposit', $glsavingdacct, $fd->principal, null);
                $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $fd->principal, 'debit', 'core', $trnxinv, $this->generatetrnxref('svgl'), 'customer debited', 'approved', $usern);
            }
            $this->gltransaction('withdrawal', $glfixeddacct, $fd->principal, null);
            $this->create_saving_transaction_gl(null, $glfixeddacct->id, null, $fd->principal, 'credit', 'core', $trnxinv, $this->generatetrnxref('inv'), 'credit investment', 'approved', $usern);
        }

        $interest_rate = $this->fd_determine_interest_rate($id);
        $period        = $this->fd_period($id);
        $approved_date = Carbon::now();

        // Same fix as approve_fd: set due_date BEFORE advancing
        $next_payment = Carbon::parse($fd->first_payment_date);
        $upfrnt  = 0;
        $rollvr  = 0;
        $invsch  = null;

        for ($i = 1; $i <= $period; $i++) {

            $interest = round($interest_rate * $fd->principal, 2);

            $invsch = new InvestmentSchedule();
            $invsch->fixed_deposit_id = $fd->id;
            $invsch->customer_id      = $fd->customer_id;
            $invsch->branch_id        = $branch;
            $invsch->description      = "interest payment";
            $invsch->due_date         = $next_payment->format('Y-m-d'); // ← set BEFORE advancing
            $invsch->principal        = $fd->principal;
            $invsch->interest         = $interest;
            $invsch->rollover         = 0;
            $invsch->total_interest   = $interest;
            $invsch->total_due        = $interest;

            if($fd->interest_method == "upfront"){
                $invsch->total_due = "0";
                $upfrnt += $interest;
                if ($i == $period) {
                    $invsch->total_due = $fd->principal;
                }
            }

            if($fd->interest_method == "monthly"){
                $invsch->total_due = $interest;
                if ($i == $period) {
                    $invsch->total_due = $fd->principal + $interest;
                }
            }

            if($fd->interest_method == "rollover"){
                $this->determine_rollover_periods($i, $invsch, $interest_rate);
            }

            if($fd->interest_method == "simple_rollover"){
                $invsch->interest       = 0;
                $invsch->rollover       = $interest;
                $invsch->total_interest = $interest;
                $invsch->total_due      = 0;
                $rollvr += $interest;
                if ($i == $period) {
                    $invsch->total_due = $rollvr + $fd->principal;
                }
            }

            $invsch->save();

            if($fd->interest_method == "upfront"){
                InvestmetRepayment::create([
                    'fixed_deposit_id'  => $fd->id,
                    'accountofficer_id' => $fd->accountofficer_id,
                    'customer_id'       => $fd->customer_id,
                    'branch_id'         => $branch,
                    'user_id'           => $fd->user_id,
                    'amount'            => round($interest),
                    'collection_date'   => Carbon::now(),
                    'notes'             => 'interest payment --' . $fd->fixed_deposit_code,
                    'payment_method'    => 'flat',
                    'due_date'          => $invsch->due_date,
                ]);
            }

            // ← Advance AFTER saving
            $this->advanceByPaymentCycle($next_payment, $fd->payment_cycle);
        }

        $lastSchedule = InvestmentSchedule::where('fixed_deposit_id', $fd->id)
            ->orderBy('id', 'DESC')->first();

        $fd->status          = "approved";
        $fd->first_payment_date = $fd->first_payment_date;
        $fd->maturity_date   = $lastSchedule->due_date;
        $fd->approved_date   = $approved_date;
        $fd->release_date    = $approved_date;
        $fd->approved_notes  = "fixed deposit approved";
        $fd->approved_by_id  = null;
        $fd->approved_amount = $fd->principal;
        $fd->system_approve  = '1';
        $fd->save();

        if($fd->interest_method == "upfront"){
            $customeracct->account_balance += $upfrnt;
            $customeracct->save();

            $this->create_saving_transaction($fd->user_id, $fd->customer_id, $branch, $upfrnt,
                'credit', 'core', '0', null, null, null, null, $trxref,
                'fixed deposit upfront interest--' . $fd->fixed_deposit_code, 'approved', '8', 'trnsfer', $usern);

            if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id, $upfrnt, $trxref, 'credit');
                $this->foreigncurrncyinterestExpense($customer->exchangerate_id, $upfrnt, $trxref, $fd->fixed_deposit_code);
            } else {
                if($glsavingdacct->status == '1'){
                    $this->gltransaction('withdrawal', $glsavingdacct, $upfrnt, null);
                    $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $upfrnt, 'credit', 'core', $trxref, $this->generatetrnxref('svgl'), 'customer credited', 'approved', $usern);
                }
                $this->gltransaction('withdrawal', $glinterestexpacct, $upfrnt, null);
                $this->create_saving_transaction_gl(null, $glinterestexpacct->id, null, $upfrnt, 'debit', 'core', $trxref, $this->generatetrnxref('intrexp'), 'fixed deposit investment interest - ' . $fd->fixed_deposit_code, 'approved', $usern);
            }

            if($fd->enable_withholding_tax == '1'){
                $withhdtax = $fd->withholding_tax / 100 * $upfrnt;

                $customeracct->account_balance -= $withhdtax;
                $customeracct->save();
    
                $this->create_saving_transaction($fd->user_id, $fd->customer_id, $branch, $withhdtax,
                    'debit', 'core', '0', null, null, null, null, $trxref,
                    'withholding tax--' . $fd->fixed_deposit_code, 'approved', '11', 'trnsfer', $usern);
    
                if(!is_null($customer->exchangerate_id)){
                    $this->checkforeigncurrncy($customer->exchangerate_id, $withhdtax, $trxref, 'debit');
                    $this->foreigncurrncywtholdingTax($customer->exchangerate_id, $withhdtax, $trxref);
                } else {
                    if($glsavingdacct->status == '1'){
                        $this->gltransaction('deposit', $glsavingdacct, $withhdtax, null);
                        $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $withhdtax, 'debit', 'core', $trxref, $this->generatetrnxref('svgl'), 'customer debited', 'approved', $usern);
                    }
                    $this->gltransaction('withdrawal', $glwithhdtaxacct, $withhdtax, null);
                    $this->create_saving_transaction_gl(null, $glwithhdtaxacct->id, null, $withhdtax, 'credit', 'core', $trxref, $this->generatetrnxref('withtx'), 'withholding tax', 'approved', $usern);
                }
            }
        }

        DB::commit();
    }

    public function exportdata(){
        $filter    = request()->filter == true ? true : false;
        $fxfilter  = request()->fx_filter == "Null" ? null : request()->fx_filter;
        $searchval = !empty(request()->searchval) ? request()->searchval : null;
        $status    = !empty(request()->status) ? request()->status : null;
        $dateto    = request()->filter == true ? request()->dateto : '';

        return Excel::download(new FixedDepositExport($searchval, $filter, $fxfilter, $status, $dateto), 'Fixed_deposit.xlsx');
    }

} // end class