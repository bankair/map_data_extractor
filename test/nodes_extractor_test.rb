require 'test/unit'
require 'map_data_extractor'


class NodesExtractorTest < Test::Unit::TestCase
  def test_find_nodes_from_image
    image  = Magick::Image.read('test/00_nodes.png')[0]
    finder = MapDataExtractor::NodesExtractor.new(image)

    assert_equal [
      { name: '1', points: [ [1,1], [2,1], [1,2], [2,2] ] },
      { name: '2', points: [ [7,3], [8,3], [7,4], [8,4] ] },
      { name: '3', points: [ [1,7], [2,7], [1,8], [2,8] ] }
    ], finder.nodes
  end
end
