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
    assert_equal 659802, max_price
  end

  def test_max_price
    low_down_payment = HouseHunter.new(0.04, 30, 1, 3000, 2000)
    regular_down_payment = HouseHunter.new(0.04, 30, 40000, 3000, 2000)
    assert_equal 20, low_down_payment.max_house_price
    assert_equal 699802, regular_down_payment.max_house_price
  end

  def test_min_principal
    min_price = HouseHunter.new.min_loan_principle
    assert_equal 502706, min_price
  end

  def test_min_price
    low_down_payment = HouseHunter.new(0.04, 30, 1, 3000, 2000)
    regular_down_payment = HouseHunter.new(0.04, 30, 40000, 3000, 2000)
    assert_equal 5, low_down_payment.min_house_price
    assert_equal 200000, regular_down_payment.min_house_price
  end

  def test_payment
    payment = HouseHunter.new.payment(628383)
    assert_equal 3000, payment
  end

  def test_price_filter
    prices = HouseHunter.new.price_filter
    assert_equal 762, prices.length
  end

  def test_sq_ft_filter
    sq_ft = HouseHunter.new.size_filter
    assert_equal 776, sq_ft.length
  end

  def test_combo_filter
    houses = HouseHunter.new
    houses = houses.price_filter(houses.size_filter)
    assert_equal 229, houses.length
  end

  def test_sorter
    houses = HouseHunter.new
    houses = houses.sort_filtered
    best_fit = houses.first
    assert_equal 3003, best_fit.payment
    assert_equal 2000, best_fit.squarefeet
    assert_equal 5.98, best_fit.down_percent
  end

end
