require 'rubygems'
require 'logger'
require "minitest/autorun"
require "webmock"

require "bing"
require "bing/location"
require "bing/route"

include WebMock::API

def mock_map_request status, path, body, headers={}
  stub_request(:any, /.*virtualearth.*#{path}.*/).
    to_return(:status => status, :body => body, :headers => headers)
end
