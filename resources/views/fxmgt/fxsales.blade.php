@extends('layout.app')
@section('title')
    FX Sales
@endsection
@section('pagetitle')
FX Sales
@endsection
@section('content')
  <div class="container">
    <div class="row" id="advanced-input">
              <div class="col-md-12">
                <div class="panel widget">
                  <div class="panel-heading">
                    <div style="text-align: end">
                       <a href="{{route('managefx.sales')}}" class="btn btn-danger"><span class="menu-icon"> <i class="fa fa-angle-left"></i> </span> Back</a>
                    </div>
                  </div>
                  <div class="panel-body">
                    <div class="row">
                    <div class="col-md-7 col-lg-7 col-sm-12">
                      @include('includes.errors')
                  @include('includes.success')
                    </div>
                    </div>
                    <form class="form-horizontal"  action="{{route('fx_sales.store')}}" method="post" role="form" id="fxsalesform">
                      @csrf
                        <div class="container">
                            <div class="row">
                              <div class="col-md-12 col-lg-12 col-sm-12">
                                <div class="form-group">
                                  <label>Transaction Date</label>
                                    <input class="form-control width-40" type="date" required name="transaction_date" id="fname" autocomplete="off"  value="{{old('transaction_date')}}">
                                </div>
                              </div>
                                <div class="col-md-5 col-lg-5 col-sm-12">
        
                                    <div class="form-group">
                                        <label>Currency</label>
                                            <select name="currency" required class="form-control" autocomplete="off" id="" onchange="document.getElementById('purchaser').value=this.value;document.getElementById('curncy').textContent=this.options[this.selectedIndex].getAttribute('data-name');document.getElementById('exrate').value=this.options[this.selectedIndex].getAttribute('data-id');document.getElementById('dbacct').textContent=this.options[this.selectedIndex].getAttribute('data-name')">
                                                <option selected disabled>Select Currency</option>
                                                @foreach ($currency as $item)
                                                    <option value="{{$item->currency_rate}}" data-id="{{$item->id}}" data-name="{{$item->currency}}">{{ucwords($item->currency)}}</option>
                                                @endforeach
                                            </select>
                                            <input type="hidden" name="exrate" id="exrate" value="">
                                      </div>
        
                                    <div class="form-group">
                                        <label>Customer</label>
                                          <input class="form-control" type="text" required name="customer_name" id="fname" autocomplete="off" placeholder="Enter Customer Name" value="{{old('customer_name')}}">
                                      </div>
        
                                    <div class="form-group">
                                        <label>Purchase Rate</label>
                                          <input class="form-control" type="number" required name="purchase_rate" onkeyup="calculatesales()" id="purchaser" autocomplete="off" placeholder="Enter Purchase Rate" value="{{old('purchase_rate')}}">
                                      </div>
        
                                    <div class="form-group">
                                        <label>Margin</label>
                                          <input class="form-control" type="text" readonly  id="mardgin" placeholder="Sales Margin" value="{{old('sales_margin')}}">
                                          <input class="form-control" type="hidden"  name="sales_margin" id="mardgincal" placeholder="Sales Margin" value="{{old('sales_margin')}}">
                                      </div>
        
                                      <div class="form-group">
                                        <label>Beneficiary </label>
                                          <input class="form-control" type="text" required name="beneficiary"  autocomplete="off" placeholder="Enter Beneficiary" value="{{old('beneficiary')}}">
                                      </div>
                                      <div class="form-group">
                                        <label>Naira Value</label>
                                          <input class="form-control" type="text" readonly  id="naravalue" autocomplete="off" value="{{old('naria_amount')}}">
                                          <input class="form-control" type="hidden" name="naira_amount" id="naravaluecal" autocomplete="off" value="{{old('naria_amount')}}">
                                      </div>
                                      <div class="form-group">
                                        <p>Amount Payable</p>
                                        <h3 id="amtpayable" class="text-info"></h3>
                                      </div>
                                </div>
        
                                <div class="col-md-1 col-lg-1"></div>
        
                                <div class="col-md-5 col-lg-5 col-sm-12">
        
                                    <div class="form-group">
                                        <label>Relation Officer</label>
                                            <select name="relation_officer" class="form-control" autocomplete="off" id="rofficer">
                                                <option selected disabled>Select Account Officer</option>
                                                @foreach ($getofficers as $item)
                                                    <option value="{{$item->id}}">{{ucwords($item->full_name)}}</option>
                                                @endforeach
                                            </select>
                                      </div>
        
                                    <div class="form-group">
                                        <label>Amount (<span id="curncy" class="text-danger" style="text-transform: uppercase"></span>)</label>
                                          <input class="form-control" type="number" onkeyup="calculatesales()" required name="amount" id="amount" autocomplete="off" placeholder="Enter Amount" value="{{old('amount')}}">
                                      </div>
        
                                    <div class="form-group">
                                        <label>Sales Rate</label>
                                          <input class="form-control" type="number" required name="sales_rate" id="salerate" onkeyup="calculatesales()" autocomplete="off" placeholder="Enter Sales Rate" value="{{old('sales_rate')}}">
                                      </div>
        
                                    <div class="form-group">
                                        <label>Other Charges</label>
                                          <input class="form-control" type="number"  name="other_charge" id="othchge" onkeyup="calculatesales()" autocomplete="off" placeholder="Enter Other Charges" value="0">
                                      </div>
                                      
                                    <div class="form-group">
                                        <label>Beneficiary Bank</label>
                                          <input class="form-control" type="text" required name="beneficiary_bank"  autocomplete="off" placeholder="Enter Beneficiary Bank" value="{{old('beneficiary_bank')}}">
                                      </div>

                                      <div class="form-group">
                                        <label>Depositor</label>
                                          <input class="form-control" type="text" required  name="depositor"  autocomplete="off" placeholder="Enter Depositor" value="{{old('depositor')}}">
                                      </div>
                                      
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea name="description" id="descriptn" placeholder="Optional" cols="5" rows="2"></textarea>
                                      </div>
                                </div>
                              </div>
                              <hr>
                              <h3>Payments</h3>
                              <div class="row">
                                <div class="col-md-5 col-lg-5 col-sm-12">

                                  <div class="form-group">
                                    <label>Swift/Bank Charge</label>
                                      <input class="form-control" type="number" required  name="bank_charge"  autocomplete="off" placeholder="Enter Bank Charge" value="{{old('bank_charge')}}">
                                  </div>

                                    <div class="form-group">
                                        <label>Authoriser</label>
                                            <select name="authoriser" required class="form-control"  autocomplete="off" id="authriz">
                                                <option selected disabled>Select Authoriser</option>
                                                @foreach ($users as $user)
                                                    <option value="{{$user->id}}">{{ucwords($user->last_name." ".$user->first_name)}}</option>
                                                @endforeach
                                            </select>
                                      </div>

                                    
                                        <p style="font-weight: bold">Sales Margin GL (NGN)</p>
                                       
                                            <div class="form-group">
                                              <select name="debitglmargin" class="form-control glcrmr"  autocomplete="off">
                                                <option selected disabled>Select Sales Margin Account To Debit</option>
                                                @foreach ($generalledgers as $critem)
                                                     <option value="{{$critem->id}}">{{ucwords($critem->gl_name)}}</option>
                                                @endforeach
                                            </select>
                                            </div>

                                            <div class="form-group">
                                              <select name="glmargin" class="form-control glcrmr"  autocomplete="off">
                                                <option selected disabled>Select Income Sales Margin Account GL </option>
                                                @foreach ($incmgeneralledgers as $critem)
                                                     <option value="{{$critem->id}}">{{ucwords($critem->gl_name)}}</option>
                                                @endforeach
                                            </select>
                                            </div>
                                        

                                        <div class="form-group">
                                        <label>Debit Account GL(<span id="dbacct" class="text-danger" autocomplete="off" style="text-transform: uppercase"></span>)</label>
                                        <select name="gldebit" class="form-control gldb">
                                            <option selected disabled>Select Account</option>
                                            @foreach ($generalledgers as $dbitem)
                                            <option value="{{$dbitem->id}}">{{ucwords($dbitem->gl_name)}}</option>
                                            @endforeach
                                        </select>
                                      </div>
                                      <div class="form-group">
                                        <label>Credit Account GL</label>
                                        <select name="glcredit" class="form-control gldb">
                                            <option selected disabled>Select Account</option>
                                            @foreach ($generalledgers as $dbitem)
                                            <option value="{{$dbitem->id}}">{{ucwords($dbitem->gl_name)}}</option>
                                            @endforeach
                                        </select>
                                      </div>

                                </div>
        
                                <div class="col-md-1 col-lg-1"></div>
        
                                <div class="col-md-5 col-lg-5 col-sm-12">
                                    <div class="form-group">
                                        <label>Payment Mode</label>
                                            <select name="payment_mode" required class="form-control"  autocomplete="off" id=""
                                             onchange="paymentmod(this.value)">
                                                <option selected disabled>Select Mode</option>
                                                <option value="cash">Cash</option>
                                                <option value="bank">Payment To Bank</option>
                                                <option value="customer">Debit Customer</option>
                                            </select>
                                      </div>
                                      <div class="form-group">
                                        <label><span id="lable1"></span></label>
                                        <select name="gldebitnaria" class="form-control glcr" id="gldb">
                                            <option selected disabled>Select Account</option>
                                            @foreach ($generalledgersnaira as $dbitem)
                                            <option value="{{$dbitem->id}}">{{ucwords($dbitem->gl_name)}}</option>
                                            @endforeach
                                        </select>
                                      </div>

        
                                      <div class="form-group">
                                        <label><span id="lable2"></span></label>
                                        <div id="pgl">
                                            <select name="glcreditnaria" class="form-control width-100 glcr" autocomplete="off">
                                                <option selected disabled>Select Account</option>
                                                @foreach ($generalledgersnaira as $critem)
                                                     <option value="{{$critem->id}}">{{ucwords($critem->gl_name)}}</option>
                                                @endforeach
                                            </select>
                                        </div>
        
                                        <div id="pcustomer" style="display: none">
                                            <select name="customeid" class="form-control width-100 glcr" autocomplete="off" id="cusrt" style="width:100% !important">
                                                <option selected disabled>Select Customer</option>
                                                @foreach ($customers as $item)
                                                     <option value="{{$item->id}}">{{ucwords($item->last_name." ".$item->first_name)}}</option>
                                                @endforeach
                                            </select>
                                          </div>
                                      </div>
        
                                      <div class="form-group">
                                        <label>Amount</label>
                                          <input class="form-control" type="number" readonly id="totamontt" autocomplete="off" placeholder="Enter Amount" value="{{old('amount')}}">
                                      </div>
                                </div>
                              </div>
        
                              <input class="width-70 form-control" type="hidden" name="fxtype"  value="sales">
                                <div class="form-group form-actions">
                                    <div class="col-sm-4"> </div>
                                    <div class="col-sm-7">
                                      <button class="btn vd_btn vd_bg-green vd_white" type="submit" id="btnssubmit"><i class="icon-ok"></i>Save Record</button>
                                      
                                    </div>
                                  </div>
                        </div>
                    </form>
                  </div>
                </div>
                <!-- Panel Widget --> 
              </div>
              <!-- col-md-12 --> 
            </div>
            <!-- row -->
  </div>
