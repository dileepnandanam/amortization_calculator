class Amortization::Params
  def initialize(params)
    @amount = params[:amount]
    @request_date = params[:request_date]
    @anual_rate = params[:anual_rate]
    @terms = params[:terms]
  end

  def errors
    messages = []
    if [@amount, @request_date, @anual_rate, @terms].any?(&:blank?)
      messages << 'All fields must be present'
    end
    if [@amount.to_f, @anual_rate.to_f, @terms.to_i].any?{|val| val < 0}
      messages << 'All values must be positive'
    end
    return messages
  end

  def get
    return [@amount.to_f, @anual_rate.to_f, @terms.to_i, Date.strptime(@request_date, "%m/%d/%Y")]
  end
end