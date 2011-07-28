require 'bing'

class Bing::Location

  ##
  # Will find locations based off of +query+ and return an array of
  # Bing::Location objects.

  def self.find_by_query query
    clean_query = CGI.escape query

    path = '/REST/v1/Locations'
    uri  = Bing.config[:map_uri].merge(
             "#{path}?q=#{clean_query}&key=#{Bing.config[:api_key]}"
           )

    response = JSON.parse get(uri).body

    response['resourceSets'].first['resources'].map do |resource|
      new resource
    end.compact
  end

  attr_reader :address
  attr_reader :bounding_box
  attr_reader :canonical_description
  attr_reader :city
  attr_reader :confidence
  attr_reader :country
  attr_reader :entity_type
  attr_reader :full_name
  attr_reader :lat
  attr_reader :lon
  attr_reader :state
  attr_reader :zip

  def initialize resource
    unless resource.blank?
      @confidence  = resource['confidence']
      @entity_type = resource['entityType']
      @full_name   = resource['name']

      if resource['address'] then
        @address = resource['address']['addressLine']
        @city    = resource['address']['locality']
        @country = resource['address']['countryRegion']
        @state   = resource['address']['adminDistrict']
        @zip     = resource['address']['postalCode']
      end

      if resource['bbox'] then
        south, west, north, east = *resource['bbox']
        @bounding_box = {
          :north => north,
          :east  => east,
          :south => south,
          :west  => west,
        }
      end

      if resource['point'] && resource['point']['coordinates'] then
        @lat = resource['point']['coordinates'][0]
        @lon = resource['point']['coordinates'][1]
      end
    end
  end

end

