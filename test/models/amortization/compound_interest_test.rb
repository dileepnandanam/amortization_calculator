require 'test_helper'

class Amortization::CompoundInterestTest < ActiveSupport::TestCase
  test 'monthly_interest_for to return correct amount' do
    principal = 10000
    anual_rate = 10.0
    total_months = 12
    interest = Amortization::CompoundInterest.monthly_interest_for(
      principal,
      anual_rate
    )
    assert_equal interest, 83.669853314379
  end
    
  test 'compound_interest_factor to return correct amount' do
    principal = 10000
    monthly_rate = 10.0/100/12
    num_of_time_periods = 10
    num_of_times_interest_applied = 10

    factor = Amortization::CompoundInterest.new(
      monthly_rate,
      num_of_time_periods,
      num_of_times_interest_applied
    ).compound_interest_factor
    total = principal * factor
    assert_equal total, 10868.663314051639
  end
end
