require 'helper'

class TestBingLocation < MiniTest::Unit::TestCase

  def test_cls_find_by_query_successful
    body = {
      'resourceSets' => [
        'resources' => [
          {'name' => 'full name'}
        ]
      ]
    }.to_json

    mock_map_request 200, '/REST/v1/Locations', body

    locs = Bing::Location.find_by_query '123'

    assert_equal 'full name', locs.first.full_name
  end

  def test_cls_find_by_query_failure
    mock_map_request 400, '/REST/v1/Locations', '{}'

    assert_raises BadGateway do
      Bing::Location.find_by_query '123'
    end
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

  def test_initialize_with_bbox
    resource = { 'bbox' => %w[south west north east] }

    bl = Bing::Location.new resource

    assert_equal 'north', bl.bounding_box[:north]
    assert_equal 'east',  bl.bounding_box[:east]
    assert_equal 'south', bl.bounding_box[:south]
    assert_equal 'west',  bl.bounding_box[:west]
  end

  def test_initialize_with_entity_type
    resource = { 'entityType' => 'Postal' }

    bl = Bing::Location.new resource

    assert_equal 'Postal', bl.entity_type
  end

  def test_initialize_with_full_name
    resource = { 'name' => '123 street, ca' }

    bl = Bing::Location.new resource

    assert_equal '123 street, ca', bl.full_name
  end

end

