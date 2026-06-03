@extends('layout.app')
@section('title')
    End of Day Report
@endsection
@section('pagetitle')
End of Day Report
@endsection
@section('content')
  <div class="container">
    <?php 
         $getsetvalue = new \App\Models\Setting();
     ?>
    <div class="row" id="advanced-input">
              <div class="col-md-12">
                <div class="panel widget">
                  <div class="panel-heading">
                    <div style="text-align: end">
                      <a href="{{ route('exporteodreport') }}{{!empty($_SERVER['QUERY_STRING']) ? '?'.$_SERVER['QUERY_STRING'] : '?filter=true&eoddate='.$today}}" class="btn btn-primary btn-sm"><span class="menu-icon"> <i class="fa fa-file-excel-o"></i> </span> Export Excel</a>
                    </div>
                  </div>
                  <div class="panel-body">
                    <div class="row">
                    <div class="col-md-offset-4 col-md-7 col-lg-7 col-sm-12">
                      @include('includes.errors')
                  @include('includes.success')
                    </div>
                    </div>

                    <div class="noprint" style="margin-bottom: 15px">
                        <form action="{{route('eodreport')}}" method="get" onsubmit="thisForm()">
                          <input type="hidden" name="filter" value="true">
                          <table class="table table-bordered table-hover table-sm">
                            <thead>
                              <tr>
                                <th>Date</th>
                                <th></th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <td>
                                  <div class="form-group">
                                    <input type="date" name="eoddate" required id="" class="form-control" value="{{!empty($_GET['eoddate']) ? $_GET['eoddate'] : $today}}">
                                  </div>
                                </td>
                                <td>
                                  <button type="submit" class="btn btn-success btn-sm" id="btnsetsubmit">Generate</button>
                                  <button type="button" class="btn btn-danger btn-sm" onclick="window.location.href='{{route('eodreport')}}'">Reset</button>
                                </td>
                              </tr>
                            </tbody>
                          </table>
                        </form>
                      </div>
                   
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-condensed table-hover table-sm" id="acoff">
                             <thead>
                            <tr>
                                 <th>Sn</th>
                                    <th>Transaction Date</th>
                                     <th>Reference</th>
                                     <th>Amount</th>
                                      <th>Description</th>
                                     <th>Posted by</th>
                                     <th>Approved by</th>
                                     <th>Transaction</th>
                                     <th>Status</th>
                                </tr>
                            </thead>    
                             <tbody>
                                 <?php $i = 0; 
                                 ?>
                            @foreach($data as $key)
                                <tr>
                                     <td>{{ $i+1 }}</td>  
                                        <td>{{date("d-m-Y h:ia",strtotime($key->created_at))}}</td>
                                     
                                         <td>{{$key->reference_no}} </td>

                                         <td> {{number_format($key->amount,2)}} </td>

                                         <td>{!! !is_null($key->notes) ? $key->notes : "N/A" !!}</td>
                                         
                                          <td>
                                            {{ucwords($key->initiated_by)}}
                                         </td>  
                                      <td>
                                        {{ucwords($key->approve_by)}}
                                    </td>
                                    <td>
                                      @if($key->type =="deposit")
                                        <span class="label label-success">Deposit</span>
                                      @endif
                                       @if($key->type =="fixed_deposit")
                                        <span class="label label-success">Fixed Deposit</span>
                                      @endif
                                       @if($key->type =="repayment")
                                   <a class="label label-warning">Loan Repayment</a>
                                  @endif
                                   @if($key->type =="credit")
                                   <a class="label label-success">Credit</a>
                                  @endif
                                   @if($key->type =="debit")
                                   <a class="label label-danger">Debit</a>
                                  @endif
                                      @if($key->type =="investment")
                                        <span class="label label-primary">Investment</span>
                                      @endif
                                       @if($key->type=="withdrawal")
                                        <span class="label label-danger">Withdrawal</span>
                                      @endif
                                       {{-- @if($key->type=="esusu")
                                        <span class="label label-info">Esusu Charge</span>
                                      @endif --}}
                                      @if($key->type=="monthly_charge")
                                        <span class="label label-primary">Monthly Charge</span>
                                      @endif
                                       @if($key->type=="esusu" || $key->type=="transfer_charge")
                                   <span class="label label-primary">Transfer Charge</span>
                                  @endif
                                      @if($key->type=="bank_fees")
                                          <span class="label label-info">Bank Fee</span>
                                      @endif
                                      @if($key->type=="dividend")
                                          <span class="label label-warning">Dividend</span>
                                      @endif
                                      @if($key->type=="interest")
                                       <span class="label label-warning">Interest</span>
                                      @endif
                                      @if($key->type=="inv_int")
                                       <span class="label label-warning">Inv. interest</span>
                                      @endif
                                       @if($key->type=="fd_interest")
                                       <span class="label label-warning">FD Interest</span>
                                      @endif
                                       @if($key->type=="form_fees")
                                       <span class="label label-danger">Loan Form </span>
                                  @endif
                                   @if($key->type=="process_fees")
                                       <span class="label label-danger">Process Fee</span>
                                  @endif
                                       @if($key->type=="loan")
                                      <span class="label label-success">Loan Disbursed</span>
                                  @endif 
                                  @if($key->type=="wht")
                                      <span class="label label-info">Withholding Tax</span>
                                  @endif
                                       @if($key->type=="rev_withdrawal")
                                       <span class="label label-info">Withdrawal Reversed</span>
                                      @endif 
                                       @if($key->type=="rev_fixed_deposit")
                                       <span class="label label-info">Fixed Deposit Reversed</span>
                                      @endif 
                                      
                                       @if($key->type=="rev_deposit")
                                      <span class="label label-info">Deposit Reversed</span>
                                      @endif 
                                  </td>

                                  <td>
                                       <a class="label {{$key->status == 'approved' ? 'label-success' : ($key->status == 'pending' ? 'label-warning' : 'label-danger' )}}">
                                           {{$key->status == 'approved' ? 'Successful' : ($key->status == 'pending' ? 'Pending' : ucfirst($key->status) )}}
                                       </a> 
                                  </td>

                                 
                                </tr>
                                <?php $i++; ?>
                             
                            @endforeach
                           
                            </tbody>
                        </table>
                    </div>

                    {{-- <div class="row" style="float: right;margin-top:10px 0px">
                      {{$customersbal->appends(request()->query())->links()}}
                   </div> --}}

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
    <script type="text/javascript">
  $(document).ready(function(){
    $("#acoff").dataTable({
    'paging':false,
      'lengthChange':false,
      'searching':false,
      'ordering':false,
      'info':false,
    });
  });
</script>
@endsection