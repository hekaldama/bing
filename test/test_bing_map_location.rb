require 'helper'

class TestBingMap < Test::Unit::TestCase
  def test_setting_path
    assert_equal '/REST/v1/Locations', Bing::Map::Location.path
    Bing::Map::Location.path = ''
    assert_equal '', Bing::Map::Location.path
  end
end
