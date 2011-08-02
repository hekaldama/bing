module Bing::Request

  HTTP = Net::HTTP::Persistent.new
  USER_AGENT = "Bing Client Version: #{Bing::VERSION}"
  HTTP.headers['user-agent'] = USER_AGENT

  def get uri
    response = HTTP.request uri

    raise BadGateway.bad_response(response.code, uri) unless
      response.code =~ /20\d/

    response
  end

end

