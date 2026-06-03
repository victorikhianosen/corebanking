<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Bank;
use App\Models\Loan;
use App\Models\Email;
use App\Models\Charge;
use App\Models\Saving;
use App\Models\Sector;
use App\Models\LoanFee;
use App\Models\Setting;
use App\Models\Customer;
use App\Exports\LoanExport;
use App\Models\LoanFeeMeta;
use App\Models\LoanProduct;
use App\Models\Exchangerate;
use App\Models\LoanSchedule;
use Illuminate\Http\Request;
use App\Models\GeneralLedger;
use App\Models\LoanRepayment;
use App\Models\ProvisionRate;
use App\Models\Accountofficer;
use App\Models\OutstandingLoan;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Http\Traites\LoanTraite;
use App\Http\Traites\UserTraite;
use App\Http\Traites\AuditTraite;
use App\Http\Traites\SavingTraite;
use App\Models\SavingsTransaction;
use Illuminate\Support\Facades\DB;
use App\Http\Traites\TransferTraite;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Cache;
use Illuminate\Contracts\Cache\LockTimeoutException;

class LoanController extends Controller
{
    use LoanTraite;
    use AuditTraite;
    use SavingTraite;
    use UserTraite;
    use TransferTraite;
    
    private $murl, $mapikey,$msercetkey,$macctno,$url,$apikey;
    
    public function __construct()
    {
       $this->middleware('auth'); 
       
         if(env('APP_MODE') == "test"){
            $this->murl = env('MONNIFY_SANDBOX_URL');
            $this->mapikey = env('MONNIFY_SANDBOX_API_KEY');
            $this->msercetkey = env('MONNIFY_SANDBOX_SECRET_KEY');
            $this->macctno = env('MONNIFY_SANDBOX_ACCOUNT_NUMBER');
        }else{
            $this->murl = env('MONNIFY_LIVE_URL');
            $this->mapikey = env('MONNIFY_LIVE_API_KEY');
            $this->msercetkey = env('MONNIFY_LIVE_SECRET_KEY');
            $this->macctno = env('MONNIFY_LIVE_ACCOUNT_NUMBER');
            $this->url = env('WIRELESS_URL');
            $this->apikey = env('WIRELESS_API_KEY');
        }
    }

    public function index(){
           $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
           if(Auth::user()->roles()->first()->name == 'account officer'){
               if (empty(request()->status)) {

                if(!empty(request()->fx_filter)){
                     $filter = request()->fx_filter == "Null" ? null : request()->fx_filter;
                      $fxcust = Customer::select('id')->where('exchangerate_id',$filter)->get();
                    foreach($fxcust as $fxc){
                        $fx[] = $fxc->id;
                    }

                 $acofficer = Accountofficer::where('user_id',Auth::user()->id)->first();
                  $data = Loan::where('accountofficer_id',$acofficer->id)
                                      ->where('branch_id',$acofficer->branch_id)
                                      ->whereIn('customer_id',$fx)
                                      ->orderBy('id','DESC')->paginate(50);
                    }else{
                         $acofficer = Accountofficer::where('user_id',Auth::user()->id)->first();
                            $data = Loan::where('accountofficer_id',$acofficer->id)
                                      ->where('branch_id',$acofficer->branch_id)
                                      ->orderBy('id','DESC')->paginate(50);
                    }
                } else{

                    if(!empty(request()->fx_filter)){
                        $filter = request()->fx_filter == "Null" ? null : request()->fx_filter;
                        $fxcust = Customer::select('id')->where('exchangerate_id',$filter)->get();
                        foreach($fxcust as $fxc){
                            $fx[] = $fxc->id;
                        }

                   
                                $data = Loan::where('status', request()->status)->paginate(50);
                     $acofficer = Accountofficer::where('user_id',Auth::user()->id)->first();
                     $data = Loan::where('accountofficer_id',$acofficer->id)
                                  ->where('branch_id',$acofficer->branch_id)
                                  ->where('status', request()->status)
                                   ->whereIn('customer_id',$fx)
                                  ->orderBy('id','DESC')->paginate(50);

                    }else{
                        
                    $data = Loan::where('status', request()->status)->paginate(50);
                     $acofficer = Accountofficer::where('user_id',Auth::user()->id)->first();
                     $data = Loan::where('accountofficer_id',$acofficer->id)
                                  ->where('branch_id',$acofficer->branch_id)
                                  ->where('status', request()->status)
                                  ->orderBy('id','DESC')->paginate(50);
                    }
                }
             
           }else{
                 if (empty(request()->status)) {

                       if(!empty(request()->fx_filter)){

                            $filter = request()->fx_filter == "Null" ? null : request()->fx_filter;
                            $fxcust = Customer::select('id')->where('exchangerate_id',$filter)->get();
                            foreach($fxcust as $fxc){
                                $fx[] = $fxc->id;
                            }

                         $data = Loan::whereIn('customer_id',$fx)->orderBy('id','DESC')->paginate(50);

                    }else{
                          $data = Loan::orderBy('id','DESC')->paginate(50);
                    }

                } else{

                       if(!empty(request()->fx_filter)){

                            $filter = request()->fx_filter == "Null" ? null : request()->fx_filter;
                            $fxcust = Customer::select('id')->where('exchangerate_id',$filter)->get();
                            foreach($fxcust as $fxc){
                                $fx[] = $fxc->id;
                            }

                            $data = Loan::where('status', request()->status)
                                        ->whereIn('customer_id',$fx)
                                        ->orderBy('id','DESC')->paginate(50);

                    }else{
                           $data = Loan::where('status', request()->status)
                                ->orderBy('id','DESC')->paginate(50);
                    }            
                }
           }
      
        return view('loan.all_loans')->with('loans',$data)
                                    ->with('exrate',Exchangerate::all());
    }

    public function view_loan(){
            if(request()->filter == true){

                $searchTerm = request()->londetails;

                $ldata = Loan::where('loan_code', $searchTerm) // Search Loan table
                    ->orWhereHas('customer', function ($q) use ($searchTerm) { // Search Customer table
                        $q->where('first_name', 'like', '%' . $searchTerm . '%')
                          ->orWhere('last_name', 'like', '%' . $searchTerm . '%');
                    })->get();
               
                return view('loan.view_loan')->with('loans',$ldata);
            }else{
                return view('loan.view_loan');
            }
    }


     public function loan_provision(){
        return view('loan.provision_rate')->with('prate',ProvisionRate::all());
    }

    public function loan_provision_update(Request $r,$id){
        $this->validate($r,[
            'rate' => ['required','numeric','gt:0'],
        ]);

        ProvisionRate::where('id',$id)->update([
            'rate' => $r->rate
        ]);

        return ['status' => 'success','msg'=> 'Record Updated'];
    }
    
    public function loan_sector(){
        return view('loan.sector')->with('sectors',Sector::all());
    }

    public function loan_sector_update_create(Request $r){
        $this->validate($r,[
            'sector' => ['required','string'],
        ]);

       if($r->stype == "Create"){
       Sector::create([
            'sector' => $r->sector
        ]);

        return ['status' => 'success','msg'=> 'Record Created'];

       }elseif($r->stype == "Edit"){

        
        Sector::where('id',$r->id)->update([
            'sector' => $r->sector
        ]);

        return ['status' => 'success','msg'=> 'Record Updated'];
       }
    }
    
    public function create(){
       if(!empty(request()->customerid)){
        return view('loan.create_loans')->with('getofficers',Accountofficer::all())
                                        ->with('loanfees',LoanFee::all())
                                         ->with('sectors',Sector::all())
                                        ->with('customer',Customer::findorfail(request()->customerid))
                                    ->with('loanprod', LoanProduct::all());
       }else{
        return view('loan.create_loans')->with('getofficers',Accountofficer::all())
                                        ->with('loanfees',LoanFee::all())
                                         ->with('sectors',Sector::all())
                                    ->with('loanprod', LoanProduct::all());
       }
    }

    public function show($id){
        $schedules = LoanSchedule::where('loan_id', $id)->orderBy('due_date', 'ASC')->get();
        $payments = LoanRepayment::where('loan_id', $id)->orderBy('id', 'ASC')->get();
        
        return view('loan.loan_data')->with('loan',Loan::findorfail($id))
                                    ->with('banks',Bank::orderBy('bank_name', 'ASC')->get())
                                     ->with('payments',$payments)
                                     ->with('schedules',$schedules);
    }

