# Map data extractors

These tools are used to extract data (nodes and paths) from special images called **map descriptors**.

I created these tools for my game project Seelies.


## How to use

In order to use these tools, you need two images: one to describe nodes and one for paths.


### Nodes descriptor

Nodes descriptors are transparent PNG containing blocks of 4*4 fully opaque black pixels.

This is image is virtually placed on top of paths image during process so some path pixels are said to be *under* a node.


### Paths descriptor

Paths descriptors are transparent PNG containing paths composed of contiguous pixels without blotch : a pixel can only have two pixels of the same color around it or only one if this pixel is *under* a node.

Both starting and ending points of a path must be *under* a different node.

If many paths start from a same node, use different colors to draw them (and keep it for the rest of the path): two pixels of a same color must not be found *under* a same node.


### Extract data to a file

```
ruby tasks/extract_nodes_and_paths.rb map_descriptors/foo tmp/foo
```

The descriptor path `map_descriptors/foo` assumes that the existence of files `map_descriptors/foo_nodes.png` and `map_descriptors/foo_paths.png`.

The data path `tmp/foo` assumes that the existence of directory `tmp`. The files `tmp/foo_nodes.yml` and `tmp/foo_paths.yml` are created.


### Reading data from a file

```
ruby tasks/read_extracted_nodes_and_paths.rb tmp/foo
```

The data path `tmp/foo` assumes the existence of files `tmp/foo_nodes.yml` and `tmp/foo_paths.yml`.
