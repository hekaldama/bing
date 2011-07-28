require 'helper'

class TestBing < MiniTest::Unit::TestCase

  def test_cls_find
  end

  def test_initialize_with_coordinates
    resource = {
      'point' => {
        'coordinates' => [123, 456]
      }
    }

    bl = Bing::Location.new resource

    assert_equal 123, bl.lat
    assert_equal 456, bl.lon
  end

  def test_initialize_with_address
    resource = {
      'address' => {
        'addressLine'   => 'address',
        'locality'      => 'city',
        'countryRegion' => 'country',
        'adminDistrict' => 'state',
        'postalCode'    => 'zip',
      }
    }

    bl = Bing::Location.new resource

    assert_equal 'address', bl.address
    assert_equal 'city', bl.city
    assert_equal 'country', bl.country
    assert_equal 'state', bl.state
    assert_equal 'zip', bl.zip
  end

  def test_initialize_with_confidence
    resource = { 'confidence' => 'High' }

    bl = Bing::Location.new resource

    assert_equal 'High', bl.confidence
  end

end

