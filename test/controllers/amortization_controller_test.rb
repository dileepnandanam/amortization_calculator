class AmortizationControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get '/'
    assert_response :success
  end

  test 'calculate should give success response for valid amortization params' do
    post '/calculate', params: {amount: "10000", request_date: "04/29/2021", anual_rate: "10", terms: "12", schedule_type: 'amortization.strategies.base'}
    assert_response :success
  end

  test 'calculate should give 422 response for invalid amortization params' do
    post '/calculate', params: {amount: "-10000", request_date: "04/29/2021", anual_rate: "10", terms: "12", schedule_type: 'amortization.strategies.base'}
    assert_response :unprocessable_entity
  end

  test 'calculate should give 422 response for incomplete amortization params' do
    post '/calculate', params: {request_date: "04/29/2021", anual_rate: "10", terms: "12", schedule_type: 'amortization.strategies.base'}
    assert_response :unprocessable_entity
  end

  test 'calculate should set correct disbursement date' do
    request_date = Date.today
    post '/calculate', params: {amount: "10000", request_date: request_date.strftime('%m/%d/%Y'), anual_rate: "10", terms: "12", schedule_type: 'amortization.strategies.base'}
    assert_equal assigns[:disbursement_date], request_date.next_month.beginning_of_month
  end
end