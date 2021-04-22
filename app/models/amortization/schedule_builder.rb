class Amortization::ScheduleBuilder
  def initialize(terms, principal, anual_rate)
    @terms = terms
    @principal = principal
    @rate = anual_rate.to_f
  end

  def build
    schedule_items = []
    fixed_monthly_payment = Amortization::Payment.monthly_payment(@principal, @terms, @rate)
    
    (0..@terms - 1).each do |term|
      schedule_items << Amortization::ScheduleItem.new(
        @principal, fixed_monthly_payment, @rate, term, @terms
      ).build
      @principal = schedule_items.last.end_balance
    end
    schedule_items
  end
end