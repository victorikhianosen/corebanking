<?php 
namespace App\Http\Traites;

use App\Models\FixedDeposit;
use App\Models\InvestmentSchedule;
use App\Models\InvestmetRepayment;
use Illuminate\Support\Facades\Auth;


trait InvestmentTraite{
     use AuditTraite;
     
    public function fd_period($id){
        $fd = FixedDeposit::findorfail($id);

        $period = 0;

        if ($fd->payment_cycle == 'annually') {

            if ($fd->duration_type == 'year') {

                $period = ceil($fd->duration);

            }

            if ($fd->duration_type == 'month') {

                $period = ceil($fd->duration * 12);

            }

              if ($fd->duration_type == 'days') {

                $period = ceil($fd->duration);

            }

        }

        if ($fd->payment_cycle == 'semi_annually') {

            if ($fd->duration_type == 'year') {

                $period = ceil($fd->duration * 2);

            }

            if ($fd->loan_duration_type == 'month') {

                $period = ceil($fd->loan_duration * 6);

            }

              if ($fd->duration_type == 'days') {

                $period = ceil($fd->duration);

            }

        }

        if ($fd->payment_cycle == 'quarterly') {

            if ($fd->duration_type == 'year') {

                $period = ceil($fd->duration);

            }

            if ($fd->duration_type == 'month') {

                $period = ceil($fd->duration * 12);

            }
              if ($fd->duration_type == 'days') {

                $period = ceil($fd->duration);

            }

        }


        if ($fd->payment_cycle == 'monthly') {

            if ($fd->duration_type == 'year') {

                $period = ceil($fd->duration * 12);

            }

            if ($fd->duration_type == 'month') {

                $period = ceil($fd->duration);

            }
              if ($fd->duration_type == 'days') {

                $period = ceil($fd->duration);

            }

        }

        if ($fd->payment_cycle == 'daily') {

            if ($fd->duration_type == 'year') {

                $period = ceil($fd->duration * 365);

            }

            if ($fd->duration_type == 'month') {

                $period = ceil($fd->duration * 30);

            }

            if ($fd->duration_type == 'days') {

                $period = ceil($fd->duration);

            }

        }

        return $period;
    }

    public function investment_total_interest($id, $date = '')
    {
        $fd = FixedDeposit::findorfail($id);
        if (empty($date) || $date == "") {
//->where('customer_id',$fd->customer_id)
            $interest = InvestmentSchedule::where('fixed_deposit_id',$fd->id)->sum('interest');

            $interestrolvoer = InvestmentSchedule::where('fixed_deposit_id',$fd->id)->sum('rollover');

            return $interest + $interestrolvoer;
            
        } else {

            $interst =  InvestmentSchedule::where('fixed_deposit_id', $id)
                                        ->where('customer_id',$fd->customer_id)
                                        ->where('due_date', '<=', $date)->sum('interest');

            $rolover= InvestmentSchedule::where('fixed_deposit_id', $id)
                                        ->where('customer_id',$fd->customer_id)
                                        ->where('due_date', '<=', $date)->sum('rollover');

           return $interst + $rolover;
        }

    }

    public function investment_permonth($id, $date = ''){
        $fd = FixedDeposit::findorfail($id);
        if (empty($date)) {
            if($fd->interest_method == "rollover" || $fd->interest_method == "simple_rollover"){
                $interest = InvestmentSchedule::select('rollover')->where('fixed_deposit_id', $id)
                                                ->where('customer_id',$fd->customer_id)->first();
                 return $interest->rollover;
            }else{
                $interest = InvestmentSchedule::select('interest')->where('fixed_deposit_id', $id)
                                                ->where('customer_id',$fd->customer_id)->first();
                 return $interest->interest;
            }
           
        } else {

            if($fd->interest_method == "rollover" || $fd->interest_method == "simple_rollover"){
                $interest = InvestmentSchedule::select('rollover')->where('fixed_deposit_id', $id)
                                                ->where('customer_id',$fd->customer_id)->first();
                 return $interest->rollover;
            }else{
                $interest = InvestmentSchedule::select('interest')->where('fixed_deposit_id', $id)
                                                ->where('customer_id',$fd->customer_id)->first();
                 return $interest->interest;
            }
        }
    }

    public function investment_total_paid($id, $date = '')
 
    {
        $fd = FixedDeposit::findorfail($id);
        if (empty($date)) {

            return InvestmetRepayment::where('fixed_deposit_id', $id)
                                        ->where('customer_id',$fd->customer_id)->sum('amount');

        } else {

            return InvestmetRepayment::where('fixed_deposit_id', $id)
                                        ->where('customer_id',$fd->customer_id)
                                        ->where('due_date', '<=', $date)->sum('amount');
        }
    }


    // public function fd_determine_interest_rate($id)
    // {
    //     $fd = FixedDeposit::findorfail($id);
    //     $interest = '';

    //         if ($fd->payment_cycle == 'annually') {

    //             //return the interest per year

    //             if ($fd->interest_period == 'year') {

    //                 $interest = $fd->interest_rate;

    //             }

    //             if ($fd->interest_period == 'month') {

