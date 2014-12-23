require 'helper'

class TestBing < MiniTest::Test

  def test_defines_version
    assert Bing::VERSION.to_f > 0.0
  end

  def test_setting_config
    Bing.config = {}
    assert_equal Bing.config, Bing::DEFAULTS

    Bing.config[:api_key] = 'frank'
    assert_equal 'frank', Bing.config[:api_key]
    refute_equal Bing.config, Bing::DEFAULTS
  end

end