    public function store(Request $request){

        $lock = Cache::lock('lonstor-'.mt_rand('1111','9999'),5);
            
    if($lock->get()){

        $this->logInfo("creating loan",$request->all());
        
        $this->validate($request,[
            'principal' => ['required','string','gt:0'],
            'sector' => ['required','string'],
            'loan_product' => ['required','string'],
            'loan_duration' => ['required','string'],
            'loan_duration_type' => ['required','string'],
            'equity' => ['required','string'],
            'purpose' => ['required','string'],
            'repayment_cycle' => ['required','string'],
            'release_date' => ['required','string'],
            'interest_method' => ['required','string'],
            'interest_rate' => ['required','string'],
            'interest_period' => ['required','string'],
            'officer' => ['required','string'],
        ]);
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        //$customeracct = Saving::where('customer_id',$request->customerid)->first();

        // if($customeracct->account_balance >= "1000"){

    $loanprod = LoanProduct::select('gl_code','interest_gl','incomefee_gl')->where('id',$request->loan_product)->first();

    if(empty($loanprod->gl_code) || empty($loanprod->interest_gl) || empty($loanprod->incomefee_gl)){
        return redirect()->back()->with('error', 'Loan product GLs is required');
    }

    $glacctchk = GeneralLedger::where('gl_code',$loanprod->gl_code)
                                 ->first();

 $custt2 = Customer::where('id',$request->customerid)->first();

    if($custt2->exchangerate_id != $glacctchk->currency_id){

        return redirect()->back()->with('error', 'Currency mis-match between customer and loan product');
    }
    
        $prvisn = ProvisionRate::where('name','performing')->first();
        $prvamtv = $request->principal / 100 * $prvisn->rate;
        
        $locd = date('dmy')."".str_pad(mt_rand(0, 9999), 4, '0', STR_PAD_LEFT);

        $loan = Loan::create([
               'user_id' => Auth::user()->id,
               'customer_id' => $request->customerid,
               'loan_product_id' => $request->loan_product,
               'branch_id' => $branch,
               'accountofficer_id' => $request->officer,
               'loan_code' => $locd,
               'equity' => $request->equity,
               'purpose' => $request->purpose,
               'release_date' => $request->release_date,
               'first_payment_date' => !empty($request->first_payment_date) ? $request->first_payment_date : null,
                'principal' => $request->principal,
                'balance' => $request->principal,
                'interest_method' => $request->interest_method,
                'interest_rate' => $request->interest_rate,
                'interest_period' => $request->interest_period,
                'loan_duration' => $request->loan_duration,
                'loan_duration_type' => $request->loan_duration_type,
                'repayment_cycle' => $request->repayment_cycle,
                'override_interest' => $request->override_interest,
                'override_interest_amount' => $request->override_interest_amount,
                'grace_on_interest_charged' => $request->grace_on_interest_charged,
                'applied_amount' => $request->principal,
                'description' => $request->description,
                  'provision_date' => Carbon::now(),
                'provision_amount' => $prvamtv,
                'provision_type' => $prvisn->name,
                'sector_id' => $request->sector
            ]);
        
            // if($request->hasFile('files')){
            //     $value = $request->file('files');
            //         $newfilevalue = time()."_".$value->getClientOriginalName();
            //         $value->move('uploads',$newfilevalue);
                    
            //     Loan::where('id',$loan->id)->update([
            //         'files' => 'uploads/'.$newfilevalue
            //     ]);
            // }
            
            $loan2 = Loan::findorfail($loan->id);

        if($request->hasFile('files')){
           $file =  $request->file('files');
                $newfilevalue = time()."_".$file->getClientOriginalName();
                $file->move('uploads',$newfilevalue);
                $loan2->files = 'uploads/'.$newfilevalue;
                $loan2->save();
             }

            if(!empty($request->loanfees)){
                foreach($request->loanfees as $key => $loanfee){
                  $loanmeta = LoanFeeMeta::create([
                        'user_id' => Auth::user()->id,
                        'parent_id' => $loan->id,
                        'loan_fee_id' => $loanfee,
                        'category' => 'loan',
                        'value' => !empty($request->loan_fees_amount[$key]) ? $request->loan_fees_amount[$key] : '0',
                        'loan_fees_schedule' => !empty($request->loan_fees_schedule[$key]) ? $request->loan_fees_schedule[$key] : ($request->loan_fees_amount[$key] == '0' || empty($request->loan_fees_amount[$key]) ? 'charge_fees_on_first_payment' : '')
                    ]);

                     //determine amount to use
                     $fees_distribute = 0;
        $fees_first_payment = 0;
        $fees_last_payment = 0;
            if ($request->loan_fees_type[$key] == 'fixed') {
                

                if ($loanmeta->loan_fees_schedule == 'distribute_fees_evenly') {
                    $fees_distribute = $fees_distribute + $loanmeta->value;
                }
                if ($loanmeta->loan_fees_schedule == 'charge_fees_on_first_payment') {
                    $fees_first_payment = $fees_first_payment + $loanmeta->value;
                }
                if ($loanmeta->loan_fees_schedule == 'charge_fees_on_last_payment') {
                    $fees_last_payment = $fees_last_payment + $loanmeta->value;
                }
            } else {
                if ($loanmeta->loan_fees_schedule == 'distribute_fees_evenly') {
                    $fees_distribute = $fees_distribute + ($loanmeta->value * $loan->principal / 100);
                }
                if ($loanmeta->loan_fees_schedule == 'charge_fees_on_first_payment') {
                    $fees_first_payment = $fees_first_payment + ($loanmeta->value * $loan->principal / 100);
                }
                if ($loanmeta->loan_fees_schedule == 'charge_fees_on_last_payment') {
                    $fees_last_payment = $fees_last_payment + ($loanmeta->value * $loan->principal / 100);
                }
            }
        }
     }
            
     $interest_rate = $this->determine_interest_rate($loan->id);

        $period = $this->loan_period($loan->id);
        $loan = Loan::findorfail($loan->id);
        
        if ($loan->repayment_cycle == 'daily') {
            $repayment_cycle = 'day';
            $loan->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' days')),
                'Y-m-d');
        }
        if ($loan->repayment_cycle == 'weekly') {
            $repayment_cycle = 'week';
            $loan->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' weeks')),
                'Y-m-d');
        }
        if ($loan->repayment_cycle == 'monthly') {
            $repayment_cycle = 'month';
            $loan->maturity_date = date_format(date_add(date_create($request->first_payment_date),
            date_interval_create_from_date_string($period . ' months')),
            'Y-m-d');
            //Carbon::create($request->first_payment_date)->toFormattedDateString();
            
        }
        if ($loan->repayment_cycle == 'bi_monthly') {
            $repayment_cycle = 'month';
            $loan->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' months')),
                'Y-m-d');
        }
        if ($loan->repayment_cycle == 'quarterly') {
            $repayment_cycle = 'month';
            $loan->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' months')),
                'Y-m-d');
        }
        if ($loan->repayment_cycle == 'semi_annually') {
            $repayment_cycle = 'month';
            $loan->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' months')),
                'Y-m-d');
        }
        if ($loan->repayment_cycle == 'annually') {
            $repayment_cycle = 'year';
            $loan->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' years')),
                'Y-m-d');
        }
        $loan->save();    

        $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','added a loan with code:'.$loan->loan_code);

        return redirect()->route('loan.index')->with('success','Loan created awaiting approval');

    // }else{

    //     return redirect()->back()->with('error','insuffient customer balance...please credit customer account to continue');

    // }
   
    $lock->release();

    }//lock
 }

    public function edit($id){
        return view('loan.edit_loans')->with('loanprod', LoanProduct::all())
                                        ->with('getofficers',Accountofficer::all())
                                          ->with('loanfees',LoanFee::all())
                                           ->with('sectors',Sector::all())
                                    ->with('edl',Loan::findorfail($id));
    }

    public function update(Request $request,$id){

        $this->logInfo("updating loan",$request->all());
        
        $this->validate($request,[
            'principal' => ['required','string','gt:0'],
            'sector' => ['required','string'],
            'loan_product' => ['required','string'],
            'loan_duration' => ['required','string'],
            'loan_duration_type' => ['required','string'],
            'equity' => ['required','string'],
            'purpose' => ['required','string'],
            'repayment_cycle' => ['required','string'],
            'release_date' => ['required','string'],
            'interest_method' => ['required','string'],
            'interest_rate' => ['required','string'],
            'interest_period' => ['required','string'],
            'officer' => ['required','string'],
        ]);

        $loan = Loan::findorfail($id);

        if($request->hasFile('files')){
            if(file_exists($loan->files)){
                unlink($loan->files);
            }
           $file =  $request->file('files');
                $newfilevalue = time()."_".$file->getClientOriginalName();
                $file->move('uploads',$newfilevalue);
                $loan->files = 'uploads/'.$newfilevalue;
        }

        $loan->update([
            'loan_product_id' => $request->loan_product,
            'release_date' => $request->release_date,
            'first_payment_date' => !empty($request->first_payment_date) ? $request->first_payment_date : null,
            'accountofficer_id' => $request->officer,
             'principal' => $request->principal,
             'balance' => $request->principal,
             'interest_method' => $request->interest_method,
             'interest_rate' => $request->interest_rate,
             'equity' => $request->equity,
             'interest_period' => $request->interest_period,
             'loan_duration' => $request->loan_duration,
             'loan_duration_type' => $request->loan_duration_type,
             'repayment_cycle' => $request->repayment_cycle,
             'override_interest' => $request->override_interest,
             'override_interest_amount' => $request->override_interest_amount,
             'grace_on_interest_charged' => $request->grace_on_interest_charged,
             'applied_amount' => $request->principal,
             'description' => $request->description,
             'sector_id' => $request->sector,
         ]);
     
         
         if(!empty($request->loanfees)){
             foreach($request->loanfees as $key => $loanfee){
               $loanmeta = LoanFeeMeta::create([
                     'user_id' => Auth::user()->id,
                     'parent_id' => $loan->id,
                     'loan_fee_id' => $loanfee,
                     'category' => 'loan',
                     'value' => !empty($request->loan_fees_amount[$key]) ? $request->loan_fees_amount[$key] : '0',
                     'loan_fees_schedule' => !empty($request->loan_fees_schedule[$key]) ? $request->loan_fees_schedule[$key] : ($request->loan_fees_amount[$key] == '0' || empty($request->loan_fees_amount[$key]) ? 'charge_fees_on_first_payment' : '')
                 ]);
     }
  }
         
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

     $usern = Auth::user()->last_name." ".Auth::user()->first_name;
     $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','updated a loan with code:'.$loan->loan_code);
     
     return redirect()->route('loan.index')->with('success','Loan Updated');
    }
    
    public function delete($id){
         $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loandel = Loan::findorfail($id);
        
        if($loandel->status == 'disbursed'){

            return redirect()->back()->with('error','Loan already Disburse and can\'t be deleted');
            
        }else{
            
        if(file_exists($loandel->files)){
            unlink($loandel->files);
        }
        $loandel->delete();

        $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','deleted a loan with code:'.$loandel->loan_code);

        return redirect()->route('loan.index')->with('success','Loan Deleted');
        
        }
    }

