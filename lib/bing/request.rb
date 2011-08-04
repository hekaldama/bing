##
# Responsible for making requests to Bing. Uses persistent HTTP connections.

class Bing::Request

  HTTP = Net::HTTP::Persistent.new
  USER_AGENT = "Bing Client Version: #{Bing::VERSION}"
  HTTP.headers['user-agent'] = USER_AGENT

  ##
  # Perform a get request and ensure that the response.code == 20\d,
  # otherwise raise a BadGateway.
  def self.get uri
    response = HTTP.request uri

    raise Bing::BadGateway.bad_response(response.code, uri) unless
      response.code =~ /20\d/

    response
  end

end

