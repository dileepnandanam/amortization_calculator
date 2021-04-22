class Amortization::Payment
  def initialize(principal, num_of_payments, rate)
    @p = principal
    @n = num_of_payments
    @r = rate.to_f
  end

  def calculate
    numerator = @r * ((1 + @r)**@n)
    denominator = (1 + @r)**@n - 1
    @p * numerator/denominator
  end

  def self.monthly_payment(principal, num_of_months, interest_rate)
    new(
      principal,
      num_of_months,
      interest_rate.to_f/100/12
    ).calculate
  end
end
