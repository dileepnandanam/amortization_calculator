require 'test_helper'

class Amortization::ParamsTest < ActiveSupport::TestCase
  test 'should give error for missing params' do
    params_builder = Amortization::Params.new({
      amount: 10000,
      request_date: '1/1/2022',
      anual_rate: 10.0
    })

    assert_equal params_builder.errors, ["All fields must be present"]
  end

  test 'should give error for negative values' do
    params_builder = Amortization::Params.new({
      amount: -10000,
      request_date: '1/1/2022',
      anual_rate: 10.0,
      terms: 12
    })

    assert_equal params_builder.errors, ["All values must be positive"]
  end

  test 'should give multiple error messages' do
    params_builder = Amortization::Params.new({
      amount: -10000,
      request_date: '1/1/2022',
      anual_rate: 10.0,
    })

    assert_equal params_builder.errors, ["All fields must be present", "All values must be positive"]
  end
end