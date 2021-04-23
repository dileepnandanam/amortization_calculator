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

  def self.monthly_interest_for(principal, anual_rate)
    compound_interest_factor = new(anual_rate.to_f/100/12/30, 30, 1).compound_interest_factor
    (principal * compound_interest_factor -  principal)
  end
end