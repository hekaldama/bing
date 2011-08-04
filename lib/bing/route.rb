require 'bing/rest_resource'

class Bing::Route < Bing::RestResource

  ##
  # === Description
  # Will return a route based off of +opts+ passed in. See
  # http://msdn.microsoft.com/en-us/library/ff701717.aspx for reference on
  # allowable +opts+ and what is required. All values in +opts+ are passed
  # through save +waypoints+. The keys should follow ruby's convention of snake
  # case which will translate into MSN's lower camelcase E.g. :date_time will be
  # converted to dateTime for MSN.
  #
  # === opts
  # +waypoints+:: Array of points. E.g. :waypoints =>
  #               ['start', 'next', 'end'] will turn into "waypoint.0=
  #               start&waypoint.1=next&waypoint.2=end". Reference above MSN
  #               docs for allowable waypoints. All points must be strings.
  #
  # === Example
  # Bing::Route.find :avoid                      => 'minimizeHighways,tolls',
  #                  :distance_before_first_turn => 500,
  #                  :distance_unit              => 'mi'
  #                  :heading                    => 90,
  #                  :optimize                   => 'time',
  #                  :waypoints                  => ['start', 'next', 'end']
  #
  # === Return
  # http://msdn.microsoft.com/en-us/library/ff701718.aspx

  def self.find opts
    waypoints = format_waypoints opts.delete :waypoints
    params    = [opts.to_param, waypoints].join '&'

    map_find params
  end

  ##
  # Path to route resource.

  def self.path
    super '/Routes'
  end

  attr_reader :distance_unit
  attr_reader :duration_unit
  attr_reader :ending_coordinates
  attr_reader :itinerary
  attr_reader :starting_coordinates
  attr_reader :total_distance
  attr_reader :total_duration
  attr_reader :type

  def initialize resource
    raise Bing::RouteResourceMissing if resource.blank?

    @distance_unit  = resource['distanceUnit']
    @duration_unit  = resource['durationUnit']
    @total_distance = resource['travelDistance']
    @total_duration = resource['travelDuration']

    if resource['bbox'] then
      @bounding_box = bbox resource['bbox']
    end

    # TODO does not support multiple route legs. My testing thus far just
    # breaks Bing if I try to obtain multiple anyways.
    if resource['routeLegs'] && leg = resource['routeLegs'].first then
      @type = leg['type']

      if leg['actualEnd'] && leg['actualEnd']['coordinates'] then
        @ending_coordinates = leg['actualEnd']['coordinates']
      end

      if leg['actualStart'] && leg['actualStart']['coordinates'] then
        @starting_coordinates = leg['actualStart']['coordinates']
      end

      unless leg['itineraryItems'].blank? then
        @itinerary = leg['itineraryItems'].collect do |itinerary|
                       Bing::Route::Itinerary.new itinerary
                     end.compact
      end
    end
  end

  private

  def self.format_waypoints waypoints
    return unless waypoints
    ways = []

    waypoints.each_with_index do |way, i|
      ways << "waypoint.#{i}=#{CGI.escape way}"
    end

    ways.join '&'
  end

end

require 'bing/route/itinerary'
