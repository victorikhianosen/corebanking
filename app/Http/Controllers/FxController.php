<?php

namespace App\Http\Controllers;

use App\Http\Traites\AuditTraite;
use App\Http\Traites\SavingTraite;
use App\Http\Traites\UserTraite;
use App\Models\AccountCategory;
use App\Models\Accountofficer;
use App\Models\Customer;
use App\Models\Exchangerate;
use App\Models\Fxmgmt;
use App\Models\GeneralLedger;
use App\Models\Saving;
use App\Models\SavingsTransaction;
use App\Models\SavingsTransactionGL;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class FxController extends Controller
{
    use UserTraite;
    use AuditTraite;
    use SavingTraite;
    public function __construct()
    {
        $this->middleware('auth');
    }


    public function managefx_sales(){
        return view('fxmgt.managefx_sales')->with('sales',Fxmgmt::where('fxtype','sales')->get());
    }

    public function fx_sales_create(){
        return view('fxmgt.fxsales')->with('users',User::where('account_type','!=','system')->get())
                                    ->with('customers',Customer::whereNull('exchangerate_id')->get())
                                    ->with('currency',Exchangerate::all())
                                    ->with('getofficers',Accountofficer::all())
                                     ->with('incmgeneralledgers',GeneralLedger::select('id','gl_name')->where('gl_type','income')->where('status','1')->get())
                                    ->with('generalledgersnaira',GeneralLedger::select('id','gl_name')->where('gl_type','asset')->whereNull('currency_id')->where('status','1')->get())
                                    ->with('generalledgers',GeneralLedger::select('id','gl_name')->where('gl_type','asset')->whereNotNull('currency_id')->where('status','1')->get());
    }
    

    public function fx_sales_store(Request $r){

        try{

            DB::beginTransaction();

        $this->validate($r,[
            'transaction_date' => ['required','string'],
            'currency' => ['required','string'],
            'customer_name' => ['required','string'],
            'purchase_rate' => ['required','string'],
            'beneficiary' => ['required','string'],
            'amount' => ['required','string'],
            'sales_rate' => ['required','string'],
            'beneficiary_bank' => ['required','string'],
            'depositor' => ['required','string'],
            'bank_charge' => ['required','string'],
            'authoriser' => ['required','string'],
            'payment_mode' => ['required','string'],
        ]);

        $tref = $this->generatetrnxref('fx');
        $description = !empty($r->description) ? $r->description : "fx sales";
        $usern = Auth::user()->first_name." ".Auth::user()->last_name;
       

        Fxmgmt::create([
            'user_id' => $r->authoriser,
            'accountofficer_id' => $r->relation_officer,
            'exchangerate_id' => $r->exrate,
            'customer' => $r->customer_name,
            'purchase_exchange_rate' => $r->purchase_rate,
            'sales_exchange_rate' => $r->sales_rate,
            'naria_amount' => $r->naira_amount,
            'foreign_amount' => $r->amount,
            'sales_from' => $r->gldebit,//foreign currency
            'glcredit' => $r->glcredit,//foreign currency
            'fx_reference' => $tref,
            'payment_mode' => $r->payment_mode,
            'gldebitnaria' => $r->gldebitnaria,//naira
            'sales_paid_to' => !empty($r->customeid) ? $r->customeid : $r->glcreditnaria,//naira
            'sales_margin' => $r->sales_margin,
            'glmargin' => $r->glmargin,
            'debitglmargin' => $r->debitglmargin,
            'beneficiary' => $r->beneficiary,
            'beneficiary_bank' => $r->beneficiary_bank,
            'depositor' => $r->depositor,
            'swift_bank_charges' => $r->bank_charge,
            'description' => $description."--sales",
            'fxtype' => $r->fxtype,
            'initiated_by' => $usern,
            'status' => 'pending',
            'tranx_date' => $r->transaction_date
        ]);

            DB::commit();

        return ['status' => 'success', 'msg' => 'Record created'];

        }catch(\Exception $e){
            DB::rollBack();
            return ['status' => 'error', 'msg' => $e->getMessage()];
        }
    }

    //fx purchase
    public function managefx_purchase(){
        return view('fxmgt.managefx_purchase')->with('purchases',Fxmgmt::where('fxtype','purchase')->get());
        
    }

    public function fx_purchase_create(){
        return view('fxmgt.fxpurchase')->with('users',User::where('account_type','!=','system')->get())
                                    ->with('customers',Customer::all())
                                    ->with('currency',Exchangerate::all())
                                    ->with('getofficers',Accountofficer::all())
                                    ->with('generalledgers',GeneralLedger::select('id','gl_name')->where('gl_type','asset')->where('status','1')->get());
    }

    public function fx_purchase_store(Request $r){

        try{

            DB::beginTransaction();

        $this->validate($r,[
            'transaction_date' => ['required','string'],
            'currency' => ['required','string'],
            'exhchange_rate' => ['required','string'],
            'amount' => ['required','string'],
            'authoriser' => ['required','string'],
            'payment_mode' => ['required','string'],
        ]);

        $tref = $this->generatetrnxref('fx');
        $description = !empty($r->description) ? $r->description : "fx purchase";
        $usern = Auth::user()->first_name." ".Auth::user()->last_name;
       

        Fxmgmt::create([
            'user_id' => $r->authoriser,
            'accountofficer_id' => $r->account_officer,
            'exchangerate_id' => $r->exrate,
            'purchase_exchange_rate' => $r->exhchange_rate,
            'naria_amount' => $r->naira_amount,
            'foreign_amount' => $r->amount,
            'fx_reference' => $tref,
            'purchase_recieve_currency' => $r->gldebit,
            'purchase_naria_from' => !empty($r->customeid) ? $r->customeid : $r->glcredit,
            'payment_mode' => $r->payment_mode,
            'fee_amount' => $r->fees,
            'description' => $description."--purchase",
            'fxtype' => $r->fxtype,
            'initiated_by' => $usern,
            'status' => 'pending',
            'tranx_date' => $r->transaction_date
        ]);

       

        DB::commit();

        return ['status' => 'success', 'msg' => 'Record created'];

        }catch(\Exception $e){
            DB::rollBack();
            return ['status' => 'error', 'msg' => $e->getMessage()];
        }
    }

    public function fx_reversal(){
        global $chb; 
        global $cutm;
        if(request()->filter == true){
            $fxg = Fxmgmt::where('fx_reference',request()->reference)->where('fxtype',request()->rvtype)->first();
          
            if($fxg){
                if($fxg->payment_mode == "cash" || $fxg->payment_mode == "bank"){
                    $chb = SavingsTransactionGL::select('general_ledger_id')->where('slip',$fxg->fx_reference)->get();
                }elseif($fxg->payment_mode == "customer"){
                    $chb = DB::table('savings_transactions')->join('savings_transaction_g_l_s','savings_transactions.reference_no','savings_transaction_g_l_s.slip')
                                                            ->where('savings_transaction_g_l_s.slip',$fxg->fx_reference)
                                                            ->where('savings_transactions.reference_no',$fxg->fx_reference)
                                                            ->select('savings_transactions.customer_id As custid','savings_transaction_g_l_s.general_ledger_id AS glid')->get();
                }
                //return $chb;
                return view('fxmgt.fx_reversal')->with('rfx',$fxg)
                                                ->with('records',$chb);
            }else{
                return redirect(route('fx_reversal')."?fxrevtype=".request()->rvtype."&error=1");
            }
          
        }else{
            return view('fxmgt.fx_reversal');
        }
        
    }
    
    public function get_fx_details($id){

        $tabdata = "";
       $getdatails =  Fxmgmt::where('id',$id)->where('fxtype',request()->fxty)->first();

       if(request()->fxty == "sales"){

        $uid = $getdatails->sales_paid_to;
        $type = $getdatails->payment_mode == "customer" ? "customer" : "gl";

        $tabdata .= "<tr><td>Authorised By</td><td>".ucwords($getdatails->user->last_name." ".$getdatails->user->first_name)."</td></tr>
        <tr><td>Account Officer</td><td>".ucwords($getdatails->accountofficer ? $getdatails->accountofficer->full_name : "N/A")."</td></tr>>
        <tr><td>Naira Amount</td><td>".number_format($getdatails->naria_amount,2)."</td></tr>
        <tr><td>Foreign Amount</td><td>".number_format($getdatails->foreign_amount,2)."</td></tr>
        <tr><td>Purchased Rate</td><td>".number_format($getdatails->purchase_exchange_rate,2)."</td></tr>
        <tr><td>Sold Rate</td><td>".number_format($getdatails->sales_exchange_rate,2)."</td></tr>
        <tr><td>Sales Margin</td><td>".number_format($getdatails->sales_margin,2)."</td></tr>
        <tr><td>Purchased From</td><td>".$this->GetNameByGLCustomer($getdatails->sales_from,'gl')."</td></tr>
        <tr><td>Sales Paid To</td><td>".$this->GetNameByGLCustomer($uid,$type)."</td></tr>
        <tr><td>Beneficiary</td><td>".ucwords($getdatails->beneficiary)."</td></tr>
        <tr><td>Beneficiary Bank</td><td>".ucwords($getdatails->beneficiary_bank)."</td></tr>
        <tr><td>Bank Charge</td><td>".number_format($getdatails->swift_bank_charges,2)."</td></tr>
        <tr><td>Depositor</td><td>".ucwords($getdatails->depositor)."</td></tr>
        <tr><td>Payment Mode</td><td>".$getdatails->payment_mode."</td></tr>
        <tr><td>Description</td><td><p>".$getdatails->description."</p></td></tr>
        <tr><td>Transaction Date</td><td>".date('d-m-Y',strtotime($getdatails->tranx_date))."</td></tr>
        <tr><td>Initiated By</td><td>".ucwords($getdatails->initiated_by)."</td></tr>
        <tr><td>Approved By</td><td>".ucwords($getdatails->approved_by)."</td></tr>
        <tr><td>Status</td><td>".ucwords($getdatails->status)."</td></tr>";
       
       }elseif(request()->fxty == "purchase"){

        $uid = $getdatails->purchase_naria_from;
         $type = $getdatails->payment_mode == "customer" ? "customer" : "gl";

        $tabdata .= "<tr><td>Authorised By</td><td>".ucwords($getdatails->user->last_name." ".$getdatails->user->first_name)."</td></tr>
            <tr><td>Account Officer</td><td>".ucwords($getdatails->accountofficer ? $getdatails->accountofficer->full_name : "N/A")."</td></tr>
            <tr><td>Naira Amount</td><td>".number_format($getdatails->naria_amount,2)."</td></tr>
             <tr><td>Foreign Amount</td><td>".number_format($getdatails->foreign_amount,2)."</td></tr>
            <tr><td>Purchased Recieve From</td><td>".$this->GetNameByGLCustomer($getdatails->purchase_recieve_currency,'gl')."</td></tr>
            <tr><td>Purchase Naria from</td><td>".$this->GetNameByGLCustomer($uid,$type)."</td></tr>
              <tr><td>Payment Mode</td><td>".$getdatails->payment_mode."</td></tr>
            <tr><td>Description</td><td><p>".$getdatails->description."</p></td></tr>
            <tr><td>Transaction Date</td><td>".date('d-m-Y',strtotime($getdatails->tranx_date))."</td></tr>
             <tr><td>Initiated By</td><td>".ucwords($getdatails->initiated_by)."</td></tr>
             <tr><td>Approved By</td><td>".ucwords($getdatails->approved_by)."</td></tr>
             <tr><td>Status</td><td>".ucwords($getdatails->status)."</td></tr>"; 
       }

       return ["status" => "success", "msg" => "data fetched", "data" => $tabdata, "fxid" => route('fx_approve',['id' => $id]),'fxstatus' => $getdatails->status];
    }

    public function GetNameByGLCustomer($uid,$type){

        if($type == "gl"){
            $gl = GeneralLedger::where('id',$uid)->first();
            return $gl ? $gl->gl_name : "N/A";
        }elseif($type == "customer"){
            $cust = Customer::where('id',$uid)->first();
            return $cust ? $cust->first_name." ".$cust->last_name : "N/A";
        }

    }

    public function ApproveFX($id)
{
    DB::beginTransaction();

    try {
        $fxg = Fxmgmt::lockForUpdate()->find($id);

        if (!$fxg) {
            DB::rollBack();
            return ['status' => 'error', 'msg' => 'FX Transaction not found'];
        }

        $user = Auth::user();
        $usern = "{$user->first_name} {$user->last_name}";
      

        // Common GLs
        $glSavingAcct = GeneralLedger::lockForUpdate()->where('gl_code', '20993097')->first(); // savings GL
        $glCurrentAcct = GeneralLedger::lockForUpdate()->where('gl_code', '20639526')->first(); // current GL

        if ($fxg->fxtype == "sales") {

            $glAcctDbt = GeneralLedger::lockForUpdate()->find($fxg->sales_from);//foreign currency
            $glAcctf = GeneralLedger::lockForUpdate()->find($fxg->glcredit);//foreign currency

            $glAcctdbnaria = GeneralLedger::lockForUpdate()->find($fxg->gldebitnaria);//naira currency
            $glAcctcrnaria = GeneralLedger::lockForUpdate()->find($fxg->sales_paid_to);//naira currency

            $glAcctMargin = GeneralLedger::lockForUpdate()->find($fxg->glmargin);//naira sales margin
            $glAcctdebitMargin = GeneralLedger::lockForUpdate()->find($fxg->debitglmargin);//naira sales margin

            //$glAcctCr = GeneralLedger::lockForUpdate()->find($fxg->sales_paid_to);

            if (in_array($fxg->payment_mode, ['cash', 'bank'])) {


                if ($glAcctDbt && $glAcctDbt->status == '1') {
                    $this->gltransaction('withdrawal', $glAcctDbt, $fxg->amount, null);
                    $this->create_saving_transaction_gl(null, $glAcctDbt->id, null, $fxg->amount, 'debit', 'core', $fxg->fx_reference, $this->generatetrnxref('fxgl'), $fxg->description, 'approved', $usern);
                }
              

                if ($glAcctf && $glAcctf->status == '1') {
                    $this->gltransaction('deposit', $glAcctf, $fxg->amount, null);
                    $this->create_saving_transaction_gl(null, $glAcctf->id, null, $fxg->amount, 'credit', 'core', $fxg->fx_reference, $this->generatetrnxref('fxgl'), $fxg->description, 'approved', $usern);
                }


                if ($glAcctdbnaria && $glAcctdbnaria->status == '1') {
                    $this->gltransaction('withdrawal', $glAcctdbnaria, $fxg->naria_amount, null);
                    $this->create_saving_transaction_gl(null, $glAcctdbnaria->id, null, $fxg->naria_amount, 'debit', 'core', $fxg->fx_reference, 
                                                    $this->generatetrnxref('fxgl'), $fxg->description, 'approved', $usern);
                }


                if ($glAcctcrnaria && $glAcctcrnaria->status == '1') {
                    $this->gltransaction('deposit', $glAcctcrnaria, $fxg->naria_amount, null);
                    $this->create_saving_transaction_gl(null, $glAcctcrnaria->id, null, $fxg->naria_amount, 'credit', 'core', $fxg->fx_reference, 
                                        $this->generatetrnxref('fxgl'), $fxg->description, 'approved', $usern);
                }

            } elseif ($fxg->payment_mode === "customer") {

                $customerAcct = Saving::lockForUpdate()->where('customer_id', $fxg->sales_paid_to)->first();
                $customer = Customer::find($fxg->sales_paid_to);

               

                if ($customerAcct) {

                    $customerAcct->decrement('account_balance', $fxg->naria_amount);

                    $this->create_saving_transaction(null,$customer->id,null,$fxg->naria_amount,'debit','core','0',null,null,null,null,$fxg->fx_reference,$fxg->description,'approved','2','transfer',$usern);

                     if ($glAcctdbnaria && $glAcctdbnaria->status == '1') {
                        $this->gltransaction('deposit', $glAcctdbnaria, $fxg->naria_amount, null);
                        $this->create_saving_transaction_gl(null, $glAcctdbnaria->id, null, $fxg->naria_amount, 'credit', 'core', $fxg->fx_reference,           $this->generatetrnxref('fxgl'), $fxg->description, 'approved', $usern);
                    }


                      if (!is_null($customer->exchangerate_id)) {
                            $this->checkforeigncurrncy($customer->exchangerate_id, $fxg->naria_amount, $fxg->fx_reference, 'debit');
                        } else {
                            if ($glSavingAcct && $glSavingAcct->status == '1') {
                                $this->gltransaction('deposit', $glSavingAcct, $fxg->naria_amount, null);
                                $this->create_saving_transaction_gl(null, $glSavingAcct->id, null, $fxg->naria_amount, 'debit', 'core', $fxg->fx_reference, $this->generatetrnxref('svgl'), 'customer debited', 'approved', $usern);
                            }
                        }
                    
                }


            }


            //sale margin
            if ($glAcctdebitMargin && $glAcctdebitMargin->status == '1') {
                $this->gltransaction('withdrawal', $glAcctdebitMargin, $fxg->sales_margin, null);
                $this->create_saving_transaction_gl(null, $glAcctdebitMargin->id, null, $fxg->sales_margin, 'debit', 'core', $fxg->fx_reference, $this->generatetrnxref('fxgl'), $fxg->description, 'approved', $usern);
            }
            
            if ($glAcctMargin && $glAcctMargin->status == '1') {
                $this->gltransaction('withdrawal', $glAcctMargin, $fxg->sales_margin, null);
                $this->create_saving_transaction_gl(null, $glAcctMargin->id, null, $fxg->sales_margin, 'credit', 'core', $fxg->fx_reference, $this->generatetrnxref('fxgl'), $fxg->description, 'approved', $usern);
            }

            // else{
            //     DB::rollBack();
            //     return ['status' => 'error', 'msg' => ucwords($glAcctdebitMargin->gl_name).' GL Account is inactive'];
            // }

        }
        
        if($fxg->fxtype == "purchase"){
            // Purchase type
            $glAcctDbt = GeneralLedger::lockForUpdate()->find($fxg->purchase_recieve_currency);
            $glAcctCr = GeneralLedger::lockForUpdate()->find($fxg->purchase_naria_from);

            if (in_array($fxg->payment_mode, ['cash', 'bank'])) {

                if ($glAcctDbt && $glAcctDbt->status == '1') {
                    $this->gltransaction('deposit', $glAcctDbt, $fxg->amount, null);
                    $this->create_saving_transaction_gl(null, $glAcctDbt->id, null, $fxg->naria_amount, 'credit', 'core', $fxg->fx_reference, $this->generatetrnxref('fxpgl'), $fxg->description, 'approved', null);
                }else{
                    DB::rollBack();
                     return ['status' => 'error', 'msg' => ucwords($glAcctDbt->gl_name).' GL Account is inactive'];
                }

                if ($glAcctCr && $glAcctCr->status == '1') {
                    $this->gltransaction('withdrawal', $glAcctCr, $fxg->naria_amount, null);
                    $this->create_saving_transaction_gl(null, $glAcctCr->id, null, $fxg->naria_amount, 'debit', 'core', $fxg->fx_reference, $this->generatetrnxref('fxpgl'), $fxg->description, 'approved', null);
                }else{
                    DB::rollBack();
                     return ['status' => 'error', 'msg' => ucwords($glAcctCr->gl_name).' GL Account is inactive'];
                }

            } elseif ($fxg->payment_mode === "customer") {

                $customerAcct = Saving::lockForUpdate()->where('customer_id', $fxg->purchase_naria_from)->first();
                $customer = Customer::find($fxg->purchase_naria_from);

                if ($glAcctDbt && $glAcctDbt->status == '1') {
                    $this->gltransaction('withdrawal', $glAcctDbt, $fxg->amount, null);
                    $this->create_saving_transaction_gl(null, $glAcctDbt->id, null, $fxg->amount, 'debit', 'core', $fxg->fx_reference, $this->generatetrnxref('fxgl'), $fxg->description, 'approved', null);
                }else{
                    DB::rollBack();
                     return ['status' => 'error', 'msg' => ucwords($glAcctDbt->gl_name).' GL Account is inactive'];
                }

                if ($customerAcct) {

                    $customerAcct->increment('account_balance', $fxg->naria_amount);

                    $this->create_saving_transaction(
                        null,
                        $customer->id,
                        null,
                        $fxg->naria_amount,
                        'credit',
                        'core',
                        '0',
                        null,
                        null,
                        null,
                        null,
                        $fxg->fx_reference,
                        $fxg->description,
                        'approved',
                        '1',
                        'transfer',
                        $usern
                    );
                }

                if (!is_null($customer->exchangerate_id)) {
                    $this->checkforeigncurrncy($customer->exchangerate_id, $fxg->naria_amount, $fxg->fx_reference, 'credit');
                } else {
                    if ($glSavingAcct && $glSavingAcct->status == '1') {
                        $this->gltransaction('withdrawal', $glSavingAcct, $fxg->naria_amount, null);
                        $this->create_saving_transaction_gl(null, $glSavingAcct->id, null, $fxg->naria_amount, 'credit', 'core', $fxg->fx_reference, $this->generatetrnxref('svgl'), 'customer credited', 'approved', $usern);
                    }
                }
            }
        }

          $fxg->update([
            'status' => 'approved',
            'approved_by' => $usern,
        ]);

        DB::commit();

        return ['status' => 'success', 'msg' => 'FX Transaction Approved'];

    } catch (\Throwable $e) {
        DB::rollBack();
        $this->logInfo("approving fx transaction error", $e->getMessage() . "--" . $e->getLine());
        return ['status' => 'error', 'msg' => 'Error approving FX transaction'];
    }
}



    public function fx_reversal_store(Request $r){

        try{
           
            DB::beginTransaction();

        $fxg = Fxmgmt::where('fx_reference',$r->refere)
                        ->where('fxtype',$r->revstype)
                        ->where('rev_status','0')->first();

       if($fxg){

        $glacctdbt = GeneralLedger::select('id','status','account_balance')->where('id',$r->glacct1)->lockForUpdate()->first();
        $glacctcr = GeneralLedger::select('id','status','account_balance')->where('id',$r->glacct2)->lockForUpdate()->first();
        
        $glsavingdacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','20993097')->lockForUpdate()->first();//saving account gl
        $glcurrentacct = GeneralLedger::select('id','status','account_balance')->where('gl_code','20639526')->lockForUpdate()->first();//current account gl

        $tref = $this->generatetrnxref('fx');
        $usern = Auth::user()->first_name." ".Auth::user()->last_name;

        if($r->revstype == "sales"){
            if($fxg->payment_mode == "cash" || $fxg->payment_mode == "bank"){

                if($glacctdbt->status == '1'){
                    $this->gltransaction('deposit',$glacctdbt,$r->amount,null);
                    $this->create_saving_transaction_gl(null,$glacctdbt->id,null, $r->amount,'credit','core',$tref,$this->generatetrnxref('rvfxgl'),'fx sales reversal','approved',$usern);
                }
    
                if($glacctcr->status == '1'){
                    $this->gltransaction('withdrawal',$glacctcr,$r->amount,null); 
                    $this->create_saving_transaction_gl(null,$glacctcr->id,null, $r->amount,'debit','core',$tref,$this->generatetrnxref('rvfxgl'),'fx sales reversal','approved',$usern);
                    }

            }elseif($fxg->payment_mode == "customer"){

                $customeracct = Saving::lockForUpdate()->where('customer_id',$r->customerid)->first();
                $customer = Customer::where('id', $r->customerid)->first();
    
                if($glacctdbt->status == '1'){
                    $this->gltransaction('withdrawal',$glacctdbt,$r->amount,null);
                    $this->create_saving_transaction_gl(null,$glacctdbt->id,null, $r->amount,'debit','core',$tref,$this->generatetrnxref('rvfxgl'),'fx sales reversal','approved',$usern);
                }
    
                $dedu = $customeracct->account_balance + $r->amount;
                $customeracct->account_balance = $dedu;
                $customeracct->save();
                  
                  $this->create_saving_transaction(null,$r->customerid,null,$r->amount,
                                'credit','core','0',null,null,null,null,$tref,'fx sales reversal','approved','4','trnsfer',$usern);
    
                    //deposit into saving acct and current acct Gl
                    //if($customer->account_type == '1'){//saving acct GL
     if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id,$r->amount,$tref,'credit');
            }else{
                        if($glsavingdacct->status == '1'){
                            $this->gltransaction('withdrawal',$glsavingdacct,$r->amount,null);
                            $this->create_saving_transaction_gl(null,$glsavingdacct->id,null, $r->amount,'credit','core',$tref,$this->generatetrnxref('svgl'),'customer credited','approved',$usern);        
                        }
                    }
                    // }elseif($customer->account_type == '2'){//current acct GL

                    //     if($glcurrentacct->status == '1'){
                    //         $this->gltransaction('withdrawal',$glcurrentacct,$r->amount,null);
                    //         $this->create_saving_transaction_gl(null,$glcurrentacct->id,null, $r->amount,'credit','core',$tref,$this->generatetrnxref('crgl'),'customer credited','approved',$usern);
                    //     }
                    
                    // }
            }

            $fxg->rev_status = '1';
            $fxg->save();
            
            return ["status" => "success", "msg" => "Fx Sales Reversed"];

        }elseif($r->revstype == "purchase"){

            if($fxg->payment_mode == "cash" || $fxg->payment_mode == "bank"){

                if($glacctdbt->status == '1'){
                    $this->gltransaction('withdrawal',$glacctdbt,$r->amount,null);
                    $this->create_saving_transaction_gl(null,$glacctdbt->id,null, $r->amount,'debit','core',$tref,$this->generatetrnxref('rvfxpgl'),'fx purchase reversal','approved',$usern);
                }
    
                if($glacctcr->status == '1'){
                    $this->gltransaction('deposit',$glacctcr,$r->amount,null); 
                    $this->create_saving_transaction_gl(null,$glacctcr->id,null, $r->amount,'credit','core',$tref,$this->generatetrnxref('rvfxpgl'),'fx purchase reversal','approved',$usern);
                    }

            }elseif($fxg->payment_mode == "customer"){

                $customeracct = Saving::lockForUpdate()->where('customer_id',$r->customerid)->first();
                $customer = Customer::where('id', $r->customerid)->first();
    
                if($glacctdbt->status == '1'){
                    $this->gltransaction('deposit',$glacctdbt,$r->amount,null);
                    $this->create_saving_transaction_gl(null,$glacctdbt->id,null, $r->amount,'credit','core',$tref,$this->generatetrnxref('rvfxgl'),'fx purchase reversal','approved',$usern);
                }
    
                $dedamt = $customeracct->account_balance - $r->amount;
                $customeracct->account_balance = $dedamt;
                $customeracct->save();
                  
                  $this->create_saving_transaction(null,$r->customerid,null,$r->amount,
                                'debit','core','0',null,null,null,null,$tref,'fx purchase reversal','approved','3','trnsfer',$usern);
    
                    //deposit into saving acct and current acct Gl
                    //if($customer->account_type == '1'){//saving acct GL
                        if(!is_null($customer->exchangerate_id)){
                $this->checkforeigncurrncy($customer->exchangerate_id,$r->amount,$tref,'debit');
            }else{ 
                        if($glsavingdacct->status == '1'){
                            $this->gltransaction('deposit',$glsavingdacct,$r->amount,null);
                            $this->create_saving_transaction_gl(null,$glsavingdacct->id,null, $r->amount,'debit','core',$tref,$this->generatetrnxref('svgl'),'customer debited','approved',$usern);
                        }
                    }
    
                    // }elseif($customer->account_type == '2'){//current acct GL
                    //     if($glcurrentacct->status == '1'){
                    //         $this->gltransaction('deposit',$glcurrentacct,$r->amount,null);
                    //       $this->create_saving_transaction_gl(null,$glcurrentacct->id,null, $r->amount,'debit','core',$tref,$this->generatetrnxref('crgl'),'customer debited','approved',$usern);
                    //     }
                    // }
            }

            $fxg->rev_status = '1';
            $fxg->save();
            return ["status" => "success", "msg" => "Fx Purchase Reversed"];
        }

       }else{
        return ['status' => '0', 'msg' => 'FX Reversed Already'];
       }

       DB::commit();

         }catch(\Exception $e){
            DB::rollBack();
            return ['status' => 'error', 'msg' => $e->getMessage()];
        }
    }

    public function allrates(){
        return view('fxmgt.exchange_rate')->with('rates',Exchangerate::all())
                                            ->with('gls',GeneralLedger::where('account_category_id','80')->where('currency_id','!=',null)->orderBy('gl_name','ASC')->get());
      }
   
      public function add_update_rates(Request $r){
       $this->logInfo("adding and updating of exchange rates",$r->all());
   
       $this->validate($r,[
           'currency' => ['required','string'],
           'currency_rate' => ['required','string']
       ]);
   
       if($r->type == "create"){
   
           $bk = Exchangerate::Create([
           'currency' => $r->currency,
           'currency_rate' => $r->currency_rate,
          'currency_symbol' => $r->currency_symbol,
          'overdraftgl' => $r->overdraftgl
           ]); 
   
           return ['status' => 'success','msg' => 'Record Created Successfully'];
   
       }elseif($r->type == "update"){
   
           
           $bank = Exchangerate::where('id',$r->id)->first();
   
           $bank->currency = $r->currency;
           $bank->currency_rate = $r->currency_rate;
           $bank->currency_symbol = $r->currency_symbol;
           $bank->overdraftgl = $r->overdraftgl;
           $bank->save();
         
   
           return ['status' => 'success','msg' => 'Record Updated Successfully'];
       }
   
     }
}
