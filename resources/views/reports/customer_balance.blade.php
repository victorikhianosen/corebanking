@extends('layout.app')
@section('title')
    Customer Balance
@endsection
@section('pagetitle')
Customer Balance
@endsection
@section('content')
  <div class="container">
    <?php
    $getsetvalue = new \App\Models\Setting();
   ?>
    @inject('getloan', 'App\Http\Controllers\ReportsController')

    <div class="row" id="advanced-input">
              <div class="col-md-12">
                <div class="panel widget">
                  <div class="panel-heading">
                  </div>
                  <div class="panel-body">
                    
                      <div class="noprint" style="margin-bottom: 15px">
                        <form action="{{route('report.customerbal')}}" method="get" onsubmit="thisForm()">
                          <input type="hidden" name="filter" value="true">
                          <table class="table table-bordered table-hover table-sm">
                            <thead>
                              <tr>
                                <th>Filter Type</th>
                                 <th>Filter Account In</th>
                                <th></th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <td>
                                  <div class="form-group">
                                    <select name="fetchby" class="form-control" required onchange="if(this.value=='byname'){document.getElementById('byname').style.display='block';document.getElementById('byacct').style.display='none';}
                                    else if(this.value=='byaccount'){document.getElementById('byacct').style.display='block';document.getElementById('byname').style.display='none';}else{document.getElementById('byacct').style.display='none';document.getElementById('byname').style.display='none';}">
                                        <option value="all">Fetch All Customers</option>
                                        <option value="byname">Fetch Customer by Name</option>
                                        <option value="byaccount">Fetch Customer by Account No</option>
                                    </select>
                                  </div>
                                  <div class="form-group" id="byname" style="display: none">
                                    <input type="text" name="name" placeholder="Enter Customer Name" class="form-control">
                                  </div>
                                  <div class="form-group" id="byacct" style="display: none">
                                    <input type="number" name="acctno" placeholder="Enter Account No" class="form-control">
                                  </div>
                                </td>
                                
                                 <td>
                                         <div class="form-group controls">
                                          <select name="balance_type" class="width-90 form-control" autocomplete="off">
                                              <option selected disabled>Select Balance Type</option>
                                            <option value="credit" {{!empty($_GET['balance_type']) && $_GET['balance_type'] == "credit"  ? "selected" : "" }}>Credit</option>
                                            <option value="debit" {{!empty($_GET['balance_type']) && $_GET['balance_type'] == "debit"  ? "selected" : "" }}>Debit</option>
                                          </select>
                                      </div> 
                                    </td>                 
                                    
                                <td>
                                  <button type="submit" class="btn btn-success btn-sm" id="btnsetsubmit">Generate Report</button>
                                  <button type="button" class="btn btn-danger btn-sm" onclick="window.location.href='{{route('report.customerbal')}}'">Reset</button>
                                </td>
                              </tr>
                            </tbody>
                          </table>
                        </form>
                      </div>
                      @if (!empty($_GET['filter']) && $_GET['filter'] == true)
                      <div class="box-body table-responsive no-padding">
                        <table id="custmer" class="table table-bordered table-striped table-condensed table-hover table-sm">
                            <thead>
                                <tr style="background-color: #D1F9FF">
                                     <th>Sn</th>
                                         <th>Name</th>
                                        <th>Account Officer</th>
                                         <th>Phone No</th>
                                        <th>Account No</th>
                                        <th>Currency</th>
                                        <th>Balance</th>
                                    </tr>
                                </thead>
                                <tbody>
                                     {{-- ucwords($savingprod->name ?? "") --}}
                                    <?php $i=0; $balan=0;?>
                                   @foreach($data as $key)

                                        @php
                                            // Determine operator based on filter
                                            $op = null;
                                    
                                            if ($bal === 'credit') {
                                                $op = '>';
                                            } elseif ($bal === 'debit') {
                                                $op = '<';
                                            }
                                    
                                            // Fetch matching savings record
                                            $customacct = DB::table('savings')
                                                ->where('customer_id', $key->id)
                                                ->when($op, function ($q) use ($op) {
                                                    return $q->where('account_balance', $op, 0);
                                                })
                                                ->first();

                                             $exchg = DB::table('exchangerates')->where('id',$key->exchangerate_id)->first();

                                        @endphp
                                    
                                        {{-- Skip customers with no matching savings balance --}}
                                        @if (!$customacct)
                                            @continue
                                        @endif
                                    
                                        <tr>
                                            <td>{{ $i + 1 }}</td>
                                            <td>{{ ucwords($key->first_name." ".$key->last_name) }}</td>
                                    
                                            <td>{{ $key->accountofficer->full_name ?? 'N/A' }}</td>
                                            <td>{{ $key->phone }}</td>
                                            <td>{{ $key->acctno }}</td>
                                      <td>
                                         {{empty($exchg) ? 'Naira' : ucwords($exchg->currency)}}
                                      </td>
                                            <td>{{ number_format($customacct->account_balance, 2) }}</td>
                                        </tr>
                                    
                                        @php 
                                        $i++; 
                                        $balan +=$customacct->account_balance;
                                        @endphp
                                    
                                    @endforeach

                                    </tbody>
                                    <tfoot>
                                          <tr>
                                     <td></td>
                                         <td></td>
                                         <td></td>
                                        <td></td>
                                         <td></td>
                                         <td></td>
                                        <td>{{ number_format($balan, 2) }}</td>
                                    </tr>
                                    </tfoot>
                        </table>
            
                    </div>
                      @else
                      <div class="alert alert-info">Please select a Filter Type and click on generate report button</div>
                  @endif
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
    $("#custmer").dataTable({
    'pageLength':25,
    'dom': 'Bfrtip',
      buttons: [ 'copy', 'csv', 'print','pdf']
  });
  });
</script>
<script>
  //  function printsection() {
  //   document.getElementById("noprint").style.display='none';
  // var divContents = document.getElementById("printdiv").innerHTML;
  // var a = window.open('', '', 'height=500, width=500');
  // a.document.write('<html>');
  // a.document.write('<body >');
  // a.document.write(divContents);
  // a.document.write('</body></html>');
  // a.document.close();
  // a.print();
  // }
</script>
@endsection