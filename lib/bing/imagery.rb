require 'bing/rest_resource'
require 'bing/location'
require 'geokit'

class Bing::Imagery < Bing::RestResource

  def self.find opts
    location = Bing::Location.find(opts).first
    bounds   = Geokit::Bounds.from_point_and_radius [location.coordinates[0],
                                                   location.coordinates[1]], 1
    map_area = [bounds.sw.to_a, bounds.ne.to_a].flatten.join ','
    push_pin = location.coordinates.join ','

    opts.merge!(
      :map_area => map_area,
      :push_pin => push_pin
    )

    Bing::Request.get map_uri opts.to_lower_camelized_param
  end

  def self.path imagery_set = nil, query = nil
    imagery_set ||= 'Road'
    super "/Imagery/Map/#{imagery_set}"
  end

end

