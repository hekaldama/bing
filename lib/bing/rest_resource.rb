require 'bing'

class Bing::RestResource

  ##
  # Base Bing Rest route.

  BASE_PATH = '/REST/v1'

  attr_reader :bounding_box

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

  def self.path
    raise 'Subclasses resposibility to define #path'
  end

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

