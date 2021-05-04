class Amortization::Strategies::Base
  def initialize(terms, principal, anual_rate, disbursement_date)
    @terms = terms
    @principal = principal
    @rate = anual_rate.to_f
    @disbursement_date = disbursement_date
  end

  def build
    schedule_items = []
    fixed_monthly_payment = Amortization::Payment.monthly_payment(@principal, @terms, @rate)
    current_date = @disbursement_date
    (0..@terms - 1).each do |term|
      current_date = current_date.next_month.beginning_of_month
      schedule_items << Amortization::ScheduleItem.new(
        @principal, fixed_monthly_payment, @rate, current_date
      ).build
      @principal = schedule_items.last.end_balance
    end
    schedule_items
  end

  def self.strategies
    [self] + ObjectSpace.each_object(::Class).to_a.select { |klass| klass < self }
  end


end
