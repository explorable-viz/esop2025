# Section 3 minor corrections

## Notation & terminology

- [ ] "Notation" environment is probably overkill
- [ ] Disjoint union: give explicit definition for finite maps
- [ ] Complement: with respect to what set? Complement only seems to be used when we explain how a powerset is a Boolean algebra, where the ambient set is clear, so just use set difference at that point and avoid the ambiguous ^{c} notation. Also maybe avoid the duplicate language
- [ ] Graph, opposite graph: this defines sources/sinks too (but doesn't actually define a graph). Adjust the paragraph title, and move into the section graphs (seems out of place here).
- [ ] Graphs as finite maps: u rather than u_i. Also α, β range over vertices, not u, v. Do we need G_M here or are we saying we can freely treat G as a map directly? U \subseteq V condition is redundant. Clarify that G finite. Is the "adjacency map/adjacency set" perspective actually what we are defining?

### Language to standardise on

- [ ] relational converse vs. inverse relation (sections 1 & 2 use former)
- [ ] set minus vs. relative complement
- [ ] node vs. vertex (both may be ok)
- [ ] R rather than D for abstract relations? ("reachability" rather than demanded by/dependency)
- [ ] [Sections 1 and 2] Prefer G^{-1} to G^{op}.
- [ ] Related input/related output -> Related inputs/related outputs
- [ ] "dependence graph" rather than "dependency graph"

## Other minor

- [ ] (In various places) "We shall introduce" -> "We introduce" (use direct language by default). Often "write X" is preferable to "we write X".
- [ ] Relatedly: "in edges of node α in graph G" -> just say "in edges of α in G" (take advantage of the metavariable conventions). Better still, simplify to "in edges and out edges of α in G", so we don't have to repeat the whole phrase twice.
- [ ] Standardise some macro names (e.g. `demand` vs `demands`, `suffices` vs. `sufficient`)
- [ ] Various extra and missing apostrophes: it's -> its; algorithms -> algorithm's; graphs -> graph's
- [ ] "ie" -> "i.e."
- [ ] The statement "when we refer to Boolean algebras, we usually mean the powerset lattice" isn't quite what we mean -- when we refer to Boolean algebras, we mean Boolean algebras, and similarly for powerset lattices, so we must mean something else here.
- [ ] Kill "As mentioned earlier in the paper, we make use of DDGs" (it doesn't seem like a helpful sentence unless we unpack what we want to use them for, which is probably premature).
- [ ] "We shall make use of the fact that" sets up an unrequited expectation. Maybe just "Clearly". Also the equivalence of △_D and ▽_{D^{-1}} would be clearer expressed point-free.
- [ ] Omit the first formulation of conjugates and just say parenthetically that Jonsson and Tarski use the contrapositive formulation but that we find this one more intuitive.
- [ ] Omit (·) after △ and ▽ in Lemma 3.4. The sets X', Y' aren't used in the definition. Omit proof block for now.
- [ ] "We now provide some detail on the computation" -> "We now show how to compute" (be more direct).
- [ ] "Once a graph has been constructed" can be omitted.
- [ ] "cognacy in natural language": this idea has been introduced in Sections 1 and 2 so here can be assumed. Maybe explain related inputs as cognacy in G^{-1}, i.e. "related outputs and related inputs as cognacy in G and G^{-1} respectively".
- [ ] Avoid starting sentences with a identifier that starts with a lowercase (e.g. "reaches").
