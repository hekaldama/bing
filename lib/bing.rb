require 'rubygems'
require 'net/http/persistent'
require 'uri'
require 'json'

module Bing

  VERSION = '1.0.0'

  DEFAULTS = {
    :api_key    => 'AtsQ7PXwSqL266EUdxMYj3b4-H5A6ubkf8DwH-B4k3rVmmPycUrhmH-lZKHeWXm-',
    :api_uri    => URI.parse('http://api.bing.net'),
    :connection => :persistent,
    :logger     => 'stdout',
    :map_uri    => URI.parse('http://dev.virtualearth.net'),
  }

  class << self
    attr_reader :config
  end

  @config = DEFAULTS.dup

  ##
  # Set the configuration for this instance of bing.

  def self.config= config
    @config = DEFAULTS.merge config
  end

end

require 'bing/errors'
require 'bing/core_ext'
require 'bing/request'
require 'bing/formatting_helper'

include Bing::Request
include Bing::FormattingHelper
