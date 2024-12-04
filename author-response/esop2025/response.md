We thank our three reviewers for their useful feedback and suggestions for improving the paper. We address
specific comments (C) of each reviewer below.

Reviewer A

_Building and rebuilding of graph._ Your understanding is correct: the program is run once to generate the
graph (which has many nodes as there are partial values that arise during execution), and then queries happen
subsequently. There is no re-execution of the program to regenerate parts of the graph on demand, but this is
one direction in which we would like to extend the work (to produce incremental updates to the graph in
response to program changes, similar in flavour to the ``self-adjusting computation'' of Acar).

_Store semantics._ Agreed, a notation suggestive of a store with reference cells might make the heap-like
allocation pattern more familiar -- thanks for the suggestion. We are planning to reimplement our current
interpreter with one that builds the graph in an explicitly imperative style, so this intuition may also end
up being closer to the implementation.

Reviewer B

_Performance_.
- notable delays -- explain these
- potential optimisations
  - start-up time: build graph imperatively
  - hide internal nodes
- scaling with program and data size

_Writing improvements._ These are good suggestions, which we will consider. On some specific points:

  1. _Galois connections_. We wanted to make the link in Section 4 to existing work on Galois connections,
  since they are really just alternate presentation of conjugate pairs; we felt a reader familiar with them
  would naturally wonder about the relationship. However perhaps this would be better dealt with in a
  footnote.

2. _Algorithmic definition of defBy_. The reason for preferring the inductive derivation over pseudocode is
   simply that it allows the proof to proceed by induction, which would not be easy with pseudocode.

Reviewer C

_Performance_.
- notable delays -- explain problem with Fig. 2 (shared with Reviewer B)

_Missing arrows in online demo_. Yes, these were only part of the figures in the paper. Visual connectors with
drop shadows might actually be useful as a UI feature, perhaps for guiding a novice user through various UI
features, but for now we will it clear that the arrows were added manually purely for the reader of the paper.

_Syntax, names and abbreviations could be improved_

_Possible limitations of this approach._
- does dependency graph approach ”fall over” at some point, or require any specific co-design with programming
language constructs?

_Running benchmarks 10 times each._
- justification?
- no warm-up (because graph created once, upfront)

We appreciate your point about using the more permissive performance band for the one-off (startup) overhead,
where the graph is always slower. This is slightly artificial given that there are two cases where the
trace-based approach stays within the middle (1000ms) band where the graph approach does not. Although what we
do say is strictly correct, and all the information is in the table, it might be better to concede this point
explicitly.
