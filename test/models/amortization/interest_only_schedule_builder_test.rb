require 'test_helper'

class Amortization::InterestOnlyScheduleBuilderTest < ActiveSupport::TestCase
  test 'should give correct number of schedule items' do
    terms = 12
    principal = 10000
    anual_rate = 10.0
    disbursement_date = Date.today

    schedule_items = Amortization::InterestOnlyScheduleBuilder.new(
      terms, principal, anual_rate, disbursement_date
    ).build
    assert_equal schedule_items.count, 12
  end

  test 'should start with next date of disbursement date' do
    terms = 12
    principal = 10000
    anual_rate = 10.0
    disbursement_date = Date.today

    schedule_items = Amortization::InterestOnlyScheduleBuilder.new(
      terms, principal, anual_rate, disbursement_date
    ).build
    assert_equal schedule_items.first.date, disbursement_date.next_month.beginning_of_month
  end

  test 'start balence and previous end balence should be same' do
    terms = 12
    principal = 10000
    anual_rate = 10.0
    disbursement_date = Date.today

    schedule_items = Amortization::InterestOnlyScheduleBuilder.new(
      terms, principal, anual_rate, disbursement_date
    ).build
    (1..schedule_items.count - 1).each do |i|
      assert_equal schedule_items[i].start_balance, schedule_items[i - 1].end_balance
    end
  end

  test '4th month starting balence should be loan principal' do
    terms = 12
    principal = 10000
    anual_rate = 10.0
    disbursement_date = Date.today

    schedule_items = Amortization::InterestOnlyScheduleBuilder.new(
      terms, principal, anual_rate, disbursement_date
    ).build
    assert_equal schedule_items[3].start_balance, principal
  end
end