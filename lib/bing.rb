require 'rubygems'

module Bing
  VERSION = '1.0.0'

  DEFAULTS = {
    :api_key  => '',
    :api_url => 'api.bing.net',
    :map_url => 'dev.virtualearth.net',
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

