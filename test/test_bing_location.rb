require 'helper'

class TestBingLocation < MiniTest::Test

  BL = Bing::Location

  def test_cls_find_successful
    body = {
      'resourceSets' => [
        'resources' => [
          {'name' => 'full name'}
        ]
      ]
    }.to_json

    mock_map_request 200, BL.path, body

    locs = BL.find :query => '123'

    assert_equal 'full name', locs.first.full_name
  end

  def test_cls_find_failure
    mock_map_request 400, BL.path, '{}'

    assert_raises Bing::BadGateway do
      BL.find :query => '123'
    end
  end

  def test_cls_path
    assert_match %r[Locations], BL.path
  end

  def test_initialize_with_coordinates
    resource = {
      'point' => {
        'coordinates' => [123, 456]
      }
    }

    bl = BL.new resource

    assert_equal [123, 456], bl.coordinates
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

    bl = BL.new resource

    assert_equal 'address', bl.address
    assert_equal 'city', bl.city
    assert_equal 'country', bl.country
    assert_equal 'state', bl.state
    assert_equal 'zip', bl.zip
  end

  def test_initialize_with_confidence
    resource = { 'confidence' => 'High' }

    bl = BL.new resource

    assert_equal 'High', bl.confidence
  end

  def test_initialize_with_bbox
    resource = { 'bbox' => %w[south west north east] }

    bl = BL.new resource

    assert_equal 'north', bl.bounding_box[:north]
    assert_equal 'east',  bl.bounding_box[:east]
    assert_equal 'south', bl.bounding_box[:south]
    assert_equal 'west',  bl.bounding_box[:west]
  end

  def test_initialize_with_entity_type
    resource = { 'entityType' => 'Postal' }

    bl = BL.new resource

    assert_equal 'Postal', bl.entity_type
  end

  def test_initialize_with_full_name
    resource = { 'name' => '123 street, ca' }

    bl = BL.new resource

    assert_equal '123 street, ca', bl.full_name
  end

  def test_initialize_without_resource_raises
    assert_raises Bing::LocationResourceMissing do
      BL.new nil
    end
  end

end

