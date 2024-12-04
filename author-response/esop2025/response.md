We thank our three reviewers for their useful feedback and suggestions for improving the paper. We address
specific comments of each reviewer below.

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

_Syntax, names and abbreviations could be improved_. We will make a pass to see if there are any improvements
we can make here; for example we could easily rename `suff` to `sufficesFor` and `demBy` to `demandedBy`
without compromising the existing layout, so that seems like an easy win.

_Possible limitations of this approach._ We will include some more discussion of possible limitations,
including potential scalability challenges (which would require some optimisation/design to address, as
discussed in response to Reviewer B). Whether specific co-design with language constructs is needed a good
question; the Nested Relational Calculus (a quite different language, with multisets) is given a somewhat
similar treatment in Cheney et al [1], which provides some informal evidence that the same approach can
support a wide variety of language features.

_Warm-up._ Indeed, this is not required in our implementation; the program is evaluated once to produce a
graph, which incurs a one-off cost, and then queries run on the graph.

_Table 1 discussion._ We appreciate your point about our use of the more permissive performance band for the
one-off (startup) overhead, where the graph is always slower. This is slightly artificial given that there are
two cases where the trace-based approach stays within the middle (1000ms) band, but the graph approach does
not. It might be better to concede this point explicitly.

[1] James Cheney, Amal Ahmed and Umut A. Acar. Provenance As Dependency Analysis (2018).
https://arxiv.org/pdf/0708.2173
