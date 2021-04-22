require 'test_helper'

class Amortization::PaymentTest < ActiveSupport::TestCase
  test 'monthly_payment to return correct amount' do
    principal = 10000
    rate = 10
    number_of_months = 12
    monthly_payment = Amortization::Payment.monthly_payment(principal, number_of_months, rate)
    assert_equal monthly_payment, 879.158872300099
  end
end