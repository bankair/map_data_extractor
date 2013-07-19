module MapDataExtractor
  VERSION = '0.3.0'


  def self.color_code(pixel)
    # Rmagick uses 16-bit depth by default. 8-bit in some configuration.
    divider = Magick::QuantumDepth == 16 ? 257 : 1
    [
      '#',
      (pixel.red   / divider).to_s(16).rjust(2, '0'),
      (pixel.green / divider).to_s(16).rjust(2, '0'),
      (pixel.blue  / divider).to_s(16).rjust(2, '0')
    ].join
  end
end


require 'rmagick'
require 'map_data_extractor/nodes_extractor'
require 'map_data_extractor/paths_extractor'
require 'map_data_extractor/borders_extractor'
