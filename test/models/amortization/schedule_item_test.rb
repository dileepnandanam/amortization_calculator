require 'test_helper'

class Amortization::ScheduleItemTest < ActiveSupport::TestCase
  test 'should prepare correct values' do
    start_balance = 10000
    payment = 800
    anual_rate = 10.0
    date = Date.today

    schedule_item = Amortization::ScheduleItem.new(
      start_balance, payment, anual_rate, date
    )
    schedule_item.build

    assert_equal schedule_item.start_balance, 10000
    assert_equal schedule_item.end_balance, 9283.669853314379
    assert_equal schedule_item.payment, 800
    assert_equal schedule_item.date, date
    assert_equal schedule_item.principal, 716.330146685621
    assert_equal schedule_item.interest, 83.669853314379
  end

  test 'should ignore negligible end end balance' do
    start_balance = 872.05
    payment = 879.35
    anual_rate = 10.0
    date = Date.today

    schedule_item = Amortization::ScheduleItem.new(
      start_balance, payment, anual_rate, date
    )
    schedule_item.build

    assert_equal schedule_item.end_balance, 0
  end
end
