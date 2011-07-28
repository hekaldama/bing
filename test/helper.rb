require 'rubygems'
require 'logger'
require "minitest/autorun"
require "webmock"
require "bing"
require "bing/location"
require "bing/route"

include WebMock::API

FileUtils.mkdir 'log' unless File.directory? 'log'
TEST_LOG = Logger.new 'log/test.log'

Bing.config[:logger] = TEST_LOG

def mock_map_request status, path, body, headers={}
  stub_request(:any, /.*virtualearth.*#{path}.*/).
    to_return(:status => status, :body => body, :headers => headers)
end
