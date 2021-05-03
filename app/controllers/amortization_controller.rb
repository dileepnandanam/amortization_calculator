class AmortizationController < ApplicationController
  def home
    render 'home'
  end

  def calculate
    amortization_params_builder = Amortization::Params.new(params)

    messages = amortization_params_builder.errors

    if messages.length == 0
      amount, anual_rate, terms, request_date = amortization_params_builder.get
      @disbursement_date = request_date.next_month.beginning_of_month
      @payment = Amortization::Payment.monthly_payment(amount, terms, anual_rate)
      @schedule_items = schedule_builder.new(terms, amount, anual_rate, @disbursement_date).build
      render 'calculate', layout: false
    else
      render json: {messages: messages}, status: 422 and return
    end
  end

  protected

  def schedule_builder
    if params[:interest_only_for_3_months]
      Amortization::InterestOnlyScheduleBuilder
    else
      Amortization::ScheduleBuilder
    end
  end
end