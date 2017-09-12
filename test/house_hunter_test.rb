require './test/test_helper'

class TestHouseHunter < Minitest::Test

  def test_it_exists
    assert HouseHunter.new
  end

  def test_load_all_houses
    load_test = HouseHunter.new
    assert_equal 1500, load_test.houses.length
    assert_equal '3995', load_test.houses.first.id
  end

  def test_max_principal
    max_price = HouseHunter.new.max_loan_principle
    assert_equal 628383, max_price
  end

  def test_max_price
    low_down_payment = HouseHunter.new(0.04, 30, 1, 3000, 2000)
    regular_down_payment = HouseHunter.new(0.04, 30, 40000, 3000, 2000)
    assert_equal 21, low_down_payment.max_house_price
    assert_equal 668383, regular_down_payment.max_house_price
  end

end
