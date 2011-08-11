require 'bing/rest_resource'

##
# Responsible for generating static Bing maps.
# Note: Bing static map generation is not very good. Even examples on their
# api docs (http://msdn.microsoft.com/en-us/library/ff701724.aspx) do not work
# as expected. One typical usage that does work is:
#
# Bing::Imagery.find_by_query '123 Street City STATE'
#
# The Bing documentation is okay in that some params do not work with other
# params like:
#
# Bing::Imagery.find_by_query '123 Street City STATE', :zoom_level => 20
#
# This has no affect on the static maps by query :(. The only way for it to
# work is to use a point search:
#
# Bing::Imagery.find_by_center_point [LAT, LON]
# Bing::Imagery.find_by_center_point [LAT, LON], :zoom_level => 10

class Bing::Imagery < Bing::RestResource
  # TODO need to clean up and have it work better, but I don't have time right
  # now. This is a pretty big mess :(

  def self.find_by_center_point coords, opts = {}
    imagery_set = opts.delete :imagery_set
    zoom_level  = opts.delete(:zoom_level) || 15

    coords = coords.join ','
    coords_and_zoom = [coords, zoom_level].join '/'
    opts[:push_pin] ||= coords

    # TODO need to figure out path below to potentially clean this up.
    uri = Bing.config[:map_uri].merge(
            "#{path imagery_set, coords_and_zoom}?key=#{Bing.config[:api_key]}&#{opts.to_lower_camelized_param}"
          )

    Bing::Request.get uri
  end

  ##
  # Find a static map based off of a query E.g. 123 Street City STATE.
  # +query+ should be a non-escaped text sequence. If it is already escaped
  # Bing will 40* you. Basically GIGO.

  def self.find_by_query query, opts = {}
    imagery_set = opts.delete :imagery_set

    # TODO need to figure out path below to potentially clean this up.
    uri = Bing.config[:map_uri].merge(
            "#{path imagery_set, query}?key=#{Bing.config[:api_key]}&#{opts.to_lower_camelized_param}"
          )

    Bing::Request.get uri
  end

  def self.find_by_waypoints waypoints, opts = {}
    imagery_set = opts.delete :imagery_set

    query = "Routes"
    waypoints = format_waypoints waypoints
    params    = [opts.to_lower_camelized_param, waypoints].join '&'

    # TODO need to figure out path below to potentially clean this up.
    uri = Bing.config[:map_uri].merge(
            "#{path imagery_set, query}?key=#{Bing.config[:api_key]}&#{params}"
          )

    Bing::Request.get uri
  end

  # TODO this is not my favorite at all. I need to figure out a way to handle
  # paths better

  def self.path imagery_set = nil, resource = nil
    imagery_set ||= 'Road'
    resource = resource ? "/#{URI.escape resource}" : nil
    super "/Imagery/Map/#{imagery_set}#{resource}"
  end

end

