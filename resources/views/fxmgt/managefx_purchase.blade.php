@extends('layout.app')
@section('title')
    Manage Fx Purchase
@endsection
@section('pagetitle')
Manage Fx Purchase
@endsection
@section('content')
  <div class="container">
    <div class="row" id="advanced-input">
              <div class="col-md-12">
                <div class="panel widget">
                    <div class="panel-heading">
                        <div style="text-align: end">
                          @can('fx purchase')
                           <a href="{{route('fx_purchase.create')}}" class="btn btn-default"><span class="menu-icon"> <i class="fa fa-plus"></i> </span>Create Purchase</a>
                           @endcan
                          </div>
                      </div>
                  <div class="panel-body">

                    <div class="row">
                    <div class="col-md-12 col-lg-12 col-sm-12">
                  @include('includes.success')
                    </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-condensed table-hover" id="acoff">
                            <thead>
                                <tr>
                                    <th>Sn</th>
                                    <th>Purchased Rate</th>
                                    <th>Naira Amount</th>
                                    <th>Foreign Amount</th>
                                    <th>Currency</th>
                                    <th>Reference</th>
                                    <th>Payment Mode</th>
                                    <th>Trnx Date</th>
                                    <th></th>
                                </tr>
                            </thead>    
                            <tbody>
                                <?php $i=0;?>
                                @foreach ($purchases as $purch)
                                <tr>
                                    <td>{{$i+1}}</td>
                                    <td>{{number_format($purch->purchase_exchange_rate,2)}}</td>
                                    <td>{{number_format($purch->naria_amount,2)}}</td>
                                    <td>{{number_format($purch->foreign_amount,2)}}</td>
                                    <td>{{$purch->exchangerate->currency}}</td>
                                    <td>{{$purch->fx_reference}}</td>
                                    <td>{{$purch->payment_mode}}</td>
                                    <td>{{date("d-m-Y",strtotime($purch->tranx_date))}}</td>
                                    <td>
                                      <a href="javascript:void(0)" onclick="viewfxdetails('{{route('fx.purchase.details',['id' => $purch->id])}}','purchase')" title="View" class="btn menu-icon vd_bd-blue vd_blue btn-sm"><i class="fa fa-eye"></i> </a>
                                    </td>
                                </tr>
                                <?php $i++?>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                  </div>
                </div>
                <!-- Panel Widget --> 
              </div>
              <!-- col-md-12 --> 
            </div>
            <!-- row -->
  </div>

  <!-- Modal -->
 <div class="modal fade" id="pmyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header vd_bg-blue vd_white">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
        <h4 class="modal-title" id="myModalLabel">FX Purchase Details</h4>
      </div>
      <div class="modal-body"> 
        <div class="table-responsive">
          <table class="table table-bordered table-striped table-condensed table-hover table-sm">
              <tbody id="purdetails">
              </tbody>
          </table>
        </div>
      </div>
       <input type="hidden" value="" id="fxsalesid">
        <input type="hidden" value="{{url('fx/approve')}}" id="fxurl">
      <div class="modal-footer background-login">
        <button type="button" class="btn vd_btn vd_bg-grey" data-dismiss="modal">Close</button>
         <button class="btn vd_btn vd_bg-green vd_white" id="appvbtnssubmit"><i class="icon-ok"></i>Approve Record</button>
      </div>
    
    </div>
    <!-- /.modal-content --> 
  </div>
  <!-- /.modal-dialog --> 
</div>
<!-- /.modal --> 
@endsection
@section('scripts')
    <script type="text/javascript">
  $(document).ready(function(){
    $("#acoff").dataTable({'pageLength':25,
    'dom': 'Bfrtip',
      buttons: [ 'copy', 'csv', 'print','pdf']
  });

   $("#appvbtnssubmit").click(function(){

      var fxid = $("#fxsalesid").val();
  var fxurl = $("#fxurl").val();

      if(fxid == ''){
        toastr.error('Invalid FX Record Selected');
        return false;
      }

      $.ajax({
        url: fxid,
        method: "get",
        beforeSend:function(){
         $("#appvbtnssubmit").attr('disabled', false);
           $("#appvbtnssubmit").text('Please wait...');
        },
        success:function(data){
          if(data.status == 'success'){
                     $("#appvbtnssubmit").attr('disabled', false);
           $("#appvbtnssubmit").text('Approve Record');
            toastr.success(data.msg);
              location.reload();
            }else{
              toastr.error(data.msg);
                      $("#appvbtnssubmit").attr('disabled', false);
           $("#appvbtnssubmit").text('Approve Record');
             return false;
             }
          },
          error:function(xhr,status,errorThrown){
              $("#appvbtnssubmit").attr('disabled', false);
           $("#appvbtnssubmit").text('Approve Record');
              toastr.error('Error '+errorThrown);
            return false;
          }
        });
   });

  });
</script>
<script>
  function viewfxdetails(durl,ty){
  
    $.ajax({
      url: durl+"?fxty="+ty,
      method: "get",
      beforeSend:function(){
        $(".loader").css('visibility','visible');
          $(".loadingtext").text('Please wait...');
      },
      success:function(data){
        if(data.status == 'success'){
            $(".loader").css('visibility','hidden');
          toastr.success(data.msg);
          $("#pmyModal").modal("show");
            $("#purdetails").html(data.data);
            $("#fxsalesid").val(data.fxid);

            if(data.fxstatus === 'approved'){
              document.getElementById("appvbtnssubmit").style.display = 'none';
            }

          }else{
            toastr.error(data.msg);
            $(".loader").css('visibility','hidden');
           return false;
           }
        },
        error:function(xhr,status,errorThrown){
            $(".loader").css('visibility','hidden');
            toastr.error('Error '+errorThrown);
          return false;
        }
      });
  
  }
</script>
@endsection
