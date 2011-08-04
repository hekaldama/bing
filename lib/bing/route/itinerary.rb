class Bing::Route::Itinerary

  attr_reader :action
  attr_reader :coordinates
  attr_reader :distance
  attr_reader :duration
  attr_reader :instruction
  attr_reader :travel_mode

  def initialize resource
    raise Bing::ItineraryResourceMissing if resource.blank?

    @distance    = resource['travelDistance']
    @duration    = resource['travelDuration']
    @travel_mode = resource['travelMode']

    if instructions = resource['instruction'] then
      @action      = instructions['maneuverType']
      @instruction = instructions['text']
    end

    if resource['maneuverPoint'] && resource['maneuverPoint']['coordinates'] then
      @coordinates = resource['maneuverPoint']['coordinates']
    end
  end

end

