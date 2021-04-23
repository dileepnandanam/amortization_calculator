class AmortizationController < ApplicationController
  def home
    render 'home'
  end

  def calculate
    amount = params[:amount]
    disbursement_date = params[:disbursement_date]
    anual_rate = params[:anual_rate]
    terms = params[:terms]

    messages = []
    if [amount, disbursement_date, anual_rate, terms].any?(&:blank?)
      messages << 'All fields must be present'
    end

    amount = amount.to_f
    anual_rate = anual_rate.to_f
    terms = terms.to_i
    disbursement_date = Date.strptime(disbursement_date, "%m/%d/%Y")
    
    if [amount, disbursement_date, anual_rate, terms].any?{|val| val < 0}
      messages << 'All values must be positive'
    end

    if messages.length == 0
      @payment = Amortization::Payment.monthly_payment(amount, terms, anual_rate)
      @schedule_items = Amortization::ScheduleBuilder.new(terms, amount, anual_rate, disbursement_date).build
      render 'calculate', layout: false
    else
      render json: {messages: messages}, status: 422 and return
    end
  end
end