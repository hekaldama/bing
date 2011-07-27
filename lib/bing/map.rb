class Bing::Map

  ##
  # Return array of Bing::Map::Location objects based off of +location+

  def self.find_by_location location
    Bing::Map::Location.find_by_location location
  end

end

