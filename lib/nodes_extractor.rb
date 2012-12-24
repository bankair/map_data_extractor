class NodesExtractor
  def initialize(image)
    @image = image
  end


  def nodes
    nodes         = []
    locked_pixels = {}
    index         = 1

    @image.each_pixel do |pixel, x, y|
      current = [ x, y ]

      if black?(pixel) && !locked_pixels.include?(current)
        right        = [ x + 1, y     ]
        bottom       = [ x,     y + 1 ]
        right_bottom = [ x + 1, y + 1 ]

        locked_pixels[right]        = true
        locked_pixels[bottom]       = true
        locked_pixels[right_bottom] = true

        nodes << { name: index.to_s, points: [ current, right, bottom, right_bottom ] }
        index += 1
      end
    end

    nodes
  end


  private

  def black?(pixel)
    pixel.red == 0 && pixel.green == 0 && pixel.blue == 0 && pixel.opacity == 0
  end
end