@endsection
@section('scripts')
<script>
  $(document).ready(function(){
  $(".gldb").select2();
  $(".glcr").select2();
  $(".glcrmr").select2();
  $("#authriz").select2();
  $("#rofficer").select2();

  $("#fxsalesform").submit(function(e){
    e.preventDefault();
    $.ajax({
      url: $("#fxsalesform").attr('action'),
      method: "post",
      data: $("#fxsalesform").serialize(),
      beforeSend:function(){
        $("#btnssubmit").text('Please wait...');
          $("#btnssubmit").attr('disabled',true);
      },
      success:function(data){
        if(data.status == 'success'){
            $("#btnssubmit").text('Save Record');
          $("#btnssubmit").attr('disabled',false);
          toastr.success(data.msg);
           window.location.href="{{route('managefx.sales')}}";
          }else{
            toastr.error(data.msg);
             $("#btnssubmit").text('Save Record');
           $("#btnssubmit").attr('disabled',false);
             return false;
           }
        },
        error:function(xhr,status,errorThrown){
          let err = '';
          $.each(xhr.responseJSON.errors, function (key, value) {
                err += value;
            });
            toastr.error(err);
          $("#btnssubmit").text('Save Record');
          $("#btnssubmit").attr('disabled',false);
          return false;
        }
      });
  });

  });
