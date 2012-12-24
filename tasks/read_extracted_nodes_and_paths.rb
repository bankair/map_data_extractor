require 'pp'
require 'yaml'

data_path = ARGV[0]

require_relative '../lib/nodes_extractor'
require_relative '../lib/paths_extractor'

nodes = YAML.load_file("#{data_path}_nodes.yml")
paths = YAML.load_file("#{data_path}_paths.yml")

pp nodes
puts
pp paths
