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

  NEIGHBOR_OFFSETS = [
    [-1, -1],
    [ 0, -1],
    [ 1, -1],
    [-1,  0],
    [ 1,  0],
    [-1,  1],
    [ 0,  1],
    [ 1,  1]
  ]

  def each_neighbor(x, y)
    point = [0, 0]
    NEIGHBOR_OFFSETS.each do |offsets|
      point[0] = x + offsets[0]
      point[1] = y + offsets[1]
      yield(point)
    end
  end

  # Return the first point with the given color around given coordinates.
  def point_with_color_around(color, origin_point, points_to_ignore = [])
    each_neighbor(*origin_point) do |point|
      return point if !points_to_ignore.include?(point) && @image.pixel_color(*point) == color
    end
    nil
  end
end