public function ViewLoanStatement(){
 
    if(request()->filter == true){

                $searchTerm = request()->londetails;
        
                if(!is_numeric($searchTerm)){
                    return redirect()->route('loan.statement')->with('error','Loan Account No must a be number');
                }

               $ldata = Loan::where('loan_code', $searchTerm)->first();

        if($ldata){
             $payments = LoanRepayment::where('loan_id', $ldata->id)->get();
        }else{
             $payments = [];
        }

         return view('loan.view_loan_statement')->with('payments',$payments)
                                                 ->with('loan',$ldata);

        }else{
            return view('loan.view_loan_statement');
        }
    }

    public function pdf_schedule($id)
    {

            $getsetvalue = new Setting();
            $schedules = LoanSchedule::where('loan_id', $id)->orderBy('due_date', 'asc')->get();
            $loans = Loan::findorfail($id);
            $data = [
                'title' => $getsetvalue->getsettingskey('company_name')." Loan BreakDown",
                'date' => date('m/d/Y'),
                'loan' => $loans,
                'schedules' => $schedules
            ];
            
            $pdf = PDF::loadView("loan.pdf_schedule", $data);
            return $pdf->download(ucfirst($loans->customer->title)." ".$loans->customer->first_name." ".$loans->customer->last_name." - Loan Repayment Schedule.pdf");

    }

    public function print_schedule($id)
    {
        $schedules = LoanSchedule::where('loan_id', $id)->orderBy('due_date', 'asc')->get();
        $loans = Loan::findorfail($id);
        return view('loan.print_schedule')->with('loan',$loans)
                                         ->with('schedules',$schedules);
    }

    public function print_offer_letter($id)
    {
        $charges = Charge::where('chargename','Transfer Charge')->first();
        $schedules = LoanSchedule::where('loan_id', $id)->orderBy('due_date', 'asc')->get();
        $loans = Loan::findorfail($id);
        return view('loan.print_offer')->with('loan',$loans)
                                       ->with('schedules',$schedules)
                                       ->with('charges',$charges)
                                       ->with('loanfees',LoanFee::with('loanfeemetas')->get());
    }

    // public function pdfLoanStatement($loan)
    // {
    //     $payments = LoanRepayment::where('loan_id', $loan->id)->orderBy('collection_date', 'asc')->get();
    //     PDF::AddPage();
    //     PDF::writeHTML(View::make('loan.pdf_loan_statement', compact('loan', 'payments'))->render());
    //     PDF::SetAuthor('Tererai Mugova');
    //     PDF::Output($loan->borrower->title . ' ' . $loan->borrower->first_name . ' ' . $loan->borrower->last_name . " - Loan Statement.pdf",
    //         'D');
    // }

    public function print_loan_statement($id)
    {
        $payments = LoanRepayment::where('loan_id', request()->loanid)->get();
        $getloan = Loan::where('id',request()->loanid)->where('customer_id', $id)->first();
        $lstloan = isset(request()->ty) && request()->ty == "lst" ? true : false; 

        return view('loan.print_loan_statement')->with('payments',$payments)
                                                 ->with('loan',$getloan)
                                                 ->with('lprintloanfrom',$lstloan);
    }

    public function pdf_download_Statement($id)
    {
        $getsetvalue = new Setting();
       
        if(isset(request()->loanid)){
            $payments = LoanRepayment::where('loan_id', request()->loanid)->get();
            $loans = Loan::where('customer_id', $id)
                          ->where('id',request()->loanid)
                          ->orderBy('release_date', 'asc')->first();
        }else{
            $loans = Loan::where('customer_id', $id)->orderBy('release_date', 'asc')->first();
            $payments = LoanRepayment::where('loan_id', $loans->id)->get();
        }
       
        $custm = Customer::findorfail($id);

         $lstloan = isset(request()->ty) && request()->ty == "lst" ? true : false; 

        $data = [
            'title' => $getsetvalue->getsettingskey('company_name')." Loan BreakDown",
            'date' => date('m/d/Y'),
            'loans' => $loans,
            'custm' => $custm,
            'payments' => $payments,
            'lprintloanfrom' => $lstloan
        ];
        
        $pdf = PDF::loadView("loan.pdf_customer_statement", $data);
        return $pdf->download(ucfirst($custm->title)." ".$custm->first_name." ".$custm->last_name." - Loan Statement.pdf");
      
    }

    public function email_customer_statement($id)
    {
                $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $getsetvalue = new Setting();
        $borrower = Customer::findorfail($id); 

        if (!empty($borrower->email)) {
            $body = $getsetvalue->getsettingskey('borrower_statement_email_template');

            $body = str_replace('{borrowerTitle}', $borrower->title, $body);
            $body = str_replace('{borrowerFirstName}', $borrower->first_name, $body);
            $body = str_replace('{borrowerLastName}', $borrower->last_name, $body);
            $body = str_replace('{borrowerAddress}', $borrower->residential_address, $body);
            $body = str_replace('{borrowerUniqueNumber}', $borrower->acctno, $body);
            $body = str_replace('{borrowerMobile}', $borrower->mobile, $body);
            $body = str_replace('{borrowerPhone}', $borrower->phone, $body);
            $body = str_replace('{borrowerEmail}', $borrower->email, $body);
            $body = str_replace('{loansPayments}', $this->customer_loans_total_paid($id), $body);
            $body = str_replace('{loansDue}',
                round($this->customer_loans_total_due($id), 2), $body);
            $body = str_replace('{loansBalance}',
                round(($this->customer_loans_total_due($id) - $this->customer_loans_total_paid($id)),
                    2), $body);
            $body = str_replace('{loanPayments}',$this->customer_loans_total_paid($id),$body);

            $loans = Loan::where('customer_id', $id)->orderBy('release_date', 'asc')->first();
            $payments = LoanRepayment::where('loan_id', $loans->id)->get();

            $data = [
                'title' => $getsetvalue->getsettingskey('company_name')." Loan BreakDown",
                'date' => date('m/d/Y'),
                'loans' => $loans,
                'custm' => $borrower,
                'payments' => $payments,
            ];
            
            $pdf = PDF::loadView("loan.pdf_customer_statement", $data);
            //$content = $pdf->download()->getOriginalContent();
            $filename = time().'_customer_statement.pdf';
            $pdfcontent = $pdf->output();
            file_put_contents($filename,$pdfcontent);
           
            $getpdf_file = $filename;
            //(ucfirst($borrower->title)." ".$borrower->first_name." ".$borrower->last_name." - Client Statement.pdf");
            
            
            Mail::send(['html' => 'mails.sendmail'],[
                'msg' => $body,
                'type' => $getsetvalue->getsettingskey('borrower_statement_email_subject')
            ],function($mail)use($borrower,$getsetvalue,$getpdf_file){
                $mail->from($getsetvalue->getsettingskey('company_email'),ucwords($getsetvalue->getsettingskey('company_name')));
                 $mail->to($borrower->email);
                $mail->subject($getsetvalue->getsettingskey('borrower_statement_email_subject'));
                $mail->attach($getpdf_file);
            });
           
            unlink($getpdf_file);

            Email::create([
                'user_id' => Auth::user()->id,
                'branch_id' => $branch,
                'subject' => $getsetvalue->getsettingskey('borrower_statement_email_subject'),
                'message' => $body,
                'recipient' => $borrower->email,
            ]);

            return redirect()->back()->with("success","Statment successfully sent");
        } else {
            return redirect()->back()->with("error","Customer has no email set");
        }
    }
    

    public function print_customer_statement($id)
    {
        $loans = Loan::where('customer_id', $id)->orderBy('release_date', 'asc')->get();
        return view('loan.print_customer_statement')->with('loans',$loans);
    }


    public function loan_override(Request $request, $id)
    {
     $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

            $l = Loan::findorfail($id);
            $l->balance = $request->balance;
            $l->override = $request->override;
            $l->save();

            $usern = Auth::user()->last_name." ".Auth::user()->first_name;
           $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Override balance for loan with code:'.$l->loan_code);

            return redirect()->back()->with('success','Loan Balance Override');
    }

    public function approve(Request $request, $id)
    {
        
    $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loan = Loan::findorfail($id);
        $loan->status = 'approved';
        $loan->approved_date = $request->approved_date;
        $loan->approved_notes = $request->approved_notes;
        $loan->approved_by_id = Auth::user()->id;
        $loan->approved_amount = $request->approved_amount;
        $loan->principal = $request->approved_amount;
        $loan->save();

        $this->logInfo("loan approve",$loan);

        $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Approved a loan with code:'.$loan->loan_code);

        return redirect()->back()->with('Loan Approved');
    }
    
    public function unapprove($id)
    {
                $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loan = Loan::findorfail($id);
        $loan->status = 'pending';
        $loan->save();
        
        $this->logInfo("loan unapprove",$loan);

        $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Unapproved a loan with code:'.$loan->loan_code);

        return redirect()->back()->with('Loan Unapproved');
    }

    public function disburse(Request $request, $id)
    {
        $lock = Cache::lock('lonappv-'.$id,3);
         
        try {
            
            $lock->block(2);

            DB::beginTransaction();

        $this->logInfo("loan disbursed",$request->all());
        
    $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
      
    $usern = Auth::user()->last_name." ".Auth::user()->first_name;
       
    $trxref = $this->generatetrnxref("L");

    $loan = Loan::findorfail($id);
    
    $customeracct = Saving::lockForUpdate()->where('customer_id',$loan->customer_id)->first();
    $customer = Customer::where('id',$loan->customer_id)->first();
    
    $loanprod = LoanProduct::select('gl_code','interest_gl','incomefee_gl')->where('id',$loan->loan_product_id)->first();

    if(empty($loanprod->gl_code) || empty($loanprod->interest_gl) || empty($loanprod->incomefee_gl)){
        return redirect()->back()->with('error', 'Loan product GLs is required');
    }

    $glacctmloan = GeneralLedger::select('id','gl_name','status','account_balance')
                                ->where('gl_code',$loanprod->gl_code)
                                 ->lockForUpdate()->first();

    // $glacctmicro = GeneralLedger::select('id','status','account_balance')->where('gl_code',"10739869")->first();
    // $glacctsme = GeneralLedger::select('id','status','account_balance')->where('gl_code',"10156223")->first();
    //$glacctstaff = GeneralLedger::select('id','status','account_balance')->where('gl_code',"10297264")->first();
    
    $glsavingdacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','20993097')->lockForUpdate()->first();
    $glcurrentacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','20639526')->lockForUpdate()->first();
    $glacctloanfeeincm = GeneralLedger::select('id','status','account_balance')->where("gl_code",$loanprod->incomefee_gl)->lockForUpdate()->first();

    if($loan->principal >= '500'){

            //delete previously created schedules and payments
        LoanSchedule::where('loan_id', $id)->delete();
        LoanRepayment::where('loan_id', $id)->delete();

        $interest_rate = $this->determine_interest_rate($id);
        $period = $this->loan_period($id);

        if ($loan->repayment_cycle == 'daily') {
            $repayment_cycle = '1 days';
            $repayment_type = 'days';
        }
        if ($loan->repayment_cycle == 'weekly') {
            $repayment_cycle = '1 weeks';
            $repayment_type = 'weeks';
        }
        if ($loan->repayment_cycle == 'monthly') {
            $repayment_cycle = 'month';
            $repayment_type = 'months';
        }
        if ($loan->repayment_cycle == 'bi_monthly') {
            $repayment_cycle = '2 months';
            $repayment_type = 'months';
        }
        if ($loan->repayment_cycle == 'quarterly') {
            $repayment_cycle = '4 months';
            $repayment_type = 'months';
        }
        if ($loan->repayment_cycle == 'semi_annually') {
            $repayment_cycle = '6 months';
            $repayment_type = 'months';
        }
        if ($loan->repayment_cycle == 'annually') {
            $repayment_cycle = '1 years';
            $repayment_type = 'years';
        }
        if (empty($request->first_payment_date)) {
            $first_payment_date = date_format(date_add(date_create($request->disbursed_date),
                date_interval_create_from_date_string($repayment_cycle)),
                'Y-m-d');
        } else {
            $first_payment_date = $request->first_payment_date;
        }

        // $loan->maturity_date = date_format(date_add(date_create($first_payment_date),
        //     date_interval_create_from_date_string($period . ' ' . $repayment_type)),'Y-m-d');

       

        $fees_distribute = 0;
        $fees_first_payment = 0;
        $fees_last_payment = 0;
        $loan_fee = 0;
        $lofee = 0;
        $loanfeetype ="";
        
        foreach (LoanFee::all() as $key) {
            if (!empty(LoanFeeMeta::where('loan_fee_id', $key->id)
                                    ->where('parent_id', $loan->id)
                                    ->where('category','loan')->first())
            ) {
                $loanfee = LoanFeeMeta::where('loan_fee_id', $key->id)
                                        ->where('parent_id',$loan->id)
                                       ->where('category','loan')->first();

                    //$loan_fee += $loanfee->value;
                    $loanfeetype = $key->loan_fee_type;
                      $loan_fee = $loanfeetype == 'percentage' ? ($loanfee->value/100)*$loan->principal : $loanfee->value;

                      $lofee += $loan_fee;

                    $glacctloanmgtfee = GeneralLedger::select('id','status','account_balance')
                                                        ->where("gl_code",$key->gl_code)
                                                        ->first();
            if(!empty($glacctloanmgtfee)){

                 if($loan_fee > 0){
                    if($glacctloanmgtfee->status == "1"){
                        $this->gltransaction('withdrawal', $glacctloanmgtfee,$loan_fee,null);  
                        $this->create_saving_transaction_gl(Auth::user()->id,$glacctloanmgtfee->id,$branch, $loan_fee,'credit','core',$trxref,$this->generatetrnxref('lsbm'),$glacctmloan->gl_name.'--'.$loan->loan_code,'approved',$usern,'');
                    }
                 }
            }else{
                 return redirect()->back()->with('error', 'Loan fee GL is required');
            }                //determine amount to use
                // if ($key->loan_fee_type == 'fixed') {
                //     if ($loan_fee->loan_fees_schedule == 'distribute_fees_evenly') {
                //         $fees_distribute = $fees_distribute + $loan_fee->value;
                //     }
                //     if ($loan_fee->loan_fees_schedule == 'charge_fees_on_first_payment') {
                //         $fees_first_payment = $fees_first_payment + $loan_fee->value;
                //     }
                //     if ($loan_fee->loan_fees_schedule == 'charge_fees_on_last_payment') {
                //         $fees_last_payment = $fees_last_payment + $loan_fee->value;
                //     }
                // } else {
                //     if ($loan_fee->loan_fees_schedule == 'distribute_fees_evenly') {
                //         $fees_distribute = $fees_distribute + ($loan_fee->value * $loan->principal / 100);
                //     }
                //     if ($loan_fee->loan_fees_schedule == 'charge_fees_on_first_payment') {
                //         $fees_first_payment = $fees_first_payment + ($loan_fee->value * $loan->principal / 100);
                //     }
                //     if ($loan_fee->loan_fees_schedule == 'charge_fees_on_last_payment') {
                //         $fees_last_payment = $fees_last_payment + ($loan_fee->value * $loan->principal / 100);
                //     }
                // }
            }

        }   

        //generate schedules until period finished
        $next_payment = $first_payment_date;
        $duedate = "";
        $balance = $loan->principal;
        for ($i = 1; $i <= $period; $i++) {
            $fees = 0;
            // if ($i == 1) {
            //     $fees = $fees + ($fees_first_payment);
            // }
            // if ($i == $period) {
            //     $fees = $fees + ($fees_last_payment);
            // }
            // $fees = $fees + ($fees_distribute / $period);

            $loan_schedule = new LoanSchedule();
            $loan_schedule->loan_id = $loan->id;
            $loan_schedule->fees = $fees;
            $loan_schedule->branch_id = $branch;
            $loan_schedule->customer_id = $loan->customer_id;
            $loan_schedule->description = 'repayment';
            $loan_schedule->due_date = $next_payment;
            //determine which method to use
            $due = 0;
            //reducing balance equal installments
            if ($loan->interest_method == 'declining_balance_equal_installments') {
                $due = $this->amortized_monthly_payment($loan->id, $loan->principal);

                if ($loan->decimal_places == 'round_off_to_two_decimal') {
                    //determine if we have grace period for interest

                    $interest = round(($interest_rate * $balance), 2);
                    $loan_schedule->principal = round(($due - $interest), 2);
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest, 2);
                    }
                    $loan_schedule->due = round($due, 2);
                    //determine next balance
                    $balance = round(($balance - ($due - $interest)), 2);
                    $loan_schedule->principal_balance = round($balance, 2);
                } else {
                    //determine if we have grace period for interest

                    $interest = round(($interest_rate * $balance));
                    $loan_schedule->principal = round(($due - $interest));
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest);
                    }
                    $loan_schedule->due = round($due);
                    //determine next balance
                    $balance = round(($balance - ($due - $interest)));
                    $loan_schedule->principal_balance = round($balance);
                }


            }
            //reducing balance equal principle
            if ($loan->interest_method == 'declining_balance_equal_principal') {
                $principal = $loan->principal / $period;
                if ($loan->decimal_places == 'round_off_to_two_decimal') {

                    $interest = round(($interest_rate * $balance), 2);
                    $loan_schedule->principal = round($principal, 2);
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest, 2);
                    }
                    $loan_schedule->due = round(($principal + $interest), 2);
                    //determine next balance
                    $balance = round(($balance - $principal), 2);
                    $loan_schedule->principal_balance = round($balance, 2);
                } else {

                    $loan_schedule->principal = round(($principal));

                    $interest = round(($interest_rate * $balance));
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest);
                    }
                    $loan_schedule->due = round($principal + $interest);
                    //determine next balance
                    $balance = round(($balance - $principal));
                    $loan_schedule->principal_balance = round($balance);
                }

            }
            //flat  method
            if ($loan->interest_method == 'flat_rate') {
                $principal = $loan->principal / $period;
                if ($loan->decimal_places == 'round_off_to_two_decimal') {
                    $interest = round(($interest_rate * $loan->principal), 2);
                    $loan_schedule->principal = round(($principal), 2);
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest, 2);
                    }
                    $loan_schedule->principal = round(($principal), 2);
                    $loan_schedule->due = round(($principal + $interest), 2);
                    //determine next balance
                    $balance = round(($balance - $principal), 2);
                    $loan_schedule->principal_balance = round($balance, 2);
                } else {
                    $interest = round(($interest_rate * $loan->principal));
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest);
                    }
                    $loan_schedule->principal = round($principal);
                    $loan_schedule->due = round($principal + $interest);
                    //determine next balance
                    $balance = round(($balance - $principal));
                    $loan_schedule->principal_balance = round($balance);
                }
            }
            //interest only method
            if ($loan->interest_method == 'interest_only') {
                if ($i == $period) {
                    $principal = $loan->principal;
                } else {
                    $principal = 0;
                }
                if ($loan->decimal_places == 'round_off_to_two_decimal') {
                    $interest = round(($interest_rate * $loan->principal), 2);
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest, 2);
                    }
                    $loan_schedule->principal = round(($principal), 2);
                    $loan_schedule->due = round(($principal + $interest), 2);
                    //determine next balance
                    $balance = round(($balance - $principal), 2);
                    $loan_schedule->principal_balance = round($balance, 2);
                } else {
                    $interest = round(($interest_rate * $loan->principal));
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest);
                    }
                    $loan_schedule->principal = round($principal);
                    $loan_schedule->due = round($principal + $interest);
                    //determine next balance
                    $balance = round(($balance - $principal));
                    $loan_schedule->principal_balance = round($balance);
                }
            }
            //determine next due date
            if ($loan->repayment_cycle == 'daily') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('1 days')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'weekly') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('1 weeks')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'monthly') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('1 months')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'bi_monthly') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('2 months')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'quarterly') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('4 months')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'semi_annually') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('6 months')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'annually') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('1 years')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($i == $period) {
                $loan_schedule->principal_balance = round($balance);
            }
            $duedate = $next_payment;
            $loan_schedule->save();
        }

        $notes = !empty($request->disbursed_notes) ? $request->disbursed_notes."--".$loan->loan_code : "loan disbursed --".$loan->loan_code;
      
        $duedate = LoanSchedule::findorfail($loan_schedule->id);

        $loan->status = 'disbursed';
        $loan->disbursed_by = $request->disbursed_by;
        $loan->disbursed_notes = $notes;
        $loan->first_payment_date = $first_payment_date;
        $loan->maturity_date = $duedate->due_date;
        $loan->disbursed_by_id = Auth::user()->id;
        $loan->disbursed_date = $request->disbursed_date;
        $loan->release_date = $request->disbursed_date;
        $loan->save();
        
    
   //if($glacctmicro->status == '1' && $glacctsme->status == '1' && $glacctstaff->status == '1' && $glsavingdacct->status == '1' && $glcurrentacct->status == '1'){

        if($request->disbursed_by == "cash"){

            $loanprincipal = $customeracct->account_balance + $loan->principal;
            $customeracct->account_balance = $loanprincipal;
            $customeracct->save();

        $this->create_saving_transaction(Auth::user()->id,$loan->customer_id,$branch,$loan->principal,
                                         'deposit','core','0',null,null,null,null,$trxref,$notes,'approved','19','trnsfer',$usern);

        if($glacctmloan->status == "1"){

            $this->create_saving_transaction_gl(null,$glacctmloan->id,null, $loan->principal,'debit','core',$trxref,$this->generatetrnxref('sf'),'loan disbursed--'.$loan->loan_code,'approved',$usern);
            $this->gltransaction('withdrawal', $glacctmloan, $loan->principal,null);

        }

        // if($loan->loan_product_id == "7"){
        //     $this->create_saving_transaction_gl(null, $glacctstaff->id,null, $loan->principal,'debit','core',$trxref,$this->generatetrnxref('sf'),'staff loans--'.$loan->loan_code,'approved',$usern);
        //     $this->gltransaction('withdrawal', $glacctstaff, $loan->principal,null); 
        // }else{
        //     if($loan->principal >= '500' && $loan->principal <= '99000'){
        //         $this->create_saving_transaction_gl(null,$glacctmicro->id,null, $loan->principal,'debit','core',$trxref,$this->generatetrnxref('micro'),'micro loans--'.$loan->loan_code,'approved',$usern);
        //           $this->gltransaction('withdrawal',$glacctmicro,$loan->principal,null); 
        //       }elseif($loan->principal >= '99000'){
        //         $this->create_saving_transaction_gl(null,$glacctsme->id,null, $loan->principal,'debit','core',$trxref,$this->generatetrnxref('sme'),'business and sme loans--'.$loan->loan_code,'approved',$usern);
        //           $this->gltransaction('withdrawal',$glacctsme,$loan->principal,null); 
        //        }
        // }        
         
         if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id,$loan->principal,$trxref,'credit');
            }else{
                 //deposit into saving acct and current acct Gl
             if($glsavingdacct->status == '1'){//saving acct GL
                
            $this->gltransaction('withdrawal',$glsavingdacct,$loan->principal,null);
            $this->create_saving_transaction_gl(null,$glsavingdacct->id,null,$loan->principal,'credit','core',$trxref,$this->generatetrnxref('svgl'),'customer credit for loan--'.$loan->loan_code,'approved',$usern);
             }

            // }elseif($customer->account_type == '2'){//current acct GL
                
            //     $this->gltransaction('withdrawal',$glcurrentacct,$loan->principal,null);
            // $this->create_saving_transaction_gl(null,$glcurrentacct->id,null, $loan->principal,'credit','core',$trxref,$this->generatetrnxref('crgl'),'customer credit for loan--'.$loan->loan_code,'approved',$usern);
                
            // }
        }
            
            $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Disbursed a loan with code:'.$loan->loan_code);


            //$lofee = $loanfeetype == 'percentage' ? ($loan_fee/100)*$loan->principal : $loan_fee;

        if($lofee > 0){
            
            $trnxlonfee = $this->generatetrnxref('Lfee');

                $loanlofee = $customeracct->account_balance - $lofee;
                $customeracct->account_balance = $loanlofee;
                $customeracct->save();
    
            $this->create_saving_transaction(Auth::user()->id,$loan->customer_id,$branch,$lofee,
                                             'debit','core','0',null,null,null,null,$trnxlonfee,"loan fee debited--".$loan->loan_code,'approved','7','trnsfer',$usern);
               
         if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id,$lofee,$trxref,'debit');
        }else{
           // if($customer->account_type == '1'){//saving acct GL

                if($glsavingdacct->status == '1'){
                    $this->gltransaction('deposit',$glsavingdacct,$lofee,null);
                    $this->create_saving_transaction_gl(null,$glsavingdacct->id,$loan->branch_id,$lofee,'debit','core',$trnxlonfee,$this->generatetrnxref('svgl'),'customer debited for loan fee--'.$loan->loan_code,'approved',$usern);
                        }

                    // }elseif($customer->account_type == '2'){//current acct GL

                    //     if($glcurrentacct->status == '1'){
                    //     $this->gltransaction('deposit',$glcurrentacct,$lofee,null);
                    // $this->create_saving_transaction_gl(null,$glcurrentacct->id,$loan->branch_id,$lofee,'debit','core',$trnxlonfee,$this->generatetrnxref('crgl'),'customer debited for loan fee--'.$loan->loan_code,'approved',$usern);
                    //     } 

                    // }
                }

            //loan fee income
            // if($glacctloanfeeincm->status == '1'){
            //       $this->gltransaction('withdrawal',$glacctloanfeeincm,$lofee,null); 
            // $this->create_saving_transaction_gl(null,$glacctloanfeeincm->id,$loan->branch_id,$lofee,'credit','core',$trnxlonfee,$this->generatetrnxref('LF'),'loan fees--'.$loan->loan_code,'approved',$usern);
    
            // }
          
        }

        $insteret = $this->loan_total_interest($loan->id);
        $totlnamt = $loan->principal + $insteret;
        
        LoanRepayment::create([
            "user_id" => Auth::user()->id,
            "accountofficer_id" => !empty($acofficer) ? $acofficer->id : null,
            "amount" => $totlnamt,
            "loan_id" => $loan->id,
            "customer_id" => $loan->customer_id,
            "branch_id" => $branch,
            "repayment_method" => 'flat',
            "collection_date" => Carbon::now(),
            "notes" => 'loan disbursed--'.$loan->loan_code,
            "type" => 'debit',
            "due_date" => date("Y-m-d",strtotime($duedate->due_date)),
            "status" => '0'
        ]);

        DB::commit();

            return redirect()->back()->with('success','Loan Disbursed');
             
              
     }
    //else{
            
    //         $loanprincipal = $customeracct->account_balance + $loan->principal;
    //         $customeracct->account_balance = $loanprincipal;
    //         $customeracct->save();

    //     $this->create_saving_transaction(Auth::user()->id,$loan->customer_id,$branch,$loan->principal,
    //                                      'deposit','core','0',null,null,null,null,$trxref,$notes,'approved','19','trnsfer',$usern);
            
    //      if($loan->loan_product_id == "7"){

    //         $this->create_saving_transaction_gl(null, $glacctstaff->id,null, $loan->principal,'debit','core',$trxref,$this->generatetrnxref('sf'),'staff loans--'.$loan->loan_code,'approved',$usern);
    //         $this->gltransaction('withdrawal', $glacctstaff, $loan->principal,null); 
        
    //     }else{                                
              
    //         if($loan->principal >= '500' && $loan->principal <= '99000'){

    //             $this->create_saving_transaction_gl(null,$glacctmicro->id,null, $loan->principal,'debit','core',$trxref,$this->generatetrnxref('micro'),'micro loans--'.$loan->loan_code,'approved',$usern);
    //            $this->gltransaction('withdrawal',$glacctmicro,$loan->principal,null); 
          
    //         }elseif($loan->principal >= '99000'){
            
    //             $this->create_saving_transaction_gl(null,$glacctsme->id,null, $loan->principal,'debit','core',$trxref,$this->generatetrnxref('sme'),'business and sme loans--'.$loan->loan_code,'approved',$usern);
    //             $this->gltransaction('withdrawal',$glacctsme,$loan->principal,null); 

    //         }
    //     }

         
        
    //       if($customer->account_type == '1'){//saving acct GL
                
    //         $this->gltransaction('withdrawal',$glsavingdacct,$loan->principal,null);
    //         $this->create_saving_transaction_gl(null,$glsavingdacct->id,null,$loan->principal,'credit','core',$trxref,$this->generatetrnxref('svgl'),'customer credit for loan--'.$loan->loan_code,'approved',$usern);
                
    //         }elseif($customer->account_type == '2'){//current acct GL
                
    //             $this->gltransaction('withdrawal',$glcurrentacct,$loan->principal,null);
    //         $this->create_saving_transaction_gl(null,$glcurrentacct->id,null, $loan->principal,'credit','core',$trxref,$this->generatetrnxref('crgl'),'customer credit for loan--'.$loan->loan_code,'approved',$usern);
                
    //         }
        

    //         $lofee = $loanfeetype == 'percentage' ? ($loan_fee/100)*$loan->principal : $loan_fee;

    //         if($lofee > 0){
                
    //             $trnxlonfee = $this->generatetrnxref('Lfee');
    
    //                 $loanlofee = $customeracct->account_balance - $lofee;
    //                 $customeracct->account_balance = $loanlofee;
    //                 $customeracct->save();
        
    //             $this->create_saving_transaction(Auth::user()->id,$loan->customer_id,$branch,$lofee,
    //                                              'debit','core','0',null,null,null,null,$trnxlonfee,"loan fee debited--".$loan->loan_code,'approved','7','trnsfer',$usern);
                   
    //             if($customer->account_type == '1'){//saving acct GL
    
    //                 if($glsavingdacct->status == '1'){
    //                     $this->gltransaction('deposit',$glsavingdacct,$lofee,null);
    //                     $this->create_saving_transaction_gl(null,$glsavingdacct->id,$loan->branch_id,$lofee,'debit','core',$trnxlonfee,$this->generatetrnxref('svgl'),'customer debited for loan fee--'.$loan->loan_code,'approved',$usern);
    //                         }
    
    //                     }elseif($customer->account_type == '2'){//current acct GL
    
    //                         if($glcurrentacct->status == '1'){
    //                         $this->gltransaction('deposit',$glcurrentacct,$lofee,null);
    //                     $this->create_saving_transaction_gl(null,$glcurrentacct->id,$loan->branch_id,$lofee,'debit','core',$trnxlonfee,$this->generatetrnxref('crgl'),'customer debited for loan fee--'.$loan->loan_code,'approved',$usern);
    //                         } 
    
    //                     }
    //                     //loan fee income
    //                     $this->gltransaction('withdrawal',$glacctloanfeeincm,$lofee,null); 
    //                     $this->create_saving_transaction_gl(null,$glacctloanfeeincm->id,$loan->branch_id,$lofee,'credit','core',$trnxlonfee,$this->generatetrnxref('LF'),'loan fees--'.$loan->loan_code,'approved',$usern);
               
    //         }

    //         // $lonatrnx = $this->LoanBankTransfer($loan,$request->account_number,$request->bank,$request->recipient_name);

    //         // $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Disbursed a loan with code:'.$loan->loan_code);
            
    //         // if($lonatrnx['status'] == false){
    //         //     return redirect()->back()->with('error',$lonatrnx['message']);
    //         // }else{
    //         //     return redirect()->back()->with('success','Loan Disbursed and '.$lonatrnx['message']);
    //         // }
    //     }
        
    // }else{
    //      return redirect()->back()->with('success','inactive GL account');
    // }
        
    }else{
        return redirect()->back()->with('error','Loan Amount Low For Disbursement');
    }
       
} catch (LockTimeoutException $e) {

    DB::rollBack();

    $this->logInfo("DB loan disburse Error", $e->getMessage());

    return redirect()->back()->with('error',$e->getMessage());

} finally {
    optional($lock)->release();
}

    }

    public function undisburse($id)
    {
        DB::beginTransaction();

        $loan = Loan::findorfail($id);
        
        if($loan->disbursed_by == "transfer"){
            
           return redirect()->back()->with('error','Sorry loan cannot be undisbursed');

        }else{
            
        
        $this->logInfo("loan undisburse","");
        
      $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        //delete previously created schedules and payments
        LoanSchedule::where('loan_id', $id)->delete();
        LoanRepayment::where('loan_id', $id)->delete();

        
        $loan->status = 'approved';
        $loan->save();

        $trxref = $this->generatetrnxref("LW");
        
        $usern = Auth::user()->last_name." ".Auth::user()->first_name;

           $customer = Customer::where('id',$loan->customer_id)->first();

        $customeracct = Saving::lockForUpdate()->where('customer_id',$loan->customer_id)->first();

        $bal = $customeracct->account_balance - $loan->principal;
          $customeracct->account_balance = $bal;
          $customeracct->save();
        

        $this->create_saving_transaction(Auth::user()->id,$loan->customer_id,$branch,$loan->principal,
                                         'rev_deposit','web','0',null,null,null,null,$trxref,'disbured loan withdrawn','approved','19','trnsfer',$usern);

                                          
    $loanprod = LoanProduct::select('gl_code','interest_gl','incomefee_gl')->where('id',$loan->loan_product_id)->first();

    if(empty($loanprod->gl_code) || empty($loanprod->interest_gl) || empty($loanprod->incomefee_gl)){
        return redirect()->back()->with('error', 'Loan product GLs is required');
    }

    $glacctmloan = GeneralLedger::select('id','gl_name','status','account_balance')
                                ->where('gl_code',$loanprod->gl_code)
                                 ->lockForUpdate()->first();

    $glsavingdacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','20993097')->lockForUpdate()->first();
        
          $glacctmicro = GeneralLedger::select('id','status','account_balance')->where('gl_code',"10739869")->lockForUpdate()->first();
         $glacctsme = GeneralLedger::select('id','status','account_balance')->where('gl_code',"10156223")->lockForUpdate()->first();
             
     if($glacctmloan->status == "1"){

            $this->create_saving_transaction_gl(null,$glacctmloan->id,null, $loan->principal,'debit','core',$trxref,$this->generatetrnxref('sf'),'loan disbursed--'.$loan->loan_code,'approved',$usern);
            $this->gltransaction('withdrawal', $glacctmloan, $loan->principal,null);

        }


         if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id,$loan->principal,$trxref,'debit');
            }else{
                 //deposit into saving acct and current acct Gl
             if($glsavingdacct->status == '1'){//saving acct GL
                
            $this->gltransaction('deposit',$glsavingdacct,$loan->principal,null);
            $this->create_saving_transaction_gl(null,$glsavingdacct->id,null,$loan->principal,'debit','core',$trxref,$this->generatetrnxref('svgl'),'customer debited for loan--'.$loan->loan_code,'approved',$usern);
             }
        }

         $loan_fee = 0;
        $lofee = 0;
        $loanfeetype ="";
      
        foreach (LoanFee::all() as $key) {
            if (!empty(LoanFeeMeta::where('loan_fee_id', $key->id)
                                    ->where('parent_id', $loan->id)
                                    ->where('category','loan')->first())
            ) {
                $loanfee = LoanFeeMeta::where('loan_fee_id', $key->id)
                                        ->where('parent_id',$loan->id)
                                       ->where('category','loan')->first();

                    //$loan_fee += $loanfee->value;
                    $loanfeetype = $key->loan_fee_type;
                      $loan_fee = $loanfeetype == 'percentage' ? ($loanfee->value/100)*$loan->principal : $loanfee->value;

                    $glacctloanmgtfee = GeneralLedger::select('id','status','account_balance')
                                                        ->where("gl_code",$key->gl_code)
                                                        ->first();
            if(!empty($glacctloanmgtfee)){
                 if($loan_fee > 0){
                    if($glacctloanmgtfee->status == "1"){
                        $this->gltransaction('deposit', $glacctloanmgtfee,$loan_fee,null);  
                        $this->create_saving_transaction_gl(Auth::user()->id,$glacctloanmgtfee->id,$branch, $loan_fee,'debit','core',$trxref,$this->generatetrnxref('lsbm'),$glacctmloan->gl_name.'--'.$loan->loan_code,'approved',$usern,'');
                    }
                }
            }else{
                 return redirect()->back()->with('error', 'Loan fee GL is required');
            }     
            
            }

        }

        if($loan_fee > 0){
            
            $trnxlonfee = $this->generatetrnxref('Lfee');

                $loanlofee = $customeracct->account_balance + $loan_fee;
                $customeracct->account_balance = $loanlofee;
                $customeracct->save();
    
            $this->create_saving_transaction(Auth::user()->id,$loan->customer_id,$branch,$loan_fee,
                                             'credit','core','0',null,null,null,null,$trnxlonfee,"loan fee credit--".$loan->loan_code,'approved','7','trnsfer',$usern);
               
         if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id,$loan_fee,$trxref,'credit');
        }else{

                if($glsavingdacct->status == '1'){
                    $this->gltransaction('withdrawal',$glsavingdacct,$loan_fee,null);
                    $this->create_saving_transaction_gl(null,$glsavingdacct->id,$loan->branch_id,$loan_fee,'credit','core',$trnxlonfee,$this->generatetrnxref('svgl'),'customer credited for loan fee--'.$loan->loan_code,'approved',$usern);
                        }

                }
          
        }

        
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Undisbursed a loan with code:'.$loan->loan_code);

        DB::commit();

        return redirect()->back()->with('success','Loan Undisbursed');

        }

        DB::rollBack();
    }

    public function decline(Request $request, $id)
    {
                $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loan = Loan::findorfail($id);
        $loan->status = 'declined';
        $loan->declined_date = $request->declined_date;
        $loan->declined_notes = $request->declined_notes;
        $loan->declined_by_id = Auth::user()->id;
        $loan->save();

       $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Declined a loan with code:'.$loan->loan_code);

        return redirect()->back()->with('success','Loan Declined');
    }

    public function write_off(Request $request, $id)
    {
         $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loan = Loan::findorfail($id);

        $loan->status = 'written_off';
        $loan->written_off_date = $request->written_off_date;
        $loan->written_off_notes = $request->written_off_notes;
        $loan->written_off_by_id = Auth::user()->id;
        $loan->save();

        $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Writeoff a loan with code:'.$loan->loan_code);

        return redirect()->back()->with('success','Loan Writen Off');
    }

    public function unwrite_off($id)
    {
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loan = Loan::findorfail($id);
        $loan->status = 'disbursed';
        $loan->save();

        $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Unwriteoff a loan with code:'.$loan->loan_code);

        return redirect()->back()->with('success','Loan Unwriten Off');
    }

    public function loan_close($id)
    {
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loan = Loan::findorfail($id);
        $loan->status = 'closed';
        $loan->loan_status = 'fully_paid';
        $loan->closed_by_id = Auth::user()->id;
        $loan->closed_notes = 'loan closed';
        $loan->closed_date = Carbon::now();
        $loan->save();

      foreach(LoanSchedule::where('loan_id', $id)->where('closed',0)->get() as $loasch){
          
        $schedule = LoanSchedule::where('id',$loasch->id)->first();
        $schedule->update([
            "closed" => '1'
        ]);

        $totamot = $schedule->principal + $schedule->interest + $schedule->fee;
          
            // LoanRepayment::create([
            // "user_id" => Auth::user()->id,
            // "accountofficer_id" => !empty($loan->accountofficer_id) ? $loan->accountofficer_id : null,
            // "amount" => $totamot,
            // "loan_id" => $id,
            // "customer_id" => $loan->customer_id,
            // "branch_id" => $branch,
            // "repayment_method" => 'flat',
            // "collection_date" => Carbon::now(),
            // "notes" => 'loan repayment',
            // "due_date" => $schedule->due_date
            // ]);
          
       }

        $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','loan with code:'.$loan->loan_code.' has been close');

        return redirect()->back()->with('success','Loan closed');
    }
    
    public function withdraw(Request $request, $id)
    {
             $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $loan = Loan::findorfail($id);

        $loan->status = 'withdrawn';
        $loan->withdrawn_date = $request->withdrawn_date;
        $loan->withdrawn_notes = $request->withdrawn_notes;
        $loan->withdrawn_by_id = Auth::user()->id;
        $loan->save();

      $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Withdraw a loan with code:'.$loan->loan_code);

        return redirect()->back()->with('success','Loan Withdraw');
    }

    public function unwithdraw($id)
    {
            $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loan = Loan::findorfail($id);

        $loan->status = 'disbursed';
        $loan->save();
    
       $usern = Auth::user()->last_name." ".Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Unwithdraw a loan with code:'.$loan->loan_code);

        return redirect()->back()->with('success','Loan Unwithdraw');
    }

    public function reschedule(Request $request, $id)
    {
        $this->logInfo("loan reschdule",$request->all());

        $loan = Loan::findorfail($id);
        
    
        if ($request->type == 1) {
            $principal = $this->loan_total_principal($id) + $this->loan_total_interest($id) - $this->loan_paid_item($id,
                    'principal') - $this->loan_paid_item($id, 'interest');
        }
        if ($request->type == 2) {
            $principal = $this->loan_total_principal($id) + $this->loan_total_interest($id) + $this->loan_total_fees($id) - $this->loan_paid_item($id,
                    'principal') - $this->loan_paid_item($id, 'interest') - $this->loan_paid_item($id,'fees');
        }
        if ($request->type == 3) {
            $principal = $this->loan_total_balance($id);
        }
        
        return view('loan.reschedule')->with('getofficers',Accountofficer::all())
                                    ->with('loanfees',LoanFee::all())
                                    ->with('principal',$principal)
                                    ->with('loan',$loan)
                                ->with('loanprod', LoanProduct::all());
    }
    
     //edit loan schedule
     public function edit_schedule($id)
     {
         $rows = 0;
         $schedules = LoanSchedule::where('loan_id', $id)->orderBy('due_date', 'asc')->get();
         $loan = Loan::findorfail($id);
         return view('loan.edit_schedule')->with('schedules',$schedules)
                                        ->with('loan',$loan)
                                        ->with('rows',$rows);
         //compact('loan', 'schedules', 'rows'));
     }

     public function update_schedule(Request $request, $id)
    {
                $this->logInfo("update schedule",$request->all());

               $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

            //lets delete existing schedules
           // LoanSchedule::where('loan_id', $id)->delete();
            $loan = Loan::findorfail($id);
            if(!empty($request->scheduleid)){
                  foreach($request->scheduleid as $key => $value){
                
                if (empty($request->due_date[$key]) && empty($request->principal[$key]) && empty($request->interest[$key]) && empty($request->fees[$key]) && empty($request->penalty[$key])) {
                    return redirect()->back()->with('error','Some fields are empty');
                } elseif (empty($request->due_date)) {
                    return redirect()->back()->with('error','due date field is empty');
                } else {
                    LoanSchedule::where('id',$value)->update([
                     'due_date' => $request->due_date[$key],
                     'principal' => $request->principal[$key],
                     'description' => $request->description[$key],
                     'loan_id' => $id,
                    'customer_id' => $loan->customer_id,
                    'branch_id' => $branch,
                    'interest' => $request->interest[$key],
                    'fees' => $request->fees[$key],
                    'penalty' => $request->penalty[$key],
                    ]);
                 }
                }
            }else{
                  foreach($request->due_date as $key => $value){
                
                if (empty($value) && empty($request->principal[$key]) && empty($request->interest[$key]) && empty($request->fees[$key]) && empty($request->penalty[$key])) {
                    return redirect()->back()->with('error','Some fields are empty');
                } elseif (empty($request->due_date)) {
                    return redirect()->back()->with('error','due date field is empty');
                } else {
                    LoanSchedule::create([
                     'due_date' => $value,
                     'principal' => $request->principal[$key],
                     'description' => $request->description[$key],
                     'loan_id' => $id,
                    'customer_id' => $loan->customer_id,
                    'branch_id' => $branch,
                    'interest' => $request->interest[$key],
                    'fees' => $request->fees[$key],
                    'penalty' => $request->penalty[$key],
                    ]);
                 }
                }
            }
           

        
            $usern = Auth::user()->last_name." ".Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','Updated Schedule for loan with code:'.$loan->loan_code);
        
            return redirect()->route('loan.show',['id' => $id])->with('success','Schedule Updated');
    }

    public function email_loan_schedule($id)
    {
     $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $getsetvalue = new Setting();
        $loan = Loan::findorfail($id);
        $customer = Customer::where('id',$loan->customer_id)->first();
        if (!empty($customer->email)) {
            
            $body = $getsetvalue->getsettingskey('loan_schedule_email_template');
            $body = str_replace('{CustomerTitle}', $customer->title, $body);
            $body = str_replace('{CustomerFirstName}', $customer->first_name, $body);
            $body = str_replace('{CustomerLastName}', $customer->last_name, $body);
            $body = str_replace('{CustomerAddress}', $customer->residential_address, $body);
            $body = str_replace('{CustomerUniqueNumber}', $customer->acctno, $body);
            $body = str_replace('{CustomerMobile}', $customer->phone, $body);
            $body = str_replace('{CustomerPhone}', $customer->phone, $body);
            $body = str_replace('{CustomerEmail}', $customer->email, $body);
            $body = str_replace('{loanNumber}', $loan->loan_code, $body);
            $body = str_replace('{loanPayments}', $this->loan_total_paid($id), $body);
            $body = str_replace('{loanDue}',
                round($this->loan_total_due_amount($id), 2), $body);
            $body = str_replace('{loanBalance}',
                round(($this->loan_total_due_amount($id) - $this->loan_total_paid($id)),
                    2), $body);

            $schedules = LoanSchedule::where('loan_id', $id)->orderBy('due_date', 'asc')->get();

            $data = [
                'title' => $getsetvalue->getsettingskey('company_name')." Loan BreakDown",
                'date' => date('m/d/Y'),
                'loans' => $loan,
                'schedules' => $schedules,
                'custm' => $customer
            ];
            
            $pdf = PDF::loadView("loan.pdf_customer_statement", $data);
            //$content = $pdf->download()->getOriginalContent();
            $filename = time().'_loan_schedule.pdf';
            $pdfcontent = $pdf->output();
            file_put_contents($filename,$pdfcontent);
           
            $getpdf_file = $filename;
            //(ucfirst($borrower->title)." ".$borrower->first_name." ".$borrower->last_name." - Client Statement.pdf");
            
            
            Mail::send(['html' => 'mails.sendmail'],[
                'msg' => $body,
                'type' => $getsetvalue->getsettingskey('loan_statement_email_subject')
            ],function($mail)use($customer,$getsetvalue,$getpdf_file){
                $mail->from($getsetvalue->getsettingskey('company_email'),ucwords($getsetvalue->getsettingskey('company_name')));
                 $mail->to($customer->email);
                $mail->subject($getsetvalue->getsettingskey('loan_statement_email_subject'));
                $mail->attach($getpdf_file);
            });
           
            unlink($getpdf_file);

            Email::create([
                'user_id' => Auth::user()->id,
                'branch_id' => $branch,
                'subject' => $getsetvalue->getsettingskey('loan_statement_email_subject'),
                'message' => $body,
                'recipient' => $customer->email,
            ]);

            return redirect()->back()->with("success","Loan Statement successfully sent");
        } else {
            return redirect()->back()->with("error","Customer has no email set");
        }
    }

    public function reschedule_store(Request $request, $id)
    {
        DB::beginTransaction();

      $this->logInfo("creating reschedule",$request->all());

            $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $loan = Loan::findorfail($id);
        
        $loan->principal = $request->principal;
        $loan->interest_method = $request->interest_method;
        $loan->interest_rate = $request->interest_rate;
        $loan->branch_id = $branch;
        $loan->interest_period = $request->interest_period;
        $loan->loan_duration = $request->loan_duration;
        $loan->loan_duration_type = $request->loan_duration_type;
        $loan->repayment_cycle = $request->repayment_cycle;
        $loan->override_interest = $request->override_interest;
        $loan->override_interest_amount = $request->override_interest_amount;
        $loan->grace_on_interest_charged = $request->grace_on_interest_charged;
        $loan->customer_id = $request->customerid;
        $loan->applied_amount = $request->principal;
        $loan->user_id = Auth::user()->id;
        $loan->loan_product_id = $request->loan_product_id;
        $loan->release_date = $request->release_date;
        $loan->status = 'rescheduled';
        $loan->first_payment_date = !empty($request->first_payment_date) ? $request->first_payment_date : null;
        $loan->description = $request->description;

        if($request->hasFile('files')){
            $file =  $request->file('files');
                 $newfilevalue = time()."_".$file->getClientOriginalName();
                 $file->move('uploads',$newfilevalue);
                 $loan->files = 'uploads/'.$newfilevalue;
         }

        $loan->save();

        //save loan fees
        $fees_distribute = 0;
        $fees_first_payment = 0;
        $fees_last_payment = 0;
            
        if(!empty($request->loanfees)){
            foreach($request->loanfees as $key => $loanfee){
              $loanmeta = LoanFeeMeta::create([
                    'user_id' => Auth::user()->id,
                    'parent_id' => $loan->id,
                    'loan_fee_id' => $loanfee,
                    'category' => 'loan',
                    'value' => !empty($request->loan_fees_amount[$key]) ? $request->loan_fees_amount[$key] : '0',
                    'loan_fees_schedule' => !empty($request->loan_fees_schedule[$key]) ? $request->loan_fees_schedule[$key] : ($request->loan_fees_amount[$key] == '0' || empty($request->loan_fees_amount[$key]) ? 'charge_fees_on_first_payment' : '')
                ]);

                if ($request->loan_fees_type[$key] == 'fixed') {
                if ($loanmeta->loan_fees_schedule == 'distribute_fees_evenly') {
                    $fees_distribute = $fees_distribute + $loanmeta->value;
                }
                if ($loanmeta->loan_fees_schedule == 'charge_fees_on_first_payment') {
                    $fees_first_payment = $fees_first_payment + $loanmeta->value;
                }
                if ($loanmeta->loan_fees_schedule == 'charge_fees_on_last_payment') {
                    $fees_last_payment = $fees_last_payment + $loanmeta->value;
                }
            } else {
                if ($loanmeta->loan_fees_schedule == 'distribute_fees_evenly') {
                    $fees_distribute = $fees_distribute + ($loanmeta->value * $loan->principal / 100);
                }
                if ($loanmeta->loan_fees_schedule == 'charge_fees_on_first_payment') {
                    $fees_first_payment = $fees_first_payment + ($loanmeta->value * $loan->principal / 100);
                }
                if ($loanmeta->loan_fees_schedule == 'charge_fees_on_last_payment') {
                    $fees_last_payment = $fees_last_payment + ($loanmeta->value * $loan->principal / 100);
                }
            }
    }
 }
        
        //lets create schedules here
        //determine interest rate to use

        $interest_rate = $this->determine_interest_rate($id);

        $period = $this->loan_period($id);

        $loan2 = Loan::findorfail($id);
        if ($loan2->repayment_cycle == 'daily') {
            $repayment_cycle = 'day';
            $loan2->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' days')),
                'Y-m-d');
        }
        if ($loan2->repayment_cycle == 'weekly') {
            $repayment_cycle = 'week';
            $loan2->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' weeks')),
                'Y-m-d');
        }
        if ($loan2->repayment_cycle == 'monthly') {
            $repayment_cycle = 'month';
            $loan2->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' months')),
                'Y-m-d');
        }
        if ($loan2->repayment_cycle == 'bi_monthly') {
            $repayment_cycle = 'month';
            $loan2->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' months')),
                'Y-m-d');
        }
        if ($loan2->repayment_cycle == 'quarterly') {
            $repayment_cycle = 'month';
            $loan2->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' months')),
                'Y-m-d');
        }
        if ($loan2->repayment_cycle == 'semi_annually') {
            $repayment_cycle = 'month';
            $loan2->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' months')),
                'Y-m-d');
        }
        if ($loan2->repayment_cycle == 'annually') {
            $repayment_cycle = 'year';
            $loan2->maturity_date = date_format(date_add(date_create($request->first_payment_date),
                date_interval_create_from_date_string($period . ' years')),
                'Y-m-d');
        }
        $loan2->save();

        //delete previously created schedules and payments
        LoanSchedule::where('loan_id', $id)->delete();
        LoanRepayment::where('loan_id', $id)->delete();

        $interest_rate = $this->determine_interest_rate($id);
        $period = $this->loan_period($id);

        $loan3 = Loan::findorfail($id);
        if ($loan3->repayment_cycle == 'daily') {
            $repayment_cycle = '1 days';
            $repayment_type = 'days';
        }
        if ($loan3->repayment_cycle == 'weekly') {
            $repayment_cycle = '1 weeks';
            $repayment_type = 'weeks';
        }
        if ($loan3->repayment_cycle == 'monthly') {
            $repayment_cycle = '1 month';
            $repayment_type = 'months';
        }
        if ($loan3->repayment_cycle == 'bi_monthly') {
            $repayment_cycle = '2 months';
            $repayment_type = 'months';

        }
        if ($loan3->repayment_cycle == 'quarterly') {
            $repayment_cycle = '4 months';
            $repayment_type = 'months';
        }
        if ($loan3->repayment_cycle == 'semi_annually') {
            $repayment_cycle = '6 months';
            $repayment_type = 'months';
        }
        if ($loan3->repayment_cycle == 'annually') {
            $repayment_cycle = '1 years';
            $repayment_type = 'years';
        }
        if (empty($request->first_payment_date)) {
            $first_payment_date = date_format(date_add(date_create($request->disbursed_date),
                date_interval_create_from_date_string($repayment_cycle)),
                'Y-m-d');
        } else {
            $first_payment_date = $request->first_payment_date;
        }
        $loan3->maturity_date = date_format(date_add(date_create($first_payment_date),
            date_interval_create_from_date_string($period . ' ' . $repayment_type)),
            'Y-m-d');
        $loan3->status = 'disbursed';
        $loan3->disbursed_notes = "Loan rescheduled from :".$loan->loan_code;
        $loan3->first_payment_date = $first_payment_date;
        $loan3->disbursed_by_id = Auth::user()->id;
        $loan3->disbursed_date = $request->release_date;
        $loan3->release_date = $request->release_date;
        $loan3->save();

        $fees_distribute = 0;
        $fees_first_payment = 0;
        $fees_last_payment = 0;

        foreach (LoanFee::all() as $key) {
            if (!empty(LoanFeeMeta::where('loan_fee_id', $key->id)->where('parent_id', $id)->where('category',
                'loan')->first())
            ) {
                $loan_fee = LoanFeeMeta::where('loan_fee_id', $key->id)->where('parent_id',
                    $id)->where('category',
                    'loan')->first();
                //determine amount to use
                if ($key->loan_fee_type == 'fixed') {
                    if ($loan_fee->loan_fees_schedule == 'distribute_fees_evenly') {
                        $fees_distribute = $fees_distribute + $loan_fee->value;
                    }
                    if ($loan_fee->loan_fees_schedule == 'charge_fees_on_first_payment') {
                        $fees_first_payment = $fees_first_payment + $loan_fee->value;
                    }
                    if ($loan_fee->loan_fees_schedule == 'charge_fees_on_last_payment') {
                        $fees_last_payment = $fees_last_payment + $loan_fee->value;
                    }
                } else {
                    if ($loan_fee->loan_fees_schedule == 'distribute_fees_evenly') {
                        $fees_distribute = $fees_distribute + ($loan_fee->value * $loan->principal / 100);
                    }
                    if ($loan_fee->loan_fees_schedule == 'charge_fees_on_first_payment') {
                        $fees_first_payment = $fees_first_payment + ($loan_fee->value * $loan->principal / 100);
                    }
                    if ($loan_fee->loan_fees_schedule == 'charge_fees_on_last_payment') {
                        $fees_last_payment = $fees_last_payment + ($loan_fee->value * $loan->principal / 100);
                    }
                }
            }

        }

        //generate schedules until period finished
        $next_payment = $first_payment_date;
        $balance = $loan->principal;

        for ($i = 1; $i <= $period; $i++) {
            $fees = 0;
            if ($i == 1) {
                $fees = $fees + ($fees_first_payment);
            }
            if ($i == $period) {
                $fees = $fees + ($fees_last_payment);
            }
            $fees = $fees + ($fees_distribute / $period);
            $loan_schedule = new LoanSchedule();
            $loan_schedule->loan_id = $id;
            $loan_schedule->fees = $fees;
            $loan_schedule->branch_id = $branch;
            $loan_schedule->customer_id = $loan->customer_id;
            $loan_schedule->description = 'repayment';
            $loan_schedule->due_date = $next_payment;
            
            //determine which method to use
            $due = 0;
            //reducing balance equal installments
            if ($loan->interest_method == 'declining_balance_equal_installments') {
                $due = $this->amortized_monthly_payment($loan->id, $loan->principal);

                $interest = round(($interest_rate * $balance));
                    $loan_schedule->principal = round(($due - $interest));
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest);
                    }
                    $loan_schedule->due = round($due);
                    //determine next balance
                    $balance = round(($balance - ($due - $interest)));
                    $loan_schedule->principal_balance = round($balance);


            }

            //reducing balance equal principle
            if ($loan->interest_method == 'declining_balance_equal_principal') {
                $principal = $loan->principal / $period;
                $loan_schedule->principal = round(($principal));

                    $interest = round(($interest_rate * $balance));
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest);
                    }
                    $loan_schedule->due = round($principal + $interest);
                    //determine next balance
                    $balance = round(($balance - $principal));
                    $loan_schedule->principal_balance = round($balance);

            }
            //flat  method
            if ($loan->interest_method == 'flat_rate') {
                $principal = $loan->principal / $period;

                $interest = round(($interest_rate * $loan->principal));
                if ($loan->grace_on_interest_charged >= $i) {
                    $loan_schedule->interest = 0;
                } else {
                    $loan_schedule->interest = round($interest);
                }
                $loan_schedule->principal = round($principal);
                $loan_schedule->due = round($principal + $interest);
                //determine next balance
                $balance = round(($balance - $principal));
                $loan_schedule->principal_balance = round($balance);
            }
            //interest only method
            if ($loan->interest_method == 'interest_only') {
                if ($i == $period) {
                    $principal = $loan->principal;
                } else {
                    $principal = 0;
                }
                $interest = round(($interest_rate * $loan->principal));
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_schedule->interest = 0;
                    } else {
                        $loan_schedule->interest = round($interest);
                    }
                    $loan_schedule->principal = round($principal);
                    $loan_schedule->due = round($principal + $interest);
                    //determine next balance
                    $balance = round(($balance - $principal));
                    $loan_schedule->principal_balance = round($balance);
            }
            //determine next due date
            if ($loan->repayment_cycle == 'daily') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('1 days')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'weekly') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('1 weeks')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'monthly') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('1 months')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'bi_monthly') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('2 months')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'quarterly') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('4 months')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'semi_annually') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('6 months')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($loan->repayment_cycle == 'annually') {
                $next_payment = date_format(date_add(date_create($next_payment),
                    date_interval_create_from_date_string('1 years')),
                    'Y-m-d');
                //$loan_schedule->due_date = $next_payment;
            }
            if ($i == $period) {
                $loan_schedule->principal_balance = round($balance);
            }
            $loan_schedule->save();
        }

        $loan4 = Loan::findorfail($id);
        $loan4->maturity_date = $next_payment;
        $loan4->save();
        
        $usern = Auth::user()->last_name." ".Auth::user()->first_name;

        $trxref = $this->generatetrnxref("L");
        $customeracct = Saving::lockForUpdate()->where('customer_id',$request->customerid)->first();
        
        $customeracct->account_balance += $loan->principal;
        $customeracct->save();

        $this->create_saving_transaction(Auth::user()->id,$request->customerid,$branch,$loan2->principal,
                                         'credit','web','0',null,null,null,null,$trxref,$request->disbursed_notes,'approved','1','trnsfer',$usern);

         
        $this->tracktrails(Auth::user()->id,$branch,$usern,'loan','disbursed loan via reschedule with loan code:'.$loan->loan_code);
      
        DB::commit();

        return redirect($request->return_url)->with('success','Loan Rescheduled');

        DB::rollBack();
    }
    
   
   
   public function validateMonnifyBalance($accountno,$amout){
    $response = [];
    
    $this->logInfo("check balance Url",$this->murl."v2/disbursements/wallet-balance?accountNumber=".$accountno);

    $authbasic = base64_encode($this->mapikey.":".$this->msercetkey);
       $checkbalanace = Http::withHeaders([
           "Authorization" => "Basic ".$authbasic
       ])->get($this->murl."v2/disbursements/wallet-balance?accountNumber=".$accountno)->json();
       
       $this->logInfo("validating monnify balance",$checkbalanace);
       //return $checkbalanace;
  
       if($checkbalanace["responseBody"]["availableBalance"] < $amout){
            $response = ["status" => false, 'message' => "Switcher Error... Please contact support"];
       }else{
            $response = ["status" => true,'message' => "Amount is Valid",];
       }
       return $response;
}

