<?php

namespace App\Http\Traites;

use App\Models\FixedDeposit;
use App\Models\InvestmentSchedule;
use App\Models\InvestmetRepayment;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;


trait InvestmentTraite
{
    use AuditTraite;

    public function advanceByPaymentCycle(Carbon $date, $cycle)
    {
        switch ($cycle) {
            case 'monthly':
                $date->addMonthNoOverflow();
                break;

            case 'quarterly':
                $date->addMonthsNoOverflow(3);
                break;

            case 'semi_annually':
                $date->addMonthsNoOverflow(6);
                break;

            case 'annually':
                $date->addYearNoOverflow();
                break;

            case 'daily':
                $date->addDay();
                break;

            default:
                $date->addMonthNoOverflow();
                break;
        }

        return $date;
    }

    public function fd_period($id)
    {
        $fd = FixedDeposit::findorfail($id);

        $period = 0;

        if ($fd->payment_cycle == 'annually') {

            if ($fd->duration_type == 'year') {
                $period = ceil($fd->duration);
            }

            if ($fd->duration_type == 'month') {
                $period = ceil($fd->duration / 12);
            }

            if ($fd->duration_type == 'days') {
                $period = ceil($fd->duration / 365);
            }
        }

        if ($fd->payment_cycle == 'semi_annually') {

            if ($fd->duration_type == 'year') {
                $period = ceil($fd->duration * 2);
            }

            if ($fd->duration_type == 'month') {
                $period = ceil($fd->duration / 6);
            }

            if ($fd->duration_type == 'days') {
                $period = ceil($fd->duration / 182.5);
            }
        }

        if ($fd->payment_cycle == 'quarterly') {

            if ($fd->duration_type == 'year') {
                $period = ceil($fd->duration * 4);
            }

            if ($fd->duration_type == 'month') {
                $period = ceil($fd->duration / 3);
            }

            if ($fd->duration_type == 'days') {
                $period = ceil($fd->duration / 91.25);
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
                $period = ceil($fd->duration / 30);
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
            $interest = InvestmentSchedule::where('fixed_deposit_id', $fd->id)->sum('interest');
            $interestrolvoer = InvestmentSchedule::where('fixed_deposit_id', $fd->id)->sum('rollover');

            return $interest + $interestrolvoer;
        } else {

            $interst = InvestmentSchedule::where('fixed_deposit_id', $id)
                ->where('customer_id', $fd->customer_id)
                ->where('due_date', '<=', $date)->sum('interest');

            $rolover = InvestmentSchedule::where('fixed_deposit_id', $id)
                ->where('customer_id', $fd->customer_id)
                ->where('due_date', '<=', $date)->sum('rollover');

            return $interst + $rolover;
        }
    }

    public function investment_permonth($id, $date = '')
    {
        $fd = FixedDeposit::findorfail($id);

        if ($fd->interest_method == "rollover" || $fd->interest_method == "simple_rollover") {
            $interest = InvestmentSchedule::select('rollover')->where('fixed_deposit_id', $id)
                ->where('customer_id', $fd->customer_id)->first();
            return $interest ? $interest->rollover : 0;
        } else {
            $interest = InvestmentSchedule::select('interest')->where('fixed_deposit_id', $id)
                ->where('customer_id', $fd->customer_id)->first();
            return $interest ? $interest->interest : 0;
        }
    }

    public function investment_total_paid($id, $date = '')
    {
        $fd = FixedDeposit::findorfail($id);
        if (empty($date)) {
            return InvestmetRepayment::where('fixed_deposit_id', $id)
                ->where('customer_id', $fd->customer_id)->sum('amount');
        } else {
            return InvestmetRepayment::where('fixed_deposit_id', $id)
                ->where('customer_id', $fd->customer_id)
                ->where('due_date', '<=', $date)->sum('amount');
        }
    }

  
    public function fd_determine_interest_rate($id)
    {
        $fd = FixedDeposit::findOrFail($id);

        $annualRate = 0;

        if ($fd->interest_period == 'year') {
            $annualRate = $fd->interest_rate;
        } elseif ($fd->interest_period == 'month') {
            $annualRate = $fd->interest_rate * 12;
        } else {
            $annualRate = $fd->interest_rate;
        }

        // Enforced 365-day annualization (was 360)
        $dailyRate = $annualRate / 365;

        switch ($fd->payment_cycle) {
            case 'annually':
                $days = 365;
                break;

            case 'semi_annually':
                $days = 182.5;
                break;

            case 'quarterly':
                $days = 91.25;
                break;

            case 'monthly':
                $days = 30;
                break;

            case 'daily':
                $days = 1;
                break;

            default:
                $days = 0;
                break;
        }

        $interestPercent = $dailyRate * $days;

        return $interestPercent / 100;
    }

    public function determine_rollover_periods($i, $invsch, $interest_rate)
    {
        if ($i > 1) {
            $invsch->rollover       = $invsch->total_interest * $interest_rate;
            $invsch->total_interest = $invsch->rollover + $invsch->total_interest + $invsch->interest;
            $invsch->total_due      = $invsch->total_interest;
        }
    }
} //endtraite