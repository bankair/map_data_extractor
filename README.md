# Map data extractor

These tools are used to extract data (nodes and paths) from special images called **map descriptors**.

I created these tools for my game project Seelies.


## Install

You can install the gem from the `.gem` file included in this repository.

```
gem install ./map_data_extractor-x.x.x.gem
```


## How to use

In order to use these tools, you need two images: one to describe nodes and one for paths.


### Nodes descriptor

Nodes descriptors are transparent PNG containing blocks of 4*4 fully opaque pixels.

This is image is virtually placed on top of paths image during process so some path pixels are said to be *under* a node.


### Paths descriptor

Paths descriptors are transparent PNG containing paths composed of contiguous pixels without blotch : a pixel can only have two pixels of the same color around it or only one if this pixel is *under* a node.

Both starting and ending points of a path must be *under* a different node.

If many paths start from a same node, use different colors to draw them (and keep it for the rest of the path): two pixels of a same color must not be found *under* a same node.


### Extract nodes from nodes descriptor image

``` ruby
require 'map_data_extractor'

image  = Magick::Image.read('test/00_nodes.png')[0]
finder = MapDataExtractor::NodesExtractor.new(image)

finder.nodes # => [
  { name: '1', points: [ [1,1], ... ] },
  { name: '2', points: [ [7,3], ... },
  ...
]
```


### Extract paths from paths descriptor image and list of nodes

``` ruby
require 'map_data_extractor'

nodes  = ... # As returned by MapDataExtractor::NodesExtractor.
image  = Magick::Image.read('test/00_paths.png')[0]
finder = MapDataExtractor::PathsExtractor.new(image, nodes)

finder.paths # => [
  { from: nodes[0], to: nodes[1], points: [ [2,2], ... ] },
  { from: nodes[1], to: nodes[0], points: [ [7,3], ... ] },
  ...
]
```
