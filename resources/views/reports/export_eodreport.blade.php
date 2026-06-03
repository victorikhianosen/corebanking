<table class="table table-striped table-bordered table-condensed table-hover table-sm" id="acoff">
                             <thead>
                            <tr>
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
                             
                            @foreach($data as $key)
                                <tr>
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
                             
                            @endforeach
                           
                            </tbody>
                        </table>