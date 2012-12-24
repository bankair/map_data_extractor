# Map data extractors

These tools are used to extract data (nodes and paths) from special images called **map descriptors**.

I created these tools for my game project Seelies.


## How to use

In order to use these tools, you need to have two images : one for nodes and one for paths.

Nodes descriptors are transparent PNG containing blocks of 4*4 fully opaque black pixels.

Paths descriptors are transparent PNG containing paths composed of 1*1 pixels without blotch (see examples). Both starting and ending points of a path must be *under* (while it's another image) a different node. If many paths start from a same node, use different colors to draw them.


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
