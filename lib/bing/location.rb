require 'bing'
require 'uri'

class Bing::Location
  def self.find address
    clean_address = CGI.escape address

    path = '/REST/v1/Locations'
    url  = Bing.config[:map_uri].merge(
             "#{path}?q=#{clean_address}&key=#{Bing.config[:api_key]}"
           ).to_s

    response = JSON.parse RestClient.get url

    response['resourceSets'].first['resources'].map do |resource|
      new resource
    end.compact
  end

  attr_reader :address
  attr_reader :canonical_description
  attr_reader :city
  attr_reader :confidence
  attr_reader :country
  attr_reader :lat
  attr_reader :lon
  attr_reader :state
  attr_reader :zip

  def initialize resource
    unless resource.nil? || resource.empty?
      @confidence = resource['confidence']

      if resource['address'] then
        @address = resource['address']['addressLine']
        @city    = resource['address']['locality']
        @country = resource['address']['countryRegion']
        @state   = resource['address']['adminDistrict']
        @zip     = resource['address']['postalCode']
      end

      if resource['point'] && resource['point']['coordinates'] then
        @lat = resource['point']['coordinates'][0]
        @lon = resource['point']['coordinates'][1]
      end
    end
  end

end

