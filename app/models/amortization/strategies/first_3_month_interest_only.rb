class Amortization::Strategies::First3MonthInterestOnly < Amortization::Strategies::Base
  INTEREST_ONLY_TERMS = 3
  def build
    schedule_items = interest_only_schedule(INTEREST_ONLY_TERMS)
    
    @disbursement_date = (@disbursement_date + INTEREST_ONLY_TERMS.months).beginning_of_month
    @terms = @terms - INTEREST_ONLY_TERMS
    schedule_items + super()
  end

  def interest_only_schedule(interest_only_terms)
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

    schedule_items
  end

  def self.index
    2
  end
end