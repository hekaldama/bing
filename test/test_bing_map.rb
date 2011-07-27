require 'helper'

class TestBingMap < MiniTest::Unit::TestCase
  def test_setting_config
    Bing::Map::Location.expect :find_by_location

    Bing::Map.find_by_location 'foo'
  end
end
