class MapDataExtractor::NeighborhoodsExtractor
  def initialize(nodes, borders, radius)
    @nodes         = nodes
    @borders       = borders
    @radius        = radius
    @neighborhoods = []
    @index         = 0
  end


  def neighborhoods
    @nodes.each do |node|
      points_to_check = points_to_check(node[:points].first)

      @borders.each do |border|
        if (border[:points] & points_to_check).any?
          @index = @index.next
          @neighborhoods << { name: @index.to_s, node: node, border: border }
        end
      end
    end

    @neighborhoods
  end


  private

  def points_to_check((x, y))
    points_to_check = []

    ((y - @radius)..(y + @radius)).each do |y|
      ((x - @radius)..(x + @radius)).each do |x|
        points_to_check << [ x, y ]
      end
    end

    points_to_check
  end
end
