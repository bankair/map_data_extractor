require 'rmagick'
require 'yaml'

require_relative '../lib/nodes_extractor'
require_relative '../lib/paths_extractor'

descriptor_path = ARGV[0]
data_path       = ARGV[1]

nodes_image = Magick::Image.read("#{descriptor_path}_nodes.png")[0]
paths_image = Magick::Image.read("#{descriptor_path}_paths.png")[0]
nodes       = NodesExtractor.new(nodes_image).nodes
paths       = PathsExtractor.new(paths_image, nodes).paths

YAML.dump(nodes, File.open("#{data_path}_nodes.yml", 'w'))
YAML.dump(paths, File.open("#{data_path}_paths.yml", 'w'))