    //                 $interest = $fd->interest_rate * 12;

    //             }

    //         }

    //         if ($fd->payment_cycle == 'semi_annually') {

    //             //return the interest per semi annually

    //             if ($fd->interest_period == 'year') {

    //                 $interest = $fd->interest_rate / 2;

    //             }

    //             if ($fd->interest_period == 'month') {

    //                 $interest = $fd->interest_rate * 6;

    //             }

    //         }

    //         if ($fd->payment_cycle == 'quarterly') {

    //             //return the interest per quaterly
    //             if ($fd->interest_period == 'year') {
    //                 $interest = $fd->interest_rate / 4;

    //             }

    //             if ($fd->interest_period == 'month') {

    //                 $interest = $fd->interest_rate * 3;

    //             }

    //         }


    //         if ($fd->payment_cycle == 'monthly') {

    //             //return the interest per monthly

    //             if ($fd->interest_period == 'year') {

    //                 $interest = $fd->interest_rate / 12;
    //             }

    //             if ($fd->interest_period == 'month') {
                    
    //                 $interest = $fd->interest_rate * 1;

    //             }

    //         }
       
    //     return $interest / 100; 
    // }

 

// public function fd_determine_interest_rate($id)
// {
    // $fd = FixedDeposit::findorfail($id);
    // $interest = '';

    // if ($fd->payment_cycle == 'annually') {

    //     // return the interest per year

    //     if ($fd->interest_period == 'year') {

    //         $daily_rate = $fd->interest_rate / 365;
    //         $interest = $daily_rate * 365;

    //     }

    //     if ($fd->interest_period == 'month') {

    //         $daily_rate = $fd->interest_rate / 365;
    //         $interest = $daily_rate * 365;

    //     }

    // }

    // if ($fd->payment_cycle == 'semi_annually') {

    //     // return the interest per semi annually

    //     if ($fd->interest_period == 'year') {

    //         $daily_rate = $fd->interest_rate / 365;
    //         $interest = $daily_rate * (365 / 2);

    //     }

    //     if ($fd->interest_period == 'month') {

    //         $daily_rate = $fd->interest_rate / 365;
    //         $interest = $daily_rate * (365 / 2);

    //     }

    // }

    // if ($fd->payment_cycle == 'quarterly') {

    //     // return the interest per quarterly

    //     if ($fd->interest_period == 'year') {

    //         $daily_rate = $fd->interest_rate / 365;
    //         $interest = $daily_rate * (365 / 4);

    //     }

    //     if ($fd->interest_period == 'month') {

    //         $daily_rate = $fd->interest_rate / 365;
    //         $interest = $daily_rate * (365 / 4);

    //     }

    // }

    // if ($fd->payment_cycle == 'monthly') {

    //     // return the interest per monthly

    //     if ($fd->interest_period == 'year') {

    //         $daily_rate = $fd->interest_rate / 365;
    //         $interest = $fd->interest_rate / 365;//$daily_rate * (365 / 12);

    //     }

    //     if ($fd->interest_period == 'month') {

    //         $daily_rate = $fd->interest_rate / 365;
    //         $interest = $fd->interest_rate / 365;//$daily_rate * (365 / 12);

    //     }

    // }

    // if ($fd->payment_cycle == 'daily') {

    //     if ($fd->interest_period == 'year') {
    //         $interest = $fd->interest_rate / 365;
    //     }

    //     if ($fd->interest_period == 'month') {
    //         $interest = $fd->interest_rate / 365;
    //     }
    // }

    // return $interest / 100 * 30;
//}

public function fd_determine_interest_rate($id)
{
    
    $fd = FixedDeposit::findOrFail($id);

    /*
    |--------------------------------------------------------------------------
    | 1️⃣ NORMALIZE TO ANNUAL RATE (APR)
    |--------------------------------------------------------------------------
    */
    $annualRate = 0;
    $rate = 365;

    if ($fd->interest_period == 'year') {

        $annualRate = $fd->interest_rate;

    } elseif ($fd->interest_period == 'month') {

        $annualRate = $fd->interest_rate * 12;

    }


    /*
    |--------------------------------------------------------------------------
    | 2️⃣ CONVERT TO DAILY RATE (365 BASIS)
    |--------------------------------------------------------------------------
    */
    $dailyRate = $annualRate / $rate; // 365 or 360 basis


    switch ($fd->payment_cycle) {

        case 'annually':
            $days = 365;
            break;

        case 'semi_annually':
            $days = 182.5; // approx
            break;

        case 'quarterly':
            $days = 91.25; // approx
            break;

        case 'monthly':
            $days = 30; // standard banking approx
            break;

        default:
            $days = 0;
            break;
    }

    $interest = $dailyRate * $days;

    
     // RETURN AS DECIMAL
    
    return $interest / 100;


}

    public function determine_rollover_periods($i,$invsch,$interest_rate){
        if ($i > 1) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 2) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 3) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 4) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 5) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 6) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 7) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 8) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 9) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 10) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 11) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;

        } 
        if ($i > 12) {

            $invsch->rollover =  $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due =  $invsch->total_interest;
        } 
    }
}//endtraite