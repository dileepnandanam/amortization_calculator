require 'test_helper'

class Amortization::PaymentTest < ActiveSupport::TestCase
  test 'monthly_payment to return correct amount' do
    principal = 10000
    rate = 10
    number_of_months = 12
    monthly_payment = Amortization::Payment.monthly_payment(principal, number_of_months, rate)
    assert_equal monthly_payment, 879.3466983745584
  end

  test 'monthly_payment to return principal/number_of_months for zero interest' do
    principal = 10000
    rate = 0
    number_of_months = 12
    monthly_payment = Amortization::Payment.monthly_payment(principal, number_of_months, rate)
    assert_equal monthly_payment, 10000/12
  end

  test 'monthly_payment to correct value for number of months as 1' do
    principal = 10000
    rate = 10.0
    number_of_months = 1
    amount_compounded_for_one_month = principal * (1 + (rate/100/12) / 30)**30
    monthly_payment = Amortization::Payment.monthly_payment(principal, number_of_months, rate)
    assert_equal monthly_payment, amount_compounded_for_one_month
  end
end
