<?php

namespace App\Exports;

   use App\Models\SavingsTransaction;
use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\Exportable;

class EODReportExport implements FromView
{
     use Exportable;
   
  
  public function __construct(public bool $filter,public ?string $datavalue)
  {
      $this->filter = $filter;
        $this->datavalue = $datavalue;
  }
  
    public function view(): View
    {
        
        $savingtrx = SavingsTransaction::select('amount','type','notes','reference_no','initiated_by','approve_by','status','created_at')
                                       ->whereDate('created_at', $this->datavalue)->get();
       
         
         return view('reports.export_eodreport',[
                              'data' => $savingtrx
                           ]);
    }
}
