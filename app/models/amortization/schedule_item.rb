class Amortization::ScheduleItem
  def initialize(start_balance, payment, anual_rate, date)
    @start_balance = start_balance
    @payment = payment
    @rate = anual_rate.to_f
    @date = date
  end

  def build
    @interest = Amortization::CompoundInterest
      .monthly_interest_for(
        @start_balance,
        @rate
      )
    @principal = @payment - @interest
    @end_balance = @start_balance - @principal
    @end_balance = @end_balance < 0.0001 ? 0 : @end_balance
    self
  end

  def start_balance; @start_balance; end
  def end_balance; @end_balance; end
  def interest; @interest; end
  def principal; @principal; end
  def date; @date; end
  def payment; @payment; end
end