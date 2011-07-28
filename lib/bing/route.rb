require 'bing'

class Bing::Route

  def self.find_by_point start_lat, start_lon, end_lat, end_lon, opts={}
    points = ["wp.1=#{start_lat},#{start_lon}",
              "wp.2=#{end_lat},#{end_lon}"].join '&'

    opts[:du] ||= 'mi' # default to miles

    path = '/REST/v1/Routes'

    uri  = Bing.config[:map_uri].merge(
             "#{path}?#{points}&key=#{Bing.config[:api_key]}&#{opts.to_param}"
           )

    response = JSON.parse get(uri).body

    response['resourceSets'].first['resources'].map do |resource|
      new resource
    end.compact
  end

  # {:action=>"Depart", :duration=>28, :latitude=>47.6100009307265, :instruction=>"Depart Start on Local road(s) (North-West)", :distance=>0.155342798, :longitude=>-122.106966432184} 

  attr_reader :action
  attr_reader :distance
  attr_reader :duration
  attr_reader :instruction
  attr_reader :latitude
  attr_reader :longitude

  def initialize resource
    if !resource.blank? && resource['routeLegs'] then
    end
  end

end

