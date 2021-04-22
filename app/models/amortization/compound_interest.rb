class Amortization::CompoundInterest
  def initialize(rate, num_of_time_periods, num_of_times_interest_applied)
    @n = num_of_times_interest_applied
    @t = num_of_time_periods
    @r = rate.to_f
  end

  # principal * compound_interest_factor gives compound interest
  # for the month
  def compound_interest_factor
    (1 + @r/@n)**(@n * @t)
  end

  def self.monthly_interest_for(principal, anual_rate, num_of_months_remaining)
    compound_interest_factor = new(anual_rate.to_f/100/12, num_of_months_remaining, 30).compound_interest_factor

    (principal * compound_interest_factor -  principal) / num_of_months_remaining.to_i
    #<-------total remaining compound interest-------->
  end
end