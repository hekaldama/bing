class Bing::Map::Location < Bing::Map
  self.config[:path] = '/REST/v1/Locations'

  def self.find address
    url = URI.parse(self.config[:host]).merge "#{path}?q=#{CGI.escape address}&key=#{self.config[:key]}"

    response = JSON.parse get url

    response['resourceSets'].first['resources'].map do |resource|
      loc = new resource
    end.compact
  end

  attr_reader :address
  attr_reader :canonical_description
  attr_reader :city
  attr_reader :confidence
  attr_reader :lat
  attr_reader :lon
  attr_reader :state
  attr_reader :zip

  def initialize resource
    unless resource.blank?
      if resource['point'] && resource['point']['coordinates'] then
        @lat = resource['point']['coordinates'][0]
        @lon = resource['point']['coordinates'][1]
      end

      if resource['address'] then
        @address = resource['address']['addressLine']
        @city    = resource['address']['locality']
        @state   = resource['address']['adminDistrict']
        @zip     = resource['address']['postalCode']
        @country = resource['address']['countryRegion']
      end

      @confidence = resource['confidence']
    end
  end

end

