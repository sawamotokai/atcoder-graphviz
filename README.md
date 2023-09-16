# atcoder-graphviz

Wanna visualzie graph problems of AtCoder? Look no further!
This program converts inputs to typical graph problems into graph, with support for trees and directed graphs.

## Dependencies
To visualize graphs, `xdot` is required. Please install it before using this program.

## Supported input format
```
N M
A_1 B_1
A_2 B_2
...
A_M B_M
```
where `N` is the numebr of vertices, `M` is the numebr of edges and the following M lines vertices, between which an edge exists.

##  Supported options
- `--tree (-t)`: accepts inputs for a tree graph, where `M` is omitted from the format above, and `N-1` is the number of edges.
- `--directed (-d)`: edges will be directed.
- `--help (-h)`: shows a list of command line options.