</script>

<script>
    function paymentmod(value){
        if(value == "customer"){
            document.getElementById('pcustomer').style.display='block';
            document.getElementById('pgl').style.display='none';
            document.getElementById('lable2').textContent='Debit Account (NGN)';
            document.getElementById('lable1').textContent='Credit Account (NGN)';
         }else{
            document.getElementById('pcustomer').style.display='none';
            document.getElementById('pgl').style.display='block';
             document.getElementById('lable2').textContent='Credit Account (NGN)';
            document.getElementById('lable1').textContent='Debit Account (NGN)';
         }
    }

    function calculatesales(){
       let purchrate = document.getElementById('purchaser').value;
       let salesrate = document.getElementById('salerate').value;
       let amount = document.getElementById('amount').value;
       let otherchage = document.getElementById('othchge').value;
       let marginv = document.getElementById('mardgin');
       let marginvcal = document.getElementById('mardgincal');
       let nariavalue = document.getElementById('naravalue');
       let nariavaluecal = document.getElementById('naravaluecal');
       let totnavalue = document.getElementById('totamontt');
       let payable = document.getElementById('amtpayable');
       let descptn = document.getElementById('descriptn');
       let curncytype = document.getElementById('curncy').textContent;

       let amct = parseFloat(salesrate) * parseFloat(amount);
      let prate = parseFloat(purchrate) * parseFloat(amount);
       let nariale = amct + parseFloat(otherchage);
       let margindat = amct - prate;

       marginv.value = Number(margindat).toLocaleString('en');
       marginvcal.value = margindat;
       nariavalue.value = Number(nariale).toLocaleString('en');
       nariavaluecal.value = nariale;
       totnavalue.value = nariale;
       payable.textContent = Number(nariale).toLocaleString('en');
       descptn.value = "@"+salesrate+"/"+amount+"("+curncytype+")";
    }
</script>
@endsection