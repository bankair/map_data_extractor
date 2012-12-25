class MapDataExtractor::PathsExtractor
  def initialize(image, nodes)
    @image = image
    @view  = image.view(0, 0, image.columns, image.rows)
    @nodes = nodes
  end


  def paths
    # Find path's starting points from each node.
    start_points = Hash.new { |k, v| k[v] = [] }
    @nodes.each do |node|
      node[:points].each do |point|
        x, y  = point
        pixel = @view[y][x]

        start_points[node] << point if pixel.opacity == 0
      end
    end

    # Follow the path for each starting point found.
    paths = []
    start_points.each do |node, start_points|
      start_points.each do |starting_point|
        x, y       = starting_point
        color      = @image.pixel_color(*starting_point)
        color_code = MapDataExtractor::color_code(@view[y][x])
        steps      = [ starting_point ]

        begin
          point = point_with_colour_around(color, steps[-1], steps[-2])
          steps << point if point
        end while point

        arrival_node = node_for_point(steps[-1], @nodes)
        paths << { from: node, to: arrival_node, points: steps, color: color_code }
      end
    end

    paths
  end


  private


  # Return the first point with the given color around given coordinates.
  def point_with_colour_around(color, origin_point, point_to_ignore = nil)
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
      return point if point != point_to_ignore && @image.pixel_color(*point) == color
    end

    nil
  end


  def node_for_point(searched_point, nodes)
    nodes.find do |node|
      node[:points].any? do |point|
        point[0] == searched_point[0] && point[1] == searched_point[1]
      end
    end
  end
end
