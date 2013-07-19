require 'test/unit'
require 'map_data_extractor'


class BordersExtractorTest < Test::Unit::TestCase
  def test_find_Borders_from_image
    image  = Magick::Image.read('test/00_borders.png')[0]
    finder = MapDataExtractor::BordersExtractor.new(image)

    assert_equal [
      { name: '1', points: [ [2,1], [3,1], [4,2], [4,3], [3,4], [2,4], [1,3], [1,2] ], color: '#d40000' },
      { name: '2', points: [ [6,5], [7,5], [8,6], [8,7], [7,8], [6,8], [5,7], [5,6] ], color: '#46e600' },
    ], finder.borders
  end
end
