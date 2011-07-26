class Bing::Map

  DEFAULTS = {
    :host => 'dev.virtualearth.net',
    :key  => '',
    :path => '',
    :port => 80,
  }

  @@config = DEFAULTS.dup

  ##
  # Set the configuration for this instance of bing map.

  def self.config= config
    @@config = DEFAULTS.merge config
  end

  ##
  # Return the configuration for this instance of bing map.

  def self.config
    @@config
  end

  ##
  # Return array of Bing::Map::Location objects based off of +address+
  def self.locations address
    Bing::Map::Location.find address
  end

  ##
  # Sets the class' path

  def self.path= val
    @path = val
  end

  ##
  # Returns the class' path

  def self.path
    @path
  end

  ##
  # Returns the instance's path

  def path
    self.class.path
  end

end