public function validateWirelessBalance($amout){
    //return $this->url."verification/get-wallet-balance";
     $response = [];
     
     $this->logInfo("check balance Url",$this->url."verification/get-wallet-balance");

        $checkbalanace = Http::withHeaders([
            "ApiKey" => $this->apikey
        ])->get($this->url."verification/get-wallet-balance")->json();
        
        $this->logInfo("validating wireless balance",$checkbalanace);
        //return $checkbalanace;
   
        if($checkbalanace["data"]["balance"] < $amout){
             $response = ["status" => false, 'message' => "Switcher Error... Please contact support"];
        }else{
             $response = ["status" => true,'message' => "Amount is Valid",];
        }
        return $response;
}

public function getoutstandingdata(){
        
        return view('loan.loan_outstanding')->with('outsanding',OutstandingLoan::with(['loan','customer'])->where('amount','!=','0')->get());
    }

 public function exportloandata(){

        //$branch = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;

        $filter = request()->filter == true ? true : false;
        $fxfilter = request()->fx_filter == "Null" ? null : request()->fx_filter;
        // $searchval = !empty(request()->searchval) ? request()->searchval : null;
        $status = !empty(request()->status) ? request()->status : null;

        return Excel::download(new LoanExport($filter,$fxfilter,$status), 'Loan.xlsx');

}

}//endclass
