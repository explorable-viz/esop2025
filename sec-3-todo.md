# Roly section 3 pass

## Corrections

- [ ] Universally quantified $G'$ doesn't work in theorem
- [ ] Def. DDG: this isn't a definition but rather an informal intuition. Take out of Definition environment. Also it might be worth mentioning that our DDGs point from inputs to outputs (which I think is uncommon, but not unheard of).
- [ ] Do we want a definition of a graph (or perhaps directed graph)?
- [ ] In each graph, we mark out a subset of the nodes X. This isn't really correct; we don't specify the "inputs" or "outputs" of a graph (e.g. it's not part of the definition). I'm not sure if there's anything to say at this point.
- [ ] Taking the opposite of a graph has the effect of swapping: this observation belong with the definition of sinks/sources and opposite graph.

## Notation & terminology

- [ ] "Notation" environment overkill
- [ ] Disjoint union: give explicit definition for finite maps
- [ ] Complement: with respect to what set? Complement only seems to be used when we explain how a powerset is a Boolean algebra, where the ambient set is clear, so just use set difference at that point and avoid the ambiguous ^{c} notation. Also maybe avoid the duplicate language
- [ ] Graph, opposite graph: this defines sources/sinks too (but doesn't actually define a graph). Adjust the paragraph title, and move into the section graphs (it seems out of place here).
- [ ] Opposite graph: -1 denotes relational converse, not the inverse of an edge.

## Exposition

- [ ] Better summary of what this section achieves -- we're not just building intuition, we're giving definitions. Expand to include some of the other content. Drop claim about connecting to state=of-the-art -- we already said this section would not focus any more on explaining the connection to "Galois slicing" (although it will of course explain the relationship to Galois connections, which is different).

## Minor

- [ ] (In various places) "We shall introduce" -> "We introduce" (avoid inflection where possible)
- [ ] Standardise macro names (e.g. `demand` vs `demands`, `suffices` vs. `sufficient`)
- [ ] It's a bit easier on the eyes to say "write X" instead "we write X"
- [ ] (In various places) it's -> its
- [ ] "in edges of node α in graph G" -> just say "in edges of α in G" (take advantage of the metavariable conventions). Better still, simplify to "in edges and out edges of α in G", so we don't have to say the whole phrase twice.
- [ ] The statement "when we refer to Boolean algebras, we usually mean the powerset lattice" isn't quite what we mean -- when we refer to Boolean algebras, we mean Boolean algebras, and similarly for powerset lattices, so we must mean something else here.
- [ ] Kill "As mentioned earlier in the paper, we make use of DDGs" (it doesn't seem like a helpful sentence unless we unpack what we want to use them for, which is probably premature).

### Language to standardise on

- [ ] relational converse vs. inverse relation (sections 1 & 2 use former)
- [ ] set minus vs. relative complement
- [ ] node vs. vertex (maybe ok to use both, though)
