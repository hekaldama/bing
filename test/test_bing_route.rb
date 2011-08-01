require 'helper'

class Bing::Route
  class << self
    public :format_waypoints
  end
end

class TestBingRoute < MiniTest::Unit::TestCase

  def test_cls_find
    body = {
      'resourceSets' => [
        'resources' => [
          {'name' => 'full name'}
        ]
      ]
    }.to_json

    mock_map_request 200, '/REST/v1/Routes', body

    route = Bing::Route.find :waypoints => ['start', 'end']
  end

  def test_cls_format_waypoints
    waypoints = ['start', 'end']

    assert_equal 'waypoint.0=start&waypoint.1=end',
      Bing::Route.format_waypoints(waypoints)

    waypoints = ["4.9, -1.2", "1.2, 2.2"]

    assert_equal 'waypoint.0=4.9%2C+-1.2&waypoint.1=1.2%2C+2.2',
      Bing::Route.format_waypoints(waypoints)

    assert_equal nil, Bing::Route.format_waypoints(nil)
  end

  def test_initialize_with_bbox
    resource = { 'bbox' => %w[south west north east] }

    bl = Bing::Route.new resource

    assert_equal 'north', bl.bounding_box[:north]
    assert_equal 'east',  bl.bounding_box[:east]
    assert_equal 'south', bl.bounding_box[:south]
    assert_equal 'west',  bl.bounding_box[:west]
  end

  def test_initialize_with_distance_unit
    resource = { 'distanceUnit' => 'miles' }

    br = Bing::Route.new resource

    assert_equal 'miles', br.distance_unit
  end

  def test_initialize_with_duration_unit
    resource = { 'durationUnit' => 'sec' }

    br = Bing::Route.new resource

    assert_equal 'sec', br.duration_unit
  end

  def test_initialize_with_ending_coordinates
    resource = {
      'routeLegs' => [{
        'actualEnd' => {'coordinates' => [1,2]}
      }]
    }

    br = Bing::Route.new resource

    assert_equal [1,2], br.ending_coordinates
  end

  def test_initialize_with_itinerary
    resource = {
      'routeLegs' => [{
        'itineraryItems' => [
          {'travelDistance' => 1},
          {'travelDistance' => 2},
        ]
      }]
    }

    br = Bing::Route.new resource

    assert_equal 1, br.itinerary.first.distance
    assert_equal 2, br.itinerary.last.distance
  end

  def test_initialize_with_starting_coordinates
    resource = {
      'routeLegs' => [{
        'actualStart' => {'coordinates' => [1,2]}
      }]
    }

    br = Bing::Route.new resource

    assert_equal [1,2], br.starting_coordinates
  end

  def test_initialize_with_total_distance
    resource = { 'travelDistance' => 117.406223 }

    br = Bing::Route.new resource

    assert_equal 117.406223, br.total_distance
  end

  def test_initialize_with_total_duration
    resource = { 'travelDuration' => 11723 }

    br = Bing::Route.new resource

    assert_equal 11723, br.total_duration
  end

  def test_initialize_with_type
    resource = {
      'routeLegs' => [{
        'type' => 'type'
      }]
    }

    br = Bing::Route.new resource

    assert_equal 'type', br.type
  end

  def test_initialize_without_resource_raises
    assert_raises RouteResourceMissing do
      Bing::Route.new nil
    end
  end

end

