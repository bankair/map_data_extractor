class MapDataExtractor::NodesExtractor
  def initialize(image)
    @image = image
  end


  def nodes
    nodes         = []
    locked_pixels = {}
    index         = 1

    @image.each_pixel do |pixel, x, y|
      current = [ x, y ]

      if pixel.opacity == 0 && !locked_pixels.include?(current)
        color_code   = MapDataExtractor::color_code(pixel)
        right        = [ x + 1, y     ]
        bottom       = [ x,     y + 1 ]
        right_bottom = [ x + 1, y + 1 ]

        locked_pixels[right]        = true
        locked_pixels[bottom]       = true
        locked_pixels[right_bottom] = true

        nodes << { name: index.to_s, points: [ current, right, bottom, right_bottom ], color: color_code }
        index += 1
      end
    end

    nodes
  end
end
