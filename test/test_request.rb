require 'helper'

class TestRequest < MiniTest::Unit::TestCase

  def setup
    @uri = URI.parse 'http://example.com'
  end

  def test_get_failure
    stub_request(:any, "http://example.com").to_return(:status => 500)

    assert_raises BadGateway do
      get @uri
    end
  end

  def test_get_success
    stub_request(:any, "http://example.com").to_return(:status => 200)

    response = get @uri

    assert_equal '200', response.code
  end

end

