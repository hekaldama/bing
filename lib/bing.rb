require 'rubygems'
require 'net/http/persistent'
require 'uri'
require 'json'

module Bing

  VERSION = '0.1.1'

  DEFAULTS = {
    :api_key => 'AtsQ7PXwSqL266EUdxMYj3b4-H5A6ubkf8DwH-B4k3rVmmPycUrhmH-lZKHeWXm-',
    :api_uri => URI.parse('http://api.bing.net'),
    :map_uri => URI.parse('http://dev.virtualearth.net'),
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

require 'bing/core_ext'
require 'bing/errors'
require 'bing/formatting_helper'
require 'bing/request'

include Bing::FormattingHelper
