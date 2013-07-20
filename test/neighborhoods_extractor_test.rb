require 'test/unit'
require 'map_data_extractor'


class NeighborhoodsExtractorTest < Test::Unit::TestCase
  def test_find_neighborhoods_from_nodes_and_borders
    finder = MapDataExtractor::NeighborhoodsExtractor.new(
      nodes = [
        { name: '1', color: '#000000', points: [ [1,1], [2,1], [1,2], [2,2] ] },
        { name: '2', color: '#000000', points: [ [1,5], [2,5], [1,6], [2,6] ] }
      ],
      borders = [
        { name: '1', color: '#46e600', points: [ [5,1], [6,1], [7,2], [7,3], [6,4], [5,4], [4,3], [4,2] ] },
        { name: '2', color: '#d40000', points: [ [5,6], [6,6], [7,7], [7,8], [6,9], [5,9], [4,8], [4,7] ] }
      ],
      radius = 3
    )

    assert_equal [
      { name: '1', node: nodes[0], border: borders[0] },
      { name: '2', node: nodes[1], border: borders[0] },
      { name: '3', node: nodes[1], border: borders[1] }
    ], finder.neighborhoods
  end
end
