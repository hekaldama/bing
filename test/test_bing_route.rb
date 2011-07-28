require 'helper'

class TestBingRoute < MiniTest::Unit::TestCase

  def test_cls_find_by_points
    body = {
      'resourceSets' => [
        'resources' => [
          {'name' => 'full name'}
        ]
      ]
    }.to_json

    mock_map_request 200, '/REST/v1/Routes', body

    route = Bing::Route.find_by_point 1.0,
                                      1.0,
                                      1.0,
                                      1.0
  end

  def test_initialize
  end

end

