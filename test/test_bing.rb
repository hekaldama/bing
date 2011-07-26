require 'helper'

class TestBing < Test::Unit::TestCase
  def test_defines_version
    assert Bing::VERSION.to_f > 0.0
  end
end
