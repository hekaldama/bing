require 'rubygems'
require 'json'
require 'rest_client'

module Bing
  VERSION = '1.0.0'

  DEFAULTS = {
    :api_key    => '',
    :api_uri    => URI.parse('http://api.bing.net'),
    :connection => :persistent,
    :logger     => 'stdout',
    :map_uri    => URI.parse('http://dev.virtualearth.net'),
  }

  class << self
    attr_reader :config
  end

  @config = DEFAULTS.dup

  RestClient.log        = config[:logger]
  #RestClient.connection = config[:connection]

  ##
  # Set the configuration for this instance of bing.

  def self.config= config
    @config = DEFAULTS.merge config
  end

end

