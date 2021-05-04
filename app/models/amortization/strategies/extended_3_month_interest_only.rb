class Amortization::Strategies::Extended3MonthInterestOnly < Amortization::Strategies::First3MonthInterestOnly
  def build
    schedule_items = interest_only_schedule(INTEREST_ONLY_TERMS)
    @disbursement_date = (@disbursement_date + INTEREST_ONLY_TERMS.months).beginning_of_month
    schedule_items + Amortization::Strategies::Base.new(
      @terms,
      @principal,
      @rate,
      @disbursement_date
    ).build
  end

  def self.index
    3
  end
end