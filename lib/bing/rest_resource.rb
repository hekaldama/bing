require 'bing'

class Bing::RestResource

  ##
  # Base Bing Rest route.

  BASE_PATH = "/REST/#{Bing.config[:api_version]}"

  def self._find uri
    body = JSON.parse Bing::Request.get(uri).body

    body['resourceSets'].first['resources'].map do |resource|
      new resource
    end.compact
  end

  def self.map_uri params
    Bing.config[:map_uri].merge(
      "#{path}?key=#{Bing.config[:api_key]}&#{params}"
    )
  end

  def self.map_find params
    _find map_uri params
  end

  def self.path subclass_path = nil
    "#{BASE_PATH}#{subclass_path}"
  end

  ##
  # The map's bounding box.

  attr_reader :bounding_box

  ##
  # Decipher bounding box from bbox in Bing response.

  def bbox box
    south, west, north, east = *box
    {
      :north => north,
      :east  => east,
      :south => south,
      :west  => west,
    }
  end

end

