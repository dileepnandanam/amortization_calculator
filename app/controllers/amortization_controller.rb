class AmortizationController < ApplicationController
  def home
    render 'home'
  end

  def calculate
    amount = params[:amount]
    disbursement_date = params[:disbursement_date]
    anual_rate = params[:anual_rate]
    terms = params[:terms]

    if [amount, disbursement_date, anual_rate, terms].any?(&:blank?)
      render json: {message: 'All fields must be present'}, status: 422 and return
    else
      amount = amount.to_f
      anual_rate = anual_rate.to_f
      terms = terms.to_i
      disbursement_date = Date.strptime(disbursement_date, "%m/%d/%Y")
      @payment = Amortization::Payment.monthly_payment(amount, terms, anual_rate)
      @schedule_items = Amortization::ScheduleBuilder.new(terms, amount, anual_rate, disbursement_date).build
    end
  end
end