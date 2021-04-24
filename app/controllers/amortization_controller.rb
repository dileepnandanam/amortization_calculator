class AmortizationController < ApplicationController
  def home
    render 'home'
  end

  def calculate
    amount = params[:amount]
    request_date = params[:request_date]
    anual_rate = params[:anual_rate]
    terms = params[:terms]

    messages = []
    if [amount, request_date, anual_rate, terms].any?(&:blank?)
      messages << 'All fields must be present'
    end

    amount = amount.to_f
    anual_rate = anual_rate.to_f
    terms = terms.to_i
    request_date = Date.strptime(request_date, "%m/%d/%Y")
    
    if [amount, anual_rate, terms].any?{|val| val < 0}
      messages << 'All values must be positive'
    end

    @disbursement_date = request_date.next_month.beginning_of_month
    if messages.length == 0
      @payment = Amortization::Payment.monthly_payment(amount, terms, anual_rate)
      @schedule_items = Amortization::ScheduleBuilder.new(terms, amount, anual_rate, @disbursement_date).build
      render 'calculate', layout: false
    else
      render json: {messages: messages}, status: 422 and return
    end
  end
end