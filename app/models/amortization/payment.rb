class Amortization::Payment
  #given bank policies
  NUM_OF_TIME_PERIODS = 1
  NUM_OF_TIMES_INTEREST_APPLIED = 30

  def initialize(principal, num_of_payments, rate)
    @p = principal
    @n = num_of_payments
    @r = rate.to_f
  end

  def calculate
    return @p/@n if @r == 0
    factor = Amortization::CompoundInterest
      .new(@r, NUM_OF_TIME_PERIODS, NUM_OF_TIMES_INTEREST_APPLIED)
      .compound_interest_factor

    numerator = @p * factor**@n
    denominator = (1 - factor**@n) / (1 - factor)
    numerator/denominator
  end

  def self.monthly_payment(principal, num_of_months, anual_interest_rate)
    new(
      principal,
      num_of_months,
      anual_interest_rate.to_f/100/12
    ).calculate
  end
end
