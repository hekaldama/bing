require 'helper'

class TestBingMap < Test::Unit::TestCase
  def test_setting_config
    Bing::Map.config[:host] = 'frank'
    assert_equal 'frank', Bing::Map.config[:host]
  end
end
