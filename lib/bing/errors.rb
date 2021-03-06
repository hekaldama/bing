module Bing

  ##
  # DO NOT use these classes. They are too generic.

  class ServiceError < StandardError
    def status() 500 end
  end

  class ResourceMissing < StandardError
    def status() 502 end

    def message() 'Resource is empty or nil.' end
  end

  ##
  # Raised when we get an invalid response from an underlying server

  class BadGateway < ServiceError

    def self.parse_error text, uri = nil
      error = new "parse error#{uri ? " from #{uri}" : nil} - #{text.inspect}"
      error.text = text
      error.uri = uri
      error
    end

    def self.bad_response code, uri, server_message=nil
      server_message = " with message #{server_message}" if server_message
      error = new "#{uri} returned #{code}#{server_message}"
      error.code = code
      error.uri = uri
      error
    end

    ##
    # Status code from underlying server

    attr_accessor :code

    ##
    # Text we were unable to parse

    attr_accessor :text

    ##
    # URI for this request

    attr_accessor :uri

    def status() 502 end
  end

  class ItineraryResourceMissing < ResourceMissing; end
  class LocationResourceMissing < ResourceMissing; end
  class RouteResourceMissing < ResourceMissing; end

end
