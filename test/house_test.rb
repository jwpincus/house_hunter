require './test/test_helper'

class TestHouse < Minitest::Test

  def test_it_exists
    assert House.new
  end

  def test_it_has_attributes
    house = House.new("3995","https://www.redfin.com/WA/Seattle/7302-36th-Ave-SW-98126/home/470396","1.50","3","570000","1760","1179431")
    assert_equal '3995', house.id
    assert_equal "https://www.redfin.com/WA/Seattle/7302-36th-Ave-SW-98126/home/470396", house.source_url
    assert_equal 1.5, house.bathrooms
    assert_equal 3, house.bedrooms
    assert_equal 570000, house.price
    assert_equal 1760, house.squarefeet
    assert_equal '1179431', house.mls_id
  end

end
