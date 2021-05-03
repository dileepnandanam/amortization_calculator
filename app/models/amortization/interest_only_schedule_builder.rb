class Amortization::InterestOnlyScheduleBuilder < Amortization::ScheduleBuilder
  def build(interest_only_terms = 3)
    schedule_items = []
    fixed_monthly_payment = Amortization::CompoundInterest
      .monthly_interest_for(
        @principal,
        @rate
      )
    current_date = @disbursement_date
    (0..interest_only_terms - 1).each do |term|
      current_date = current_date.next_month.beginning_of_month
      schedule_items << Amortization::ScheduleItem.new(
        @principal, fixed_monthly_payment, @rate, current_date
      ).build
      @principal = schedule_items.last.end_balance
    end
    @disbursement_date = current_date
    @terms = @terms - 3
    schedule_items + super()
  end
end