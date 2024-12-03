We thank our three reviewers for their detailed reviews and suggestions for improving the paper. We address the
specific comments (C) asked by each reviewer below, along with some proposed improvements to the paper.

Reviewer A

_Building and rebuilding of graph._ Your understanding is correct: the program is run once to generate the
graph, which has many nodes as there are partial values that arise during execution, and then queries happen
subsequently. There is no re-execution of the program to regenerate parts of the graph on demand, but this is
one direction in which we would like to extend the work (to produce incremental updates to the graph as the
program changes, similar in flavour to the ``self-adjusting computation'' of Acar).

_Store semantics._ It does seem plausible that a notation suggestive of a store with reference cells would
make the heap-like allocation pattern more familiar -- thanks for the suggestion. We are planning to
reimplement our current implementation with one that is explicitly imperative, so the intuition may actually
end up reflecting the implementation.

Reviewer B


