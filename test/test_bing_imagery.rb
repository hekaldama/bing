require 'helper'

# TODO need to add more tests.

class TestBingImagery < MiniTest::Test
  BI = Bing::Imagery

  def test_cls_path
    assert_match %r[Imagery/Map/Road], BI.path
    assert_match %r[Imagery/Map/Road], BI.path('Road')
    assert_match %r[Imagery/Map/AerialWithLabels], BI.path('AerialWithLabels')

    assert_match %r[Imagery/Map/Road/funky], BI.path(nil, 'funky')
    assert_match %r[Imagery/Map/Road/funky%20monkey], BI.path(nil, 'funky monkey')
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

    BI.find_by_query "doesn't matter"
  end

end

