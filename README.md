# Map data extractor

These tools are used to extract data (nodes, paths, borders) from special images called **map descriptors**.

I created these tools for the specific needs of my game project Seelies.


## Install

You can install the gem from the `.gem` file included in this repository.

```
gem install ./map_data_extractor-x.x.x.gem
```


## How to use


### Nodes extractor

The goal of the Nodes extractor is to retrieve for each node drawn on the map descriptor the coordinates of the node, its color and a unique name.

Note that the name is given according to the order of apparition of the node on the image (from left to right, top to bottom) so it may change when you change the image.

A nodes descriptor is a transparent PNG containing blocks of 4*4 fully opaque pixels.


#### Example usage

``` ruby
require 'map_data_extractor'

image  = Magick::Image.read('test/00_nodes.png')[0]
finder = MapDataExtractor::NodesExtractor.new(image)

finder.nodes # => [
  { name: '1', points: [ [1,1], ... ], color: '#000000' },
  { name: '2', points: [ [7,3], ... ], color: '#CCCCCC' },
  ...
]
```


### Paths extractor

The goal of the Paths extractor is to retrieve the coordinates of every paths drawn on the descriptor along with its color and the two nodes the path is linking.

This extractor uses the output of the Nodes extractor as its input. We use it to find overlaps between the nodes pixels and the paths pixels.

A paths descriptor is a transparent PNG containing paths composed of contiguous pixels without any blotch : a pixel can only have two pixels of the same color around it, or only one if this pixel overlaps with a node pixel.

Both starting and ending points of a path must overlap with a different node.

If many paths start from a same node, use different colors to draw them (and keep it for the rest of the path): two pixels with the same color must not overlap with a same node.


#### Example usage

``` ruby
require 'map_data_extractor'

nodes  = ... # As returned by MapDataExtractor::NodesExtractor.
image  = Magick::Image.read('test/00_paths.png')[0]
finder = MapDataExtractor::PathsExtractor.new(image, nodes)

finder.paths # => [
  { from: nodes[0], to: nodes[1], points: [ [2,2], ... ], color: '#FFFF00' },
  { from: nodes[1], to: nodes[0], points: [ [7,3], ... ], color: '#0000FF' },
  ...
]
```


### Borders extractor

The goal of the border extractor is to retrieve the coordinates of every area border drawn on the descriptor.

A borders descriptor is a transparent PNG containing closed paths composed of contiguous pixels without any blotch : a pixel can only have to pixels of the same color around it. Such an area must not be drawn inside another one. All pixels of a border must have the same color. A color must not be used in more than one border.


#### Example usage

``` ruby
require 'map_data_extractor'

image  = Magick::Image.read('test/00_borders.png')[0]
finder = MapDataExtractor::BordersExtractor.new(image)

finder.borders # => [
  { name: '1', color: '#d40000', points: [ [2,1], ... ] },
  { name: '2', color: '#46e600', points: [ [6,5], ... ] },
  ...
]
```


### Neighborhoods extractor

The goal of the neighborhoods extractor is too match nodes against borders to know which areas are close to each node.


#### Example usage

``` ruby
require 'map_data_extractor'

nodes   = ... # As returned by MapDataExtractor::NodesExtractor.
borders = ... # As returned by MapDataExtractor::BordersExtractor.
radius  = ... # A number of pixels to define the area around the node.
finder  = MapDataExtractor::NeighborhoodsExtractor.new(nodes, borders, radius)

finder.neighborhoods # => [
  { name: '1', node: nodes[0], border: borders[0] },
  { name: '2', node: nodes[1], border: borders[0] },
  ...
]
```
