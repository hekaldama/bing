##
# Responsible for consolidating response formatting logic shared 
# amongst resources.

module Bing::FormattingHelper

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

