require 'helper'

class TestBingImagery < MiniTest::Unit::TestCase
  BI = Bing::Imagery

  def test_cls_path
    assert_match %r[Imagery/Map/Road], BI.path
    assert_match %r[Imagery/Map/Road], BI.path('Road')
    assert_match %r[Imagery/Map/AerialWithLabels], BI.path('AerialWithLabels')
  end

  def test_cls_find
    location_body = {
      "resourceSets" =>[{
        "resources"  =>[{
          "point" => {"coordinates" => [34.148294, -118.255262]}
        }]
      }]}.to_json

    mock_map_request 200, Bing::Location.path, location_body
    mock_map_request 200, BI.path, ''

    BI.find :query => "doesn't matter"
  end

end

