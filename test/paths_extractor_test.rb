require 'test/unit'
require 'rmagick'

require_relative '../lib/paths_extractor'


class PathsExtractorTest < Test::Unit::TestCase
  def test_find_paths_from_image
    image  = Magick::Image.read('map_descriptors/00_paths.png')[0]
    finder = PathsExtractor.new(image, nodes = [
      { name: '1', points: [ [1,1], [2,1], [1,2], [2,2] ] },
      { name: '2', points: [ [7,3], [8,3], [7,4], [8,4] ] },
      { name: '3', points: [ [1,7], [2,7], [1,8], [2,8] ] }
    ])

    assert_equal [
      { from: nodes[0], to: nodes[1], points: [ [2,2], [3,2], [4,2], [5,3], [6,3], [7,3] ] },
      { from: nodes[1], to: nodes[0], points: [ [7,3], [6,3], [5,3], [4,2], [3,2], [2,2] ] },
      { from: nodes[1], to: nodes[2], points: [ [8,4], [8,5], [7,6], [6,6], [5,6], [4,7], [3,8], [2,8] ] },
      { from: nodes[2], to: nodes[1], points: [ [2,8], [3,8], [4,7], [5,6], [6,6], [7,6], [8,5], [8,4] ] }
    ], finder.paths
  end
end
