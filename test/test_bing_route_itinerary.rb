require 'helper'

class TestBingRouteItinerary < MiniTest::Unit::TestCase

  def test_initialize_with_action
    resource = { 'instruction' => {'maneuverType' => 'turn'} }

    bl = Bing::Route::Itinerary.new resource

    assert_equal 'turn', bl.action
  end

  def test_initialize_with_distance
    resource = { 'travelDistance' => '3.0' }

    bl = Bing::Route::Itinerary.new resource

    assert_equal '3.0', bl.distance
  end

  def test_initialize_with_duration
    resource = { 'travelDuration' => '100' }

    bl = Bing::Route::Itinerary.new resource

    assert_equal '100', bl.duration
  end

  def test_initialize_with_instruction
    resource = { 'instruction' => {'text' => 'go right'} }

    bl = Bing::Route::Itinerary.new resource

    assert_equal 'go right', bl.instruction
  end

  def test_initialize_with_coordinates
    resource = { 'maneuverPoint' => {'coordinates' => [1,2]} }

    bl = Bing::Route::Itinerary.new resource

    assert_equal [1,2], bl.coordinates
  end

  def test_initialize_with_travel_mode
    resource = { 'travelMode' => 'driving' }

    bl = Bing::Route::Itinerary.new resource

    assert_equal 'driving', bl.travel_mode
  end

  def test_initialize_without_resource_raises
    assert_raises ItineraryResourceMissing do
      Bing::Route::Itinerary.new nil
    end
  end

end

