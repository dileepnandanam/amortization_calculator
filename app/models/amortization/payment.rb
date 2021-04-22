class Amortization::Payment
  def initialize(principal, num_of_payments, rate)
    @p = principal
    @n = num_of_payments
    @r = rate.to_f
  end

  def calculate
    factor = get_compound_interest_factor(@r)
    numerator = @p * factor**@n
    denominator = (1 - factor**@n) / (1 - factor)
    numerator/denominator
  end

  # principal * compound_interest_factor gives compount interest
  # for the month
  def get_compound_interest_factor(rate)
    n = 30 # Interest is applied 30 times a month
    r = rate
    t = 1 # Interest calculated for one month
    (1 + r/30 )**(n * t)
  end

  def self.monthly_payment(principal, num_of_months, interest_rate)
    new(
      principal,
      num_of_months,
      interest_rate.to_f/100/12
    ).calculate
  end
end
