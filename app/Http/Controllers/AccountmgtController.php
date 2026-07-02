<?php

namespace App\Http\Controllers;

use App\Http\Traites\AuditTraite;
use App\Http\Traites\SavingTraite;
use App\Http\Traites\UserTraite;
use App\Models\AccountCategory;
use App\Models\AccountType;
use App\Models\Capital;
use App\Models\Customer;
use App\Models\Email;
use App\Models\Exchangerate;
use App\Models\GeneralLedger;
use App\Models\OutstandingLoan;
use App\Models\Saving;
use App\Models\SavingsTransaction;
use App\Models\SavingsTransactionGL;
use App\Models\Setting;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use session;

class AccountmgtController extends Controller
{
    use SavingTraite;
    use AuditTraite;
    use UserTraite;

    public function __construct()
    {
        $this->middleware('auth');
    }

    public function account_type()
    {
        return view('accountmgt.manage_accounttype')->with('actyps', AccountType::all());
    }

    public function manage_gl_trans()
    {
        if (request()->filter == true) {
            $savtransgl = SavingsTransactionGL::whereBetween('created_at', [request()->datefrom, request()->dateto])
                ->orderBy('id', 'DESC')->take(100)->get();
        } else {
            $savtransgl = SavingsTransactionGL::orderBy('id', 'DESC')->take(100)->get();
        }

        return view('accountmgt.manage_gl_transaction')->with('data', $savtransgl);
    }

    public function update_accountcode(Request $r, $id)
    {
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;

        $upacd = AccountType::findorfail($id);
        $upacd->code = $r->ac_code;
        $upacd->save();

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'account type', 'updated account type code');

        return redirect()->route('actype')->with('success', 'account code updated');
    }

    public function account_category_index()
    {
        return view('accountmgt.category.index')->with('accates', AccountCategory::orderBy('id', 'DESC')->get());
    }

    public function batch_upload()
    {
        return view('accountmgt.batch_upload');
    }

    public function account_category_create()
    {
        return view('accountmgt.category.create')->with('actyps', AccountType::all());
    }

    public function account_category_store(Request $r)
    {
        $this->logInfo("store category", $r->all());
        $this->validate($r, [
            'name'         => ['required', 'string'],
            'account_type' => ['required', 'string'],
            'description'  => ['required', 'string'],
        ]);

        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;

        AccountCategory::create([
            'name'        => strtolower($r->name),
            'type'        => strtolower($r->account_type),
            'description' => str_replace("'", "", $r->description),
        ]);

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'account category', 'created account category');

        return redirect()->route('ac.category.index')->with('success', 'Account Category Created');
    }

    public function account_category_edit($id)
    {
        return view('accountmgt.category.edit')
            ->with('ed', AccountCategory::findorfail($id))
            ->with('actyps', AccountType::all());
    }

    public function account_category_update(Request $r, $id)
    {
        $this->logInfo("category update", $r->all());
        $this->validate($r, [
            'name'         => ['required', 'string'],
            'account_type' => ['required', 'string'],
            'description'  => ['required', 'string'],
        ]);

        $branch  = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;
        $upacate = AccountCategory::findorfail($id);

        $upacate->update([
            'name'        => strtolower($r->name),
            'type'        => strtolower($r->account_type),
            'description' => str_replace("'", "", $r->description),
        ]);

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'account category', 'updated account category');

        return redirect()->route('ac.category.index')->with('success', 'Account Category Updated');
    }

    public function account_category_delete($id)
    {
        AccountCategory::findorfail($id)->delete();
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'account category', 'deleted an account category');

        return ["status" => "success", "msg" => "Account Category Deleted"];
    }

    public function multiple_account_category_delete(Request $r)
    {
        foreach ($r->accateid as $accateid) {
            AccountCategory::where('id', $accateid)->delete();
        }

        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'account category', 'multiple deleted an account category');

        return ["status" => "success", "msg" => "Account Category Deleted"];
    }

    public function capital_index()
    {
        return view('accountmgt.capital.index')->with('capitals', Capital::orderBy('id', 'DESC')->get());
    }

    public function capital_create()
    {
        return view('accountmgt.capital.create');
    }

    public function capital_store(Request $r)
    {
        $this->logInfo("store capital", $r->all());
        $this->validate($r, [
            'share_holder_name' => ['required', 'string'],
            'percentage'        => ['required', 'string'],
        ]);

        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;

        Capital::create([
            'share_holder_name' => strtolower($r->share_holder_name),
            'user_id'           => Auth::user()->id,
            'branch_id'         => $branch,
            'percentage'        => $r->percentage,
            'notes'             => str_replace("'", "", $r->description),
        ]);

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'account category', 'created capital');

        return redirect()->route('capital.index')->with('success', 'Capital Created');
    }

    public function capital_edit($id)
    {
        return view('accountmgt.capital.edit')->with('ed', Capital::findorfail($id));
    }

    public function capital_update(Request $r, $id)
    {
        $this->logInfo("upate capital", $r->all());
        $this->validate($r, [
            'share_holder_name' => ['required', 'string'],
            'percentage'        => ['required', 'string'],
        ]);

        $branch  = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;
        $upacate = Capital::findorfail($id);

        $upacate->update([
            'share_holder_name' => strtolower($r->share_holder_name),
            'user_id'           => Auth::user()->id,
            'branch_id'         => $branch,
            'percentage'        => $r->percentage,
            'notes'             => str_replace("'", "", $r->description),
        ]);

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'capital', 'updated capital');

        return redirect()->route('capital.index')->with('success', 'Capital Updated');
    }

    public function capital_delete($id)
    {
        Capital::findorfail($id)->delete();
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'capital', 'deleted capital');

        return redirect()->route('capital.index')->with('success', 'Capital Deleted');
    }

    public function fund_gl_accounts()
    {
        return view('accountmgt.fund_gl_transaction')->with('actyps', AccountType::all());
    }

    public function gl_customer_posting()
    {
        return view('accountmgt.gl_customer_posting');
    }

    public function gl_index()
    {
        return view('accountmgt.gl.index')->with('gls', GeneralLedger::orderBy('gl_name', 'ASC')->get());
    }

    public function gl_create()
    {
        return view('accountmgt.gl.create')
            ->with('actyps', AccountType::all())
            ->with('exrate', Exchangerate::all())
            ->with('accates', AccountCategory::orderBy('id', 'ASC')->get());
    }

    public function gl_store(Request $r)
    {
        $lock = Cache::lock('glaccst-' . mt_rand('1111', '9999'), 3);

        if ($lock->get()) {
            $this->logInfo("storing general ledger", $r->all());

            $this->validate($r, [
                'name'         => ['required', 'string'],
                'account_type' => ['required', 'string'],
            ]);

            $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;
            $cod    = $r->code . "" . mt_rand('111111', '999999');

            GeneralLedger::create([
                'account_category_id' => $r->account_category,
                'user_id'             => Auth::user()->id,
                'branch_id'           => $branch,
                'gl_name'             => strtolower($r->name),
                'gl_code'             => $cod,
                'gl_type'             => $r->account_type,
                'currency_id'         => $r->currency_type,
                'status'              => '1',
            ]);

            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'created general ledger');

            $lock->release();

            return redirect()->route('gl.index')->with('success', 'General Ledger Created');
        }
    }

    public function gl_edit($id)
    {
        return view('accountmgt.gl.edit')
            ->with('ed', GeneralLedger::findorfail($id))
            ->with('exrate', Exchangerate::all())
            ->with('accates', AccountCategory::orderBy('id', 'ASC')->get());
    }

    public function gl_update(Request $r, $id)
    {
        $lock = Cache::lock('glaccupt-' . mt_rand('1111', '9999'), 3);

        if ($lock->get()) {
            $this->logInfo("update general ledger", $r->all());

            $this->validate($r, [
                'name' => ['required', 'string'],
            ]);

            $branch  = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;
            $upacate = GeneralLedger::findorfail($id);

            $upacate->update([
                'gl_name'             => strtolower($r->name),
                'account_category_id' => $r->account_category,
                'currency_id'         => $r->currency_type,
                'branch_id'           => $branch,
            ]);

            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'updated general ledger');

            $lock->release();

            return redirect()->route('gl.index')->with('success', 'General Ledger Updated');
        }
    }

    public function gl_delete($id)
    {
        GeneralLedger::findorfail($id)->delete();
        $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;

        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
        $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'deleted general ledger');

        return redirect()->route('gl.index')->with('success', 'General Ledger Deleted');
    }

    public function change_gl_status($glid, $status)
    {
        $lock = Cache::lock('chgglacccstus-' . mt_rand('1111', '9999'), 3);

        if ($lock->get()) {
            $branch  = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;
            $upstatu = GeneralLedger::findorfail($glid);

            $upstatu->status = $status;
            $upstatu->save();

            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'changed general ledger status');

            $lock->release();

            return redirect()->back()->with('success', 'General Ledger Status Changed');
        }
    }

    public function activate_deactive_glaccount(Request $r)
    {
        $lock = Cache::lock('glaccchesta-' . mt_rand('1111', '9999'), 3);

        if ($lock->get()) {
            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;

            if (!empty($r->glid)) {
                $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;

                if ($r->cmdupdatestatus == "Activate Account(s)") {
                    foreach ($r->glid as $gid) {
                        GeneralLedger::where('id', $gid)->update(['status' => "1"]);
                    }
                    $this->tracktrails(Auth::user()->id, $branch, $usern, 'customer', 'activated General ledger account');

                    return redirect()->back()->with('success', 'Account Activated');
                } elseif ($r->cmdupdatestatus == "Deactivate Account(s)") {
                    foreach ($r->glid as $gid) {
                        GeneralLedger::where('id', $gid)->update(['status' => "0"]);
                    }
                    $this->tracktrails(Auth::user()->id, $branch, $usern, 'customer', 'deactivated General ledger account');

                    return redirect()->back()->with('success', 'Account Deactivated');
                }
            } else {
                return redirect()->back();
            }

            $lock->release();
        }
    }

    public function vault_till_posting()
    {
        return view('accountmgt.vault_till_customer_posting')->with('actyps', AccountType::all());
    }

    public function make_vault_transactions(Request $r)
    {
        $lock = Cache::lock('mkvulttrxn-' . mt_rand('1111', '9999'), 2);

        if ($lock->get()) {
            $branch  = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
            $usern   = Auth::user()->last_name . " " . Auth::user()->first_name;

            if (preg_match('/[\'^£$%&*}{@#~?><>()"|=_+¬]/', $r->description)) {
                return ['status' => '0', 'msg' => "No special character allowed in narration"];
            }

            $getsetvalue    = new Setting();
            $glsavingdacct  = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', '20993097')->lockForUpdate()->first();
            $glcurrentacct  = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', '20639526')->lockForUpdate()->first();

            // -------------------------------------------------------------------------
            // VTP: Vault → Till
            // -------------------------------------------------------------------------
            if ($r->options == "vtp") {
                $this->logInfo("vault to till posting", $r->all());

                $this->validate($r, [
                    'amount'  => ['required', 'string', 'numeric', 'gt:0'],
                    'glcode'  => ['required', 'string', 'numeric'],
                    'glcode2' => ['required', 'string', 'numeric'],
                ]);

                $glacct  = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', $r->glcode)->lockForUpdate()->first();
                $trxref  = $this->generatetrnxref('vtp');

                if ($r->account_type == "asset" && $r->account_type2 == "asset" && $r->gltype == "Vault Account") {
                    if ($glacct->status == '1') {
                        if ($glacct->account_balance >= $r->amount) {
                            $dedamount = $glacct->account_balance - $r->amount;

                            if ($r->dbit == 'debit') {
                                $glacct->account_balance = $dedamount;
                                $glacct->save();

                                $this->create_saving_transaction_gl(Auth::user()->id, $glacct->id, $branch, $r->amount, 'credit', 'core', null, $trxref, str_replace("'", "", $r->description), 'approved', $usern);
                                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'debited an vault account');
                                $this->credit_other_gl_accounts($r->options, $r->glcode2, $r->amount, $branch, $trxref, str_replace("'", "", $r->description), '');
                            }

                            return ['status' => 'success', 'msg' => 'Transfer Successful'];
                        } else {
                            return ['status' => '0', 'msg' => 'Insufficent Fund'];
                        }
                    } else {
                        return ['status' => '0', 'msg' => 'Inactive GL account'];
                    }
                } else {
                    return ['status' => '0', 'msg' => 'Transaction must be of account type asset with GL of Vault Account or Teller till'];
                }

            // -------------------------------------------------------------------------
            // TVP: Till → Vault
            // -------------------------------------------------------------------------
            } elseif ($r->options == "tvp") {
                $this->logInfo("till to vault posting", $r->all());

                $this->validate($r, [
                    'amount'  => ['required', 'string', 'numeric', 'gt:0'],
                    'glcode3' => ['required', 'string', 'numeric'],
                    'glcode4' => ['required', 'string', 'numeric'],
                ]);

                $glacct = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', $r->glcode3)->lockForUpdate()->first();
                $trxref = $this->generatetrnxref('tvp');

                if ($r->account_type3 == "asset" && $r->account_type4 == "asset" && $r->gltype == "Vault Account") {
                    if ($glacct->status == '1') {
                        if ($glacct->account_balance >= $r->amount) {
                            $dedamount = $glacct->account_balance - $r->amount;

                            if ($r->dbit == 'debit') {
                                $glacct->account_balance = $dedamount;
                                $glacct->save();

                                $this->create_saving_transaction_gl(Auth::user()->id, $glacct->id, $branch, $r->amount, 'credit', 'core', null, $trxref, str_replace("'", "", $r->description), 'approved', $usern);
                                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'debited an account');
                                $this->credit_other_gl_accounts($r->options, $r->glcode4, $r->amount, $branch, $trxref, str_replace("'", "", $r->description), '');
                            }

                            return ['status' => 'success', 'msg' => 'Transfer Successful'];
                        } else {
                            return ['status' => '0', 'msg' => 'Insufficent Fund'];
                        }
                    } else {
                        return ['status' => '0', 'msg' => 'Inactive GL account'];
                    }
                } else {
                    return ['status' => '0', 'msg' => 'Transaction must be of account type asset with GL of Vault Account or Teller till'];
                }

            // -------------------------------------------------------------------------
            // TCP: Till → Customer
            // -------------------------------------------------------------------------
            } elseif ($r->options == "tcp") {
                $this->logInfo("till to customer posting", $r->all());

                $this->validate($r, [
                    'account_number' => ['required', 'string', 'numeric'],
                    'amount'         => ['required', 'string', 'numeric', 'gt:0'],
                    'glcode5'        => ['required', 'string', 'numeric'],
                ]);

                $trxref = $this->generatetrnxref('tcp');
                $glacct = GeneralLedger::select('id', 'status', 'account_balance', 'currency_id')->where('gl_code', $r->glcode5)->lockForUpdate()->first();
                $cust   = Customer::where('id', $r->customerid)->first();

                if ($glacct->currency_id != $cust->exchangerate_id) {
                    return ['status' => '0', 'msg' => 'Currency mis-match'];
                }

                if ($r->account_type5 == "asset") {
                    if ($glacct->status == '1') {
                        if ($glacct->account_balance >= $r->amount) {
                            if ($r->dbit == 'debit') {
                                // ALL TCP postings go pending — no limit check
                                $this->create_saving_transaction_gl(Auth::user()->id, $glacct->id, $branch, $r->amount, 'credit', 'core', null, $trxref, str_replace("'", "", $r->description), 'pending', $usern);

                                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'debited an till account');

                                $this->credit_account_transfer($r->amount, $r->customerid, $r->options, 'credit', $trxref, str_replace("'", "", $r->description), $branch, 'pending');

                                return ['status' => 'success', 'msg' => 'Transaction posted...Awaiting Approval'];
                            }
                        } else {
                            return ['status' => '0', 'msg' => 'Insufficent Fund'];
                        }
                    } else {
                        return ['status' => '0', 'msg' => 'Inactive GL account'];
                    }
                } else {
                    return ['status' => '0', 'msg' => 'Transaction must be of account type asset'];
                }

            // -------------------------------------------------------------------------
            // CTP: Customer → Till
            // -------------------------------------------------------------------------
            } elseif ($r->options == "ctp") {
                $this->logInfo("customer to till posting", $r->all());

                $this->validate($r, [
                    'account_number' => ['required', 'string', 'numeric'],
                    'amount'         => ['required', 'string', 'numeric', 'gt:0'],
                    'glcode6'        => ['required', 'string', 'numeric'],
                ]);

                $trxrefc = $this->generatetrnxref('ctp');
                $cust    = Customer::where('id', $r->customerid)->first();
                $glacct  = GeneralLedger::select('id', 'status', 'account_balance', 'currency_id')->where('gl_code', $r->glcode6)->lockForUpdate()->first();

                if ($glacct->currency_id != $cust->exchangerate_id) {
                    return ['status' => '0', 'msg' => 'Currency mis-match'];
                }

                $chkcres = $this->checkCustomerRestriction($r->customerid);
                if ($chkcres == true) {
                    $this->tracktrails('1', '1', $usern, 'customer', 'Account Restricted');
                    return ['status' => '0', 'msg' => 'Customer Account Has Been Restricted'];
                }

                $chklien = $this->checkCustomerLienStatus($r->customerid);
                if ($chklien['status'] == true && $chklien['lien'] == 2) {
                    $this->tracktrails('1', '1', $usern, 'customer', 'Account has been lien');
                    return ['status' => '0', 'msg' => 'Your Account Has Been Lien(' . $chklien['message'] . ')...please contact support'];
                }

                if ($r->account_type6 == "asset") {
                    $customeracct2 = Saving::lockForUpdate()->where('customer_id', $r->customerid)->first();

                    if ($customeracct2->account_balance >= $r->amount) {
                        if ($r->dbit == "debit") {
                            // ALL CTP postings go pending — no withdrawal limit check
                            $this->create_saving_transaction(
                                Auth::user()->id,
                                $r->customerid,
                                $branch,
                                $r->amount,
                                'debit',
                                'core',
                                '0',
                                null,
                                '0',
                                $r->options,
                                null,
                                $trxrefc,
                                str_replace("'", "", $r->description),
                                'pending',
                                '2',
                                'trnsfer',
                                $usern
                            );

                            $this->credit_other_gl_accounts($r->options, $r->glcode6, $r->amount, $branch, $trxrefc, str_replace("'", "", $r->description), 'pending');

                            return ['status' => 'success', 'msg' => 'Withdrawal Posted...Awaiting Approval'];
                        }
                    } else {
                        return ['status' => '0', 'msg' => 'Insufficent Fund'];
                    }
                } else {
                    return ['status' => '0', 'msg' => 'Transaction must be of account type asset'];
                }
            }

            $lock->release();
        }
    }

    public function credit_other_gl_accounts($opt, $glcode, $amount, $branch, $trx, $desc, $status)
    {
        $glacct2 = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', $glcode)->lockForUpdate()->first();
        $usern   = Auth::user()->last_name . " " . Auth::user()->first_name;

        if ($glacct2->status == '1') {
            if ($opt == "vtp") {
                $addamount = $glacct2->account_balance + $amount;
                $glacct2->account_balance = $addamount;
                $glacct2->save();

                $this->create_saving_transaction_gl(Auth::user()->id, $glacct2->id, $branch, $amount, 'debit', 'core', $trx, $this->generatetrnxref('vtp'), $desc, 'approved', $usern);
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'credited an Till account');

            } elseif ($opt == "tvp") {
                $addamount = $glacct2->account_balance + $amount;
                $glacct2->account_balance = $addamount;
                $glacct2->save();

                $this->create_saving_transaction_gl(Auth::user()->id, $glacct2->id, $branch, $amount, 'debit', 'core', $trx, $this->generatetrnxref('tvp'), $desc, 'approved', $usern);
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'credited an vault account');

            } elseif ($opt == "tcp") {
                // tcp is handled via credit_account_transfer

            } elseif ($opt == "ctp") {
                // ALL CTP gl entries go pending — no limit check
                $this->create_saving_transaction_gl(Auth::user()->id, $glacct2->id, $branch, $amount, 'credit', 'core', $trx, $this->generatetrnxref('ctp'), $desc, 'pending', $usern);
            }
        }
    }

    public function credit_gl_accounts(Request $r)
    {
        $lock = Cache::lock('glcrdit-' . mt_rand('1111', '9999'), 3);

        if ($lock->get()) {
            $this->logInfo("credit gl account", $r->all());

            $this->validate($r, [
                'amount' => ['required', 'string', 'numeric'],
                'glcode' => ['required', 'string', 'numeric'],
            ]);

            $branch = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
            $usern  = Auth::user()->last_name . " " . Auth::user()->first_name;

            if ($r->account >= $r->amount) {
                $subcod       = substr($r->glcode, 0, 2);
                $checkacctyp  = AccountType::where('code', $subcod)->first();
                $glacct       = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', $r->glcode)->lockForUpdate()->first();
                $trxref       = date("Ymd") . "" . mt_rand(111, 999);
                $addamount    = $glacct->account_balance + $r->amount;

                $debitCredit  = in_array($checkacctyp->name, ['asset', 'expense']) ? 'debit' : 'credit';

                $glacct->account_balance = $addamount;
                $glacct->save();

                $subal = $r->account - $r->amount;
                if ($r->funds == "bank funds") {
                    Setting::where('setting_key', 'bank_fund')->update(['setting_value' => $subal]);
                } elseif ($r->funds == "capital") {
                    Setting::where('setting_key', 'company_capital')->update(['setting_value' => $subal]);
                }

                $this->create_saving_transaction_gl(Auth::user()->id, $glacct->id, $branch, $r->amount, $debitCredit, 'core', $trxref, $this->generatetrnxref('bnkgl'), str_replace("'", "", $r->description), 'approved', $usern);
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'from ' . $r->funds, 'deposited to a ' . $glacct->gl_name . ' GL account from ' . $r->funds);

                $lock->release();

                return ['status' => 'success', 'msg' => 'Transfer Successful'];
            } else {
                return ['status' => '0', 'msg' => 'Insufficent Fund'];
            }
        }
    }

    /*
    |--------------------------------------------------------------------------
    | GL Make Transaction (glc / cgl / gltogl) — ALL go pending
    |--------------------------------------------------------------------------
    */
    public function gl_make_transaction(Request $r)
    {
        Log::info('CGL DATA', $r->all());

        $lock = Cache::lock('glmktranxn', 3);

        if (!$lock->get()) {
            return ['status' => '0', 'msg' => 'System busy, try again'];
        }

        try {
            $branch = Auth::user()->branch_id;
            $usern  = Auth::user()->last_name . " " . Auth::user()->first_name;

            if (preg_match('/[\'^£$%&*}{@#~?><>"()|=_+¬]/', $r->description)) {
                return ['status' => '0', 'msg' => "No special character allowed in narration"];
            }

            $status = 'pending';

            // -----------------------------------------------------------------
            // GL → Customer (glc)
            // -----------------------------------------------------------------
            if ($r->options == "glc") {
                $validator = Validator::make($r->all(), [
                    'account_number' => ['required', 'string', 'numeric'],
                    'gl_code'        => ['required', 'string', 'numeric'],
                    'amount'         => ['required', 'numeric', 'gt:0'],
                ]);

                if ($validator->fails()) {
                    return response()->json(['status' => 'error', 'errors' => $validator->errors()], 422);
                }

                $trxref = $this->generatetrnxref('glc');

                $this->create_saving_transaction_gl(
                    Auth::user()->id,
                    $r->gldger_id,
                    $branch,
                    $r->amount,
                    'debit',
                    'core',
                    null,
                    $trxref,
                    str_replace("'", "", $r->description),
                    $status,
                    $usern
                );

                $this->credit_account_transfer(
                    $r->amount,
                    $r->customerid,
                    'glc',
                    $r->dbit2,
                    $trxref,
                    str_replace("'", "", $r->description),
                    $branch,
                    $status
                );

                return ['status' => 'success', 'msg' => 'Transaction posted...Awaiting Approval'];
            }

            // -----------------------------------------------------------------
            // Customer → GL (cgl)
            // -----------------------------------------------------------------
            if ($r->options == "cgl") {
                $validator = Validator::make($r->all(), [
                    'account_number' => ['required', 'string', 'numeric', 'exists:customers,acctno'],
                    'gl_code2'       => ['required', 'string', 'numeric', 'exists:general_ledgers,gl_code'],
                    'amount'         => ['required', 'numeric', 'gt:0'],
                ]);

                if ($validator->fails()) {
                    return response()->json(['status' => 'error', 'errors' => $validator->errors()], 422);
                }

                $trxref     = $this->generatetrnxref('cgl');
                $customerId = $r->customerid;
                $glId       = $r->gldger_id;

                if (!$customerId || !$glId) {
                    return ['status' => '0', 'msg' => 'Customer or GL not resolved'];
                }

                $this->create_saving_transaction(
                    Auth::user()->id,
                    $r->customerid,
                    Auth::user()->branch_id,
                    $r->amount,
                    $r->dbit,
                    'core',
                    '0',
                    null,
                    '0',
                    'cgl',
                    null,
                    $trxref,
                    str_replace("'", "", $r->description),
                    'pending',
                    '2',
                    'trnsfer',
                    $usern
                );

                $this->credit_gl_account_transfer(
                    $r->options,
                    $r->gl_code2,
                    $r->amount,
                    $branch,
                    $r->gldger_id,
                    $r->dbit2,
                    'cgl',
                    $trxref,
                    str_replace("'", "", $r->description),
                    'pending'
                );

                return ['status' => 'success', 'msg' => 'Transaction posted...Awaiting Approval CGL'];
            }

            // -----------------------------------------------------------------
            // GL → GL (gltogl)
            // -----------------------------------------------------------------
            if ($r->options == "gltogl") {
                $validator = Validator::make($r->all(), [
                    'gl_code'  => ['required', 'string', 'numeric', 'exists:general_ledgers,gl_code'],
                    'gl_code2' => ['required', 'string', 'numeric', 'exists:general_ledgers,gl_code'],
                    'amount'   => ['required', 'numeric', 'gt:0'],
                ]);

                if ($validator->fails()) {
                    return response()->json(['status' => 'error', 'errors' => $validator->errors()], 422);
                }

                $trxref = $this->generatetrnxref('gltogl');

                $this->create_saving_transaction_gl(
                    Auth::user()->id,
                    $r->gldger_id,
                    $branch,
                    $r->amount,
                    'debit',
                    'core',
                    null,
                    $trxref,
                    str_replace("'", "", $r->description),
                    $status,
                    $usern
                );

                $this->credit_gl_account_transfer(
                    $r->options,
                    $r->gl_code2,
                    $r->amount,
                    $branch,
                    $r->gldger_id2,
                    $r->dbit2,
                    'gltogl',
                    $trxref,
                    str_replace("'", "", $r->description),
                    $status
                );

                return ['status' => 'success', 'msg' => 'Transaction posted...Awaiting Approval'];
            }

        } finally {
            $lock->release();
        }
    }

    /*
    |--------------------------------------------------------------------------
    | Credit Account Transfer — ALL go pending, no deposit limit check
    |--------------------------------------------------------------------------
    */
    public function credit_account_transfer($amount, $cid, $inita, $tran_type2, $trxref, $desc, $branch = null, $status = 'pending')
    {
        $usern = Auth::user()->last_name . " " . Auth::user()->first_name;

        $chkcres = $this->checkCustomerRestriction($cid);
        $chklien = $this->checkCustomerLienStatus($cid);

        $getsetvalue = new Setting();
        $cust        = Customer::where('id', $cid)->first();

        if ($chkcres == true) {
            $this->tracktrails('1', '1', $usern, 'customer', 'Account Restricted');
            return ['status' => false, 'msg' => 'Customer Account Has Been Restricted'];
        } elseif ($chklien['status'] == true && $chklien['lien'] == 1) {
            $this->tracktrails('1', '1', $usern, 'customer', 'Account Restricted');
            return ['status' => false, 'msg' => 'Customer Account Has Been Lien(' . $chklien['message'] . ')...please contact support'];
        }

        // ALL postings go pending — no deposit limit check
        $this->create_saving_transaction(
            Auth::user()->id,
            $cid,
            Auth::user()->branch_id,
            $amount,
            $tran_type2,
            'core',
            '0',
            $trxref,
            '0',
            $inita,
            null,
            $this->generatetrnxref('Cr'),
            $desc,
            'pending',
            '1',
            'trnsfer',
            $usern
        );

        return ['status' => true, 'msg' => 'Deposit Posted...Awaiting Approval'];
    }

    /*
    |--------------------------------------------------------------------------
    | Credit GL Account Transfer
    |--------------------------------------------------------------------------
    */
    public function credit_gl_account_transfer($opt, $glcode, $amount, $branch, $glid, $dbit2, $inita, $trxref, $desc, $status)
    {
        $usern   = Auth::user()->last_name . " " . Auth::user()->first_name;
        $glacct2 = GeneralLedger::where('id', $glid)->first();

        if ($opt == "cgl") {
            if ($status == "pending") {
                $this->create_saving_transaction_gl(Auth::user()->id, $glid, $branch, $amount, 'credit', 'core', $trxref, $this->generatetrnxref($inita), $desc, 'pending', $usern);
            } else {
                switch ($glacct2->gl_type) {
                    case 'asset':
                        $glacct2->account_balance -= $amount;
                        break;
                    case 'expense':
                        $glacct2->account_balance -= $amount;
                        break;
                    default:
                        $glacct2->account_balance += $amount;
                        break;
                }
                $glacct2->save();

                $this->create_saving_transaction_gl(Auth::user()->id, $glid, $branch, $amount, 'credit', 'core', $trxref, $this->generatetrnxref($inita), $desc, 'approved', $usern);
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'credited ' . $glacct2->gl_type . ' account');
            }

        } elseif ($opt == "gltogl") {
            if ($status == "pending") {
                $this->create_saving_transaction_gl(Auth::user()->id, $glid, $branch, $amount, 'credit', 'core', $trxref, $this->generatetrnxref($inita), $desc, 'pending', $usern);
            } else {
                switch ($glacct2->gl_type) {
                    case 'asset':
                        $glacct2->account_balance -= $amount;
                        break;
                    case 'expense':
                        $glacct2->account_balance -= $amount;
                        break;
                    default:
                        $glacct2->account_balance += $amount;
                        break;
                }
                $glacct2->save();

                $this->create_saving_transaction_gl(Auth::user()->id, $glid, $branch, $amount, 'credit', 'core', $trxref, $this->generatetrnxref($inita), $desc, 'approved', $usern);
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'credited ' . $glacct2->gl_type . ' account');
            }
        }
    }

    /*
    |--------------------------------------------------------------------------
    | Batch Upload
    |--------------------------------------------------------------------------
    */
    public function batch_upload_store(Request $r)
    {
        $this->validate($r, [
            'file_upload' => ['required', 'mimes:csv', 'max:10240'],
        ]);

        $branch    = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $csvfile   = $r->file('file_upload');
        $newcsv    = time() . "_" . $csvfile->getClientOriginalName();
        $csvfile->move('uploads', $newcsv);

        if ($r->uploads == "ac") {
            $path = $_SERVER["DOCUMENT_ROOT"] . "/uploads/" . $newcsv;
            $this->account_category_upload_file($path);
            unlink($path);

            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'account category', 'uploaded account category');

            return redirect()->route('ac.category.index')->with('success', 'Account Category Uploaded');

        } elseif ($r->uploads == "gl") {
            $path = $_SERVER["DOCUMENT_ROOT"] . "/uploads/" . $newcsv;
            $this->general_legder_upload_file($path);
            unlink($path);

            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'uploaded general ledger');

            return redirect()->route('gl.index')->with('success', 'General Ledger Uploaded');

        } elseif ($r->uploads == "cgl") {
            $path     = $_SERVER["DOCUMENT_ROOT"] . "/uploads/" . $newcsv;
            $response = $this->customer_general_legder_upload_file($path);
            unlink($path);

            if ($response['status'] == false) {
                return redirect()->back()->with('error', $response['msg']);
            }

            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'uploaded customer to general ledger');

            return redirect(route('viewuploadstatus') . "?type=cgl&uploadstatus=current")->with('success', 'General Ledger Uploaded');

        } elseif ($r->uploads == "glc") {
            $path     = $_SERVER["DOCUMENT_ROOT"] . "/uploads/" . $newcsv;
            $response = $this->general_legder_customer_upload_file($path);
            unlink($path);

            if ($response['status'] == false) {
                return redirect()->back()->with('error', $response['msg']);
            }

            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'uploaded general ledger to customer');

            return redirect(route('viewuploadstatus') . "?type=glc&uploadstatus=current")->with('success', 'General Ledger Uploaded');

        } elseif ($r->uploads == "gltogl") {
            $path     = $_SERVER["DOCUMENT_ROOT"] . "/uploads/" . $newcsv;
            $response = $this->general_legder_gl_upload_file($path);
            unlink($path);

            if ($response['status'] == false) {
                return redirect()->back()->with('error', $response['msg']);
            }

            $usern = Auth::user()->last_name . " " . Auth::user()->first_name;
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', 'uploaded general ledger');

            return redirect(route('viewuploadstatus') . "?type=gltogl&uploadstatus=current")->with('success', 'General Ledger Uploaded');

        } else {
            return redirect()->back()->with('error', 'Please Select a file');
        }
    }

    public function account_category_upload_file($filepath)
    {
        $handlefile = fopen($filepath, "r");
        fgetcsv($handlefile);

        while (($data = fgetcsv($handlefile, '1000000', ',')) !== false) {
            AccountCategory::firstOrCreate([
                'name'        => strtolower($data[0]),
                'type'        => ucwords($data[1]),
                'description' => $data[2],
            ]);
        }

        fclose($handlefile);
    }

    public function general_legder_upload_file($filepath)
    {
        $branch     = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $handlefile = fopen($filepath, "r");
        fgetcsv($handlefile);

        while (($data = fgetcsv($handlefile, '1000000', ',')) !== false) {
            $type  = AccountType::where('code', $data[1])->first();
            $gcode = $data[1] . "" . mt_rand('111111', '999999');

            GeneralLedger::firstOrCreate([
                'user_id'   => Auth::user()->id,
                'branch_id' => $branch,
                'gl_name'   => strtolower($data[0]),
                'gl_code'   => $gcode,
                'gl_type'   => $type->name,
                'status'    => $data[2],
            ]);
        }

        fclose($handlefile);
    }

    /*
    |--------------------------------------------------------------------------
    | Customer → GL Upload — ALL go pending, no withdrawal limit check
    |--------------------------------------------------------------------------
    */
    public function customer_general_legder_upload_file($filepath)
    {
        $branch     = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $handlefile = fopen($filepath, "r");
        fgetcsv($handlefile);

        while (($data = fgetcsv($handlefile, '1000000', ',')) !== false) {
            if (count($data) > 20) {
                return ['status' => false, 'msg' => 'uploaded files exceeds length of 20'];
            }

            $custacc = $data[0];
            $glcode  = $data[1];
            $amount  = $data[2];
            $desc    = $data[3];
            $trx     = 'debit';
            $trx2    = 'credit';
            $usern   = Auth::user()->last_name . " " . Auth::user()->first_name;
            $trxref  = $this->generatetrnxref('cgl');

            $customerac   = Customer::select('id', 'first_name', 'last_name', 'acctno', 'account_type', 'enable_email_alert', 'enable_sms_alert', 'exchangerate_id')->where('acctno', $custacc)->first();
            $customeracct = Saving::lockForUpdate()->where('customer_id', $customerac->id)->first();
            $gl           = GeneralLedger::select('id', 'status', 'account_balance', 'gl_type', 'currency_id')->where('gl_code', $glcode)->lockForUpdate()->first();

            if ($customerac->exchangerate_id != $gl->currency_id) {
                $this->upload_trx_status($branch, $customerac->id, $gl->id, $customeracct->account_balance, $amount, $trx, 'cgl', Carbon::now(), 'Currency mis-match', '0', '1');
                continue;
            }

            if (empty($customerac)) {
                $this->upload_trx_status($branch, null, $gl->id, 0, $amount, $trx, 'cgl', Carbon::now(), 'invalid account', '0', '1');
                continue;
            }

            $chkcres = $this->checkCustomerRestriction($customerac->id);
            if ($chkcres == true) {
                $this->upload_trx_status($branch, $customerac->id, $gl->id, $customeracct->account_balance, $amount, $trx, 'cgl', Carbon::now(), 'customer account restricted', '0', '1');
                continue;
            }

            $chklien = $this->checkCustomerLienStatus($customerac->id);
            if ($chklien['status'] == true) {
                $this->upload_trx_status($branch, $customerac->id, $gl->id, $customeracct->account_balance, $amount, $trx, 'cgl', Carbon::now(), 'customer account lien(' . $chklien['message'] . ')', '0', '1');
                continue;
            }

            if ($customeracct->account_balance < $amount) {
                $this->upload_trx_status($branch, $customerac->id, $gl->id, $customeracct->account_balance, $amount, $trx, 'cgl', Carbon::now(), 'insufficent fund', '0', '1');
                continue;
            }

            // ALL CGL upload postings go pending — no withdrawal limit check
            $this->create_saving_transaction(
                Auth::user()->id,
                $customerac->id,
                Auth::user()->branch_id,
                $amount,
                $trx,
                'core',
                '0',
                null,
                '0',
                'cgl',
                null,
                $trxref,
                $desc,
                'pending',
                '2',
                'trnsfer',
                $usern . '(c)'
            );

            $this->credit_gl_account_transfer('cgl', $glcode, $amount, $branch, $gl->id, $trx2, 'cgl', $trxref, $desc, 'pending');

            $this->upload_trx_status($branch, $customerac->id, $gl->id, $customeracct->account_balance, $amount, $trx, 'cgl', Carbon::now(), 'awaiting approval', '1', '1');
        }

        fclose($handlefile);

        return ["status" => "success", "message" => "Transaction Posted"];
    }

    /*
    |--------------------------------------------------------------------------
    | GL → Customer Upload — ALL go pending, no deposit limit check
    |--------------------------------------------------------------------------
    */
    public function general_legder_customer_upload_file($filepath)
    {
        $branch     = session()->has('branchid') ? session()->get('branchid')['bid'] : Auth::user()->branch_id;
        $handlefile = fopen($filepath, "r");
        fgetcsv($handlefile);

        while (($data = fgetcsv($handlefile, '1000000', ',')) !== false) {
            if (count($data) > 30) {
                return ['status' => false, 'msg' => 'uploaded files exceeds length of 30'];
            }

            $glcode  = $data[0];
            $custacc = $data[1];
            $amount  = $data[2];
            $desc    = $data[3];
            $trx     = 'debit';
            $trx2    = 'credit';

            $customerac   = Customer::select('id', 'first_name', 'last_name', 'acctno', 'exchangerate_id')->where('acctno', $custacc)->first();
            $gl           = GeneralLedger::select('id', 'status', 'account_balance', 'gl_type', 'currency_id')->where('gl_code', $glcode)->lockForUpdate()->first();

            if (empty($customerac)) {
                $this->upload_trx_status($branch, null, $gl->id, $gl->account_balance, $amount, $trx, 'glc', Carbon::now(), 'incorrect account number(' . $custacc . ')', '0', '1');
                continue;
            }

            if ($customerac->exchangerate_id != $gl->currency_id) {
                $this->upload_trx_status($branch, $customerac->id, $gl->id, $gl->account_balance, $amount, $trx, 'glc', Carbon::now(), 'Currency mis-match', '0', '1');
                continue;
            }

            if (empty($gl)) {
                $this->upload_trx_status($branch, $customerac->id, null, 0, $amount, $trx, 'glc', Carbon::now(), 'invalid GL Code', '0', '1');
                continue;
            }

            if ($gl->account_balance < $amount) {
                $this->upload_trx_status($branch, $customerac->id, $gl->id, $gl->account_balance, $amount, $trx, 'glc', Carbon::now(), 'insufficent fund', '0', '1');
                continue;
            }

            if ($gl->status != 1) {
                $this->upload_trx_status($branch, $customerac->id, $gl->id, $gl->account_balance, $amount, $trx, 'glc', Carbon::now(), 'inactive GL account', '0', '1');
                continue;
            }

            $trxref = $this->generatetrnxref('glc');
            $usern  = Auth::user()->last_name . " " . Auth::user()->first_name;

            // ALL GLC upload postings go pending — no deposit limit check
            $this->create_saving_transaction_gl(Auth::user()->id, $gl->id, $branch, $amount, 'debit', 'core', null, $trxref, $desc, 'pending', $usern);

            $this->upload_trx_status($branch, $customerac->id, $gl->id, $gl->account_balance, $amount, $trx, 'glc', Carbon::now(), 'awaiting approval', '1', '1');

            $credittnx = $this->credit_account_transfer($amount, $customerac->id, 'glc', $trx2, $trxref, $desc, $branch, 'pending');
        }

        fclose($handlefile);

        return ["status" => "success", "message" => "Transaction Posted"];
    }

    /*
    |--------------------------------------------------------------------------
    | GL → GL Upload — ALL go pending, no withdrawal limit check
    |--------------------------------------------------------------------------
    */
    public function general_legder_gl_upload_file($filepath)
    {
        $branch     = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
        $handlefile = fopen($filepath, "r");
        fgetcsv($handlefile);

        while (($data = fgetcsv($handlefile, '1000000', ',')) !== false) {
            if (count($data) > 20) {
                return ['status' => false, 'msg' => 'uploaded files exceeds length of 20'];
            }

            $glcode    = $data[0];
            $amount    = $data[1];
            $glcodee2  = $data[2];
            $desc      = $data[3];
            $usern     = Auth::user()->last_name . " " . Auth::user()->first_name;

            $gl      = GeneralLedger::select('id', 'status', 'account_balance', 'gl_type', 'currency_id')->where('gl_code', $glcode)->lockForUpdate()->first();
            $glllcd2 = GeneralLedger::select('id', 'status', 'account_balance', 'gl_type', 'currency_id')->where('gl_code', $glcodee2)->lockForUpdate()->first();
            $trxref  = $this->generatetrnxref('gltogl');

            if ($glllcd2->currency_id != $gl->currency_id) {
                $this->upload_trx_status($branch, $glllcd2->id, $gl->id, $gl->account_balance, $amount, $trxref, 'gltogl', Carbon::now(), 'Currency mis-match', '0', '1');
                continue;
            }

            if ($gl->status != 1) {
                $this->upload_trx_status($branch, $glllcd2->id, $gl->id, $gl->account_balance, $amount, $trxref, 'gltogl', Carbon::now(), 'inactive GL account', '0', '1');
                continue;
            }

            // ALL GLTOGL upload postings go pending — no withdrawal limit check
            $this->create_saving_transaction_gl(Auth::user()->id, $gl->id, $branch, $amount, 'debit', 'core', null, $trxref, $desc, 'pending', $usern);

            $this->credit_gl_account_transfer("gltogl", $glcodee2, $amount, $branch, $glllcd2->id, 'debit', 'gltogl', $trxref, $desc, 'pending');

            $this->upload_trx_status($branch, $glllcd2->id, $gl->id, $gl->account_balance, $amount, $trxref, 'gltogl', Carbon::now(), 'awaiting approval', '1', '1');
        }

        fclose($handlefile);

        return ["status" => "success", "message" => "Transaction Posted"];
    }

    /*
    |--------------------------------------------------------------------------
    | GL Reversal
    |--------------------------------------------------------------------------
    */
    public function gl_reversal()
    {
        return view('accountmgt.gl_reversal');
    }

    public function gl_check_transref()
    {
        if (request()->txntype == "glc") {
            $getgltrnx = SavingsTransactionGL::where('reference_no', request()->reference)->first();

            if (empty($getgltrnx)) {
                return ['status' => '0', 'msg' => 'reference number not found'];
            }

            $gettranslip = SavingsTransaction::where('slip', $getgltrnx->reference_no)->first();

            if (empty($gettranslip)) {
                return ['status' => '0', 'msg' => 'reference number not found'];
            }

            return [
                'status'    => '1',
                'txrtype'   => $gettranslip->type,
                'amount'    => $gettranslip->amount,
                'txrdate'   => date("d-m-y", strtotime($gettranslip->created_at)) . " at " . date("h:ia", strtotime($gettranslip->created_at)),
                'custmerid' => $gettranslip->customer_id,
                'glid'      => $getgltrnx->general_ledger_id,
                'glid2'     => null,
                'ttpe'      => $gettranslip->transfer_type,
                'msg'       => 'verified',
            ];

        } elseif (request()->txntype == "cgl") {
            $gettranslip = SavingsTransaction::where('reference_no', request()->reference)->first();

            if (empty($gettranslip)) {
                return ['status' => '0', 'msg' => 'reference number not found'];
            }

            $getgltrnx = SavingsTransactionGL::where('slip', $gettranslip->reference_no)->get();

            return [
                'status'    => '1',
                'txrtype'   => $gettranslip->type,
                'amount'    => $gettranslip->amount,
                'txrdate'   => date("d-m-y", strtotime($gettranslip->created_at)) . " at " . date("h:ia", strtotime($gettranslip->created_at)),
                'custmerid' => $gettranslip->customer_id,
                'glid'      => $getgltrnx[0]->general_ledger_id,
                'glid2'     => $getgltrnx[1]->general_ledger_id,
                'ttpe'      => $gettranslip->transfer_type,
                'msg'       => 'verified',
            ];

        } elseif (request()->txntype == "gltogl") {
            $getgltrnxone = SavingsTransactionGL::select('general_ledger_id', 'amount', 'created_at')->where('reference_no', request()->reference)->first();

            if (empty($getgltrnxone)) {
                return ['status' => '0', 'msg' => 'reference number not found'];
            }

            $getgltrnxtwo = SavingsTransactionGL::select('general_ledger_id', 'amount')->where('slip', request()->reference)->first();

            return [
                'status'  => '1',
                'amount'  => $getgltrnxone->amount,
                'txrdate' => date("d-m-y", strtotime($getgltrnxone->created_at)) . " at " . date("h:ia", strtotime($getgltrnxone->created_at)),
                'glid'    => $getgltrnxone->general_ledger_id,
                'glid2'   => $getgltrnxtwo->general_ledger_id,
                'ttpe'    => "gltogl",
            ];
        }
    }

    public function gl_reversal_posting(Request $r)
    {
        $lock = Cache::lock('glaccrvpst-' . mt_rand('1111', '9999'), 2);

        try {
            $lock->block(1);

            DB::beginTransaction();

            $branch      = session()->has('branchid') ? session()->get('branchid')['bid'] : null;
            $usern       = Auth::user()->last_name . " " . Auth::user()->first_name;
            $getsetvalue = new Setting();

            $glsavingdacct = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', '20993097')->lockForUpdate()->first();
            $glcurrentacct = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', '20639526')->lockForUpdate()->first();

            if (preg_match('/[\'^£$%&*}{@#~?><>()"|=_+¬]/', $r->description)) {
                return ['status' => '0', 'msg' => "No special character allowed in narration"];
            }

            // -----------------------------------------------------------------
            // GL → Customer Reversal (glc)
            // -----------------------------------------------------------------
            if ($r->options == "glc") {
                $this->logInfo("general ledger to customer", $r->all());

                $this->validate($r, [
                    'amount' => ['required', 'string', 'numeric', 'gt:0'],
                ]);

                $glacct = GeneralLedger::where('id', $r->gldger_id)->first();
                $trxref = $this->generatetrnxref('glc');
                $cust   = Customer::where('id', $r->customerid)->first();

                if ($cust->exchangerate_id != $glacct->currency_id) {
                    return ['status' => '0', 'msg' => "Currency mis-match"];
                }

                switch ($glacct->gl_type) {
                    case 'asset':
                        $glacct->account_balance -= $r->amount;
                        break;
                    case 'expense':
                        $glacct->account_balance -= $r->amount;
                        break;
                    default:
                        $glacct->account_balance += $r->amount;
                        break;
                }
                $glacct->save();

                $this->create_saving_transaction_gl(Auth::user()->id, $r->gldger_id, $branch, $r->amount, 'credit', 'core', null, $trxref, str_replace("'", "", $r->description), 'approved', $usern);
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', $glacct->gl_type . ' account reversal');

                $creditcut = $this->reverse_account_transfer($r->amount, $r->customerid, 'glc', $r->dbit2, $trxref, str_replace("'", "", $r->description));

                if ($creditcut['status'] == false) {
                    // Undo the GL balance change
                    switch ($glacct->gl_type) {
                        case 'asset':
                            $glacct->account_balance += $r->amount;
                            break;
                        case 'expense':
                            $glacct->account_balance += $r->amount;
                            break;
                        default:
                            $glacct->account_balance -= $r->amount;
                            break;
                    }
                    $glacct->save();

                    $this->create_saving_transaction_gl(Auth::user()->id, $r->gldger_id, $branch, $r->amount, 'debit', 'core', null, $trxref, str_replace("'", "", $r->description), 'approved', $usern);
                    $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', $glacct->gl_type . ' reversal undone');

                    DB::commit();

                    return ['status' => '0', 'msg' => $creditcut['msg']];
                }

                return ['status' => 'success', 'msg' => $creditcut['msg']];

            // -----------------------------------------------------------------
            // Customer → GL Reversal (cgl)
            // -----------------------------------------------------------------
            } elseif ($r->options == "cgl") {
                $this->logInfo("customer to general legder posting", $r->all());

                $this->validate($r, [
                    'amount' => ['required', 'string', 'numeric', 'gt:0'],
                ]);

                $cust   = Customer::where('id', $r->customerid)->first();
                $glacct = GeneralLedger::where('gl_code', $r->gl_code2)->first();
                $trxref2 = $this->generatetrnxref('cgl');

                if ($cust->exchangerate_id != $glacct->currency_id) {
                    return ['status' => '0', 'msg' => "Currency mis-match"];
                }

                $chkcres = $this->checkCustomerRestriction($r->customerid);
                if ($chkcres == true) {
                    $this->tracktrails('1', '1', $usern, 'customer', 'Account Restricted');
                    return ['status' => '0', 'msg' => 'Customer Account Has Been Restricted'];
                }

                $chklien = $this->checkCustomerLienStatus($r->customerid);
                if ($chklien['status'] == true && $chklien['lien'] == 2) {
                    $this->tracktrails('1', '1', $usern, 'customer', 'Account has been lien');
                    return ['status' => '0', 'msg' => 'Customer Account Has Been Lien(' . $chklien['message'] . ')...please contact support'];
                }

                $customeracct = Saving::lockForUpdate()->where('customer_id', $r->customerid)->first();
                $customeracct->account_balance += $r->amount;
                $customeracct->save();

                $this->create_saving_transaction(
                    Auth::user()->id,
                    $r->customerid,
                    Auth::user()->branch_id,
                    $r->amount,
                    'credit',
                    'core',
                    '0',
                    null,
                    null,
                    'cgl',
                    null,
                    $trxref2,
                    str_replace("'", "", $r->description),
                    'approved',
                    '2',
                    'trnsfer',
                    $usern
                );

                if (!is_null($cust->exchangerate_id)) {
                    $this->checkforeigncurrncy($cust->exchangerate_id, $r->amount, $trxref2, 'credit');
                } else {
                    if ($glsavingdacct->status == '1') {
                        $this->gltransaction('withdrawal', $glsavingdacct, $r->amount, null);
                        $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $r->amount, 'credit', 'core', $trxref2, $this->generatetrnxref('cr'), 'customer credited', 'approved', $usern);
                    }
                }

                $this->tracktrails(Auth::user()->id, Auth::user()->branch_id, $usern, 'general ledger', 'account reversal');
                $this->reverse_gl_account_transfer($r->options, $r->gl_code2, $r->amount, $branch, $r->gldger_id2, $r->dbit2, 'cgl', $trxref2, str_replace("'", "", $r->description), '');

                DB::commit();

                $smsmsg = "Credit Amt: N" . number_format($r->amount, 2) . "\n Desc: " . str_replace("'", "", $r->description) . " \n Avail Bal: N" . number_format($customeracct->account_balance, 2) . "\n Date:" . date('Y-m-d') . "\n Ref: " . $trxref2;

                if ($cust->enable_sms_alert) {
                    $this->sendSms(Auth::user()->phone, $smsmsg, $getsetvalue->getsettingskey('active_sms'));
                }

                if ($cust->enable_email_alert) {
                    $msg = "Credit Amt: N" . number_format($r->amount, 2) . "<br> Desc: " . str_replace("'", "", $r->description) . " <br>Avail Bal: N" . number_format($customeracct->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $trxref2;
                    Email::create([
                        'user_id'   => $cust->id,
                        'subject'   => ucwords($getsetvalue->getsettingskey('company_name')) . ' Debit Alert',
                        'message'   => $msg,
                        'recipient' => $cust->email,
                    ]);
                    Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Credit Transaction'], function ($mail) use ($getsetvalue, $cust) {
                        $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                        $mail->to($cust->email);
                        $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert');
                    });
                }

                return ['status' => 'success', 'msg' => 'Reversal Posted Successful'];

            // -----------------------------------------------------------------
            // GL → GL Reversal (gltogl)
            // -----------------------------------------------------------------
            } elseif ($r->options == "gltogl") {
                $this->logInfo("gl to gl Posting", $r->all());

                $this->validate($r, [
                    'amount' => ['required', 'string', 'numeric', 'gt:0'],
                ]);

                $trxref        = $this->generatetrnxref('gltogl');
                $glacct        = GeneralLedger::where('id', $r->gldger_id)->first();
                $glacccuurtyt  = GeneralLedger::where('gl_code', $r->gl_code2)->first();

                if ($glacccuurtyt->currency_id != $glacct->currency_id) {
                    return ['status' => '0', 'msg' => "Currency mis-match"];
                }

                switch ($glacct->gl_type) {
                    case 'asset':
                        $glacct->account_balance -= $r->amount;
                        break;
                    case 'expense':
                        $glacct->account_balance -= $r->amount;
                        break;
                    default:
                        $glacct->account_balance += $r->amount;
                        break;
                }
                $glacct->save();

                $this->create_saving_transaction_gl(Auth::user()->id, $r->gldger_id, $branch, $r->amount, 'credit', 'core', null, $trxref, str_replace("'", "", $r->description), 'approved', $usern);
                $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', $glacct->gl_type . ' account reversal');

                $this->reverse_gl_account_transfer($r->options, $r->gl_code2, $r->amount, $branch, $r->gldger_id2, $r->dbit2, 'gltogl', $trxref, str_replace("'", "", $r->description), '');

                DB::commit();

                return ['status' => 'success', 'msg' => 'Reversal Posted Successful'];
            }

        } catch (\Exception $e) {
            DB::rollBack();
            $this->loginfo("error gl reversal", "Error processing GL reversal");
            return ['status' => '0', 'msg' => "Error processing GL reversal"];
        }
    }

    /*
    |--------------------------------------------------------------------------
    | Reverse Account Transfer
    |--------------------------------------------------------------------------
    */
    public function reverse_account_transfer($amount, $cid, $inita, $tran_type2, $trxref, $desc)
    {
        $usern       = Auth::user()->last_name . " " . Auth::user()->first_name;
        $getsetvalue = new Setting();

        $glsavingdacct = GeneralLedger::select('id', 'status', 'account_balance')->where('gl_code', '20993097')->lockForUpdate()->first();

        $chkcres = $this->checkCustomerRestriction($cid);
        $chklien = $this->checkCustomerLienStatus($cid);
        $cust    = Customer::where('id', $cid)->first();

        if ($chkcres == true) {
            $this->tracktrails('1', '1', $usern, 'customer', 'Account Restricted');
            return ['status' => 'false', 'msg' => 'Customer Account Has Been Restricted'];
        } elseif ($chklien['status'] == true && $chklien['lien'] == 1) {
            $this->tracktrails('1', '1', $usern, 'customer', 'Account Restricted');
            return ['status' => 'false', 'msg' => 'Customer Account Has Been Lien(' . $chklien['message'] . ')...please contact support'];
        }

        $validateuserbalance = $this->validatecustomerbalance($cid, $amount);
        if ($validateuserbalance["status"] == false) {
            $this->tracktrails('1', '1', $usern, 'customer', $validateuserbalance["message"]);
            return ['status' => 'false', 'msg' => $validateuserbalance["message"]];
        }

        $customeracct2 = Saving::lockForUpdate()->where('customer_id', $cid)->first();
        $customeracct2->account_balance -= $amount;
        $customeracct2->save();

        $this->create_saving_transaction(
            Auth::user()->id,
            $cid,
            Auth::user()->branch_id,
            $amount,
            'debit',
            'core',
            '0',
            $trxref,
            null,
            $inita,
            null,
            $this->generatetrnxref('Dr'),
            $desc,
            'approved',
            '1',
            'trnsfer',
            $usern
        );

        if (!is_null($cust->exchangerate_id)) {
            $this->checkforeigncurrncy($cust->exchangerate_id, $amount, $trxref, 'debit');
        } else {
            if ($glsavingdacct->status == '1') {
                $this->gltransaction('deposit', $glsavingdacct, $amount, null);
                $this->create_saving_transaction_gl(null, $glsavingdacct->id, null, $amount, 'debit', 'core', $trxref, $this->generatetrnxref('Dr'), 'customer debited', 'approved', $usern);
            }
        }

        $this->tracktrails(Auth::user()->id, Auth::user()->branch_id, $usern, 'general ledger', 'account reversal');

        $smsmsg = "Debit Amt: N" . number_format($amount, 2) . "\n Desc: " . $desc . " \n Avail Bal: N" . number_format($customeracct2->account_balance, 2) . "\n Date:" . date('Y-m-d') . "\n Ref: " . $trxref;

        if ($cust->enable_sms_alert) {
            $this->sendSms(Auth::user()->phone, $smsmsg, $getsetvalue->getsettingskey('active_sms'));
        }

        if ($cust->enable_email_alert) {
            $msg = "Debit Amt: N" . number_format($amount, 2) . "<br> Desc: " . $desc . " <br>Avail Bal: N" . number_format($customeracct2->account_balance, 2) . "<br> Date: " . date("Y-m-d") . "<br>Ref: " . $trxref;
            Email::create([
                'user_id'   => $cust->id,
                'subject'   => ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert',
                'message'   => $msg,
                'recipient' => $cust->email,
            ]);
            Mail::send(['html' => 'mails.sendmail'], ['msg' => $msg, 'type' => 'Debit Transaction'], function ($mail) use ($getsetvalue, $cust) {
                $mail->from($getsetvalue->getsettingskey('company_email'), ucwords($getsetvalue->getsettingskey('company_name')));
                $mail->to($cust->email);
                $mail->subject(ucwords($getsetvalue->getsettingskey('company_name')) . ' Credit Alert');
            });
        }

        return ['status' => 'success', 'msg' => 'Reversal Posted Successful'];
    }

    /*
    |--------------------------------------------------------------------------
    | Reverse GL Account Transfer
    |--------------------------------------------------------------------------
    */
    public function reverse_gl_account_transfer($opt, $glcode, $amount, $branch, $glid, $dbit2, $inita, $trxref, $desc, $status)
    {
        $usern   = Auth::user()->last_name . " " . Auth::user()->first_name;
        $glacct2 = GeneralLedger::where('id', $glid)->first();

        $balanceAdjustment = function ($type, $amount, $isReversal = true) use ($glacct2) {
            switch ($type) {
                case 'asset':
                case 'expense':
                    $glacct2->account_balance += ($isReversal ? $amount : -$amount);
                    break;
                default:
                    $glacct2->account_balance += ($isReversal ? -$amount : $amount);
                    break;
            }
        };

        if (in_array($opt, ['cgl', 'gltogl'])) {
            $balanceAdjustment($glacct2->gl_type, $amount);
            $glacct2->save();

            $this->create_saving_transaction_gl(Auth::user()->id, $glid, $branch, $amount, 'debit', 'core', $trxref, $this->generatetrnxref($inita), $desc, 'approved', $usern);
            $this->tracktrails(Auth::user()->id, $branch, $usern, 'general ledger', $glacct2->gl_type . ' account reversal');
        }
    }

} 