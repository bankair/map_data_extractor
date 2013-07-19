require 'timeout'

class MapDataExtractor::BordersExtractor
  def initialize(image)
    @image = image
  end


  def borders
    # Find where border lines start.
    start_points = {}
    @image.each_pixel do |pixel, x, y|
      if pixel.opacity == 0
        start_points[pixel] ||= [ x, y ]
      end
    end

    # Follow the line for point found.
    borders       = []
    border_points = {}
    start_points.each_with_index do |(pixel, start_point), index|
      name                 = (index + 1).to_s
      color_code           = MapDataExtractor.color_code(pixel)
      border_points[pixel] = [ start_point ]

      begin
        point = point_with_color_around(pixel, border_points[pixel][-1], border_points[pixel])
        border_points[pixel] << point if point
      end while point

      borders << { name: name, color: color_code, points: border_points[pixel] }
    end

    borders
  end


  private

  # Return the first point with the given color around given coordinates.
  def point_with_color_around(color, origin_point, points_to_ignore = [])
    x, y = origin_point

    [
      [ x - 1, y - 1 ],
      [ x,     y - 1 ],
      [ x + 1, y - 1 ],
      [ x - 1, y     ],
      [ x + 1, y     ],
      [ x - 1, y + 1 ],
      [ x,     y + 1 ],
      [ x + 1, y + 1 ]
    ].each do |point|
      return point if !points_to_ignore.include?(point) && @image.pixel_color(*point) == color
    end

    nil
  end
end
