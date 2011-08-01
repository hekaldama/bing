require 'bing'

class Bing::Location

  ##
  # Path to location resource.

  PATH = '/REST/v1/Locations'

  ##
  # Will find locations based off of +query+ and return an array of
  # Bing::Location objects.

  def self.find opts
    uri = Bing.config[:map_uri].merge(
            "#{PATH}?key=#{Bing.config[:api_key]}&#{opts.to_param}"
          )

    response = JSON.parse get(uri).body

    response['resourceSets'].first['resources'].map do |resource|
      new resource
    end.compact
  end

  attr_reader :address
  attr_reader :bounding_box
  attr_reader :canonical_description
  attr_reader :coordinates
  attr_reader :city
  attr_reader :confidence
  attr_reader :country
  attr_reader :entity_type
  attr_reader :full_name
  attr_reader :state
  attr_reader :zip

  def initialize resource
    raise LocationResourceMissing if resource.blank?

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
      @bounding_box = bbox resource['bbox']
    end

    if resource['point'] && resource['point']['coordinates'] then
      @coordinates = resource['point']['coordinates']
    end
  end

end

