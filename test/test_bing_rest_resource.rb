require 'helper'

class Bing::RestResource
  def initialize *args
  end
end

class TestBingRestResource < MiniTest::Unit::TestCase

  BRR = Bing::RestResource # so cold

  def test_base_path
    assert_equal '/REST/v1', BRR::BASE_PATH
  end

  def test_cls__find
    stub_request(:any, /.*/).to_return(:status => 200, :body => body)

    assert_resource BRR._find URI.parse 'http://example.com'
  end

  def test_map_uri
    assert_match %r[.*virtualearth.*REST.*key.*dunkey],
      BRR.map_uri('dunkey').to_s
  end

  def test_map_find
    mock_map_request 200, BRR.path, body

    assert_resource BRR.map_find 'dunkey'
  end

  def test_path
    assert_equal "#{BRR::BASE_PATH}", BRR.path
    assert_equal "#{BRR::BASE_PATH}/chunky", BRR.path('/chunky')
  end

  def test_bbox
    box  = %w[south west north east]
    bbox = BRR.new.bbox box

    assert_equal 'north', bbox[:north]
    assert_equal 'east',  bbox[:east]
    assert_equal 'south', bbox[:south]
    assert_equal 'west',  bbox[:west]
  end

  private

  def assert_resource found
    assert_kind_of Array, found
    assert_equal BRR.new.class, found.first.class
  end

  def body
    {
      'resourceSets' => [
        'resources' => [
          {'name' => 'full name'}
        ]
      ]
    }.to_json
  end

end

