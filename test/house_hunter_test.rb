require './test/test_helper'

class TestHouseHunter < Minitest::Test

  def test_it_exists
    assert HouseHunter.new
  end

  def test_load_all_houses
    load_test = HouseHunter.new
    load_test.load_csv('./seed_data/loftium_listings_sample.csv')
    assert_equal 1500, load_test.houses.length
    assert_equal '3995', load_test.houses.first.id
  end
end
