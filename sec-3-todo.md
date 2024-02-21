# Roly section 3 pass

## Corrections

- [ ] Def. of DDG isn't a definition but rather an informal intuition, so doesn't belong in a Definition environment. Also mention that our DDGs point from inputs to outputs (which I think is uncommon, but not unheard of).
- [ ] Do we want a definition of a graph (or perhaps directed graph)?
- [ ] Taking the opposite of a graph has the effect of swapping: this observation belongs with definition of sinks/sources and opposite graph.
- [ ] Prop. 3.10: Universally quantified $G'$ doesn't belong here. The condition $\subset V$ is redundant. G doesn't need to be unpacked as (V, E). A "subset of inputs" can just be a "set of inputs". X', Y' can just be X, Y.
- [ ] Prop. 3.11: it can't be the case that both this and 3.10 hold (the same algorithm over the same graph can't compute two opposite relations).
- [ ] Prop. 3.16: refers to "forwards". "Sufficiency" should be ▲. Then same points as 3.10 above.
- [ ] (p.9) "monotonic" should be "inflationary"
= [ ] Missing definition environments that define reaches and suffices (by reference to the figure). These are needed to explain the form of the judgements. (On p.11 just referring to "reaches" doesn't make it clear what the signature is or arguments are.)
- [ ] G_0 is longer used in reaches.
- [ ] Lemma 3.15 talks about "necessity" (see below about terminology). This needs to be stated point-free; the De Morgan dual can only be applied to a function between Boolean algebras, not the result of applying such a function to an element. What is the point of inputs X \subseteq V?
- [ ] 3.4 Relationship to Galois slicing: goal of this section isn't really to to relate to previous work, but to motivate idea of sufficiency and explain the two implementations (De Morgan dual formulation and "direct" implementation). Give an explicit algorithmic definition of ▲ in terms of the De Morgan dual and reaches (demanded by), so that it's clear exactly what is being benchmarked in section 5. The potential inefficiency of the De Morgan dual version should be explained in terms of the size of the graph that gets traversed after complementing and then computing △, not in terms of set complementation (which we know nothing about and probably has no asymptotic relevance).

## Notation & terminology

- [ ] "Notation" environment overkill
- [ ] Disjoint union: give explicit definition for finite maps
- [ ] Complement: with respect to what set? Complement only seems to be used when we explain how a powerset is a Boolean algebra, where the ambient set is clear, so just use set difference at that point and avoid the ambiguous ^{c} notation. Also maybe avoid the duplicate language
- [ ] Graph, opposite graph: this defines sources/sinks too (but doesn't actually define a graph). Adjust the paragraph title, and move into the section graphs (it seems out of place here).
- [ ] Opposite graph: -1 denotes relational converse, not the inverse of an edge.
- [ ] Image/preimage of a relation: it's confusing here to introduce "necessary for" as yet another intuition (we already have reachability, dependency, and demanded by as the same/closely related notions).
- [ ] Graphs as finite maps: u rather than u_i. Also α, β range over vertices, not u, v. Do we need G_M here or are we saying we can freely treat G as a map directly? U \subseteq V condition is redundant. Clarify that G finite. Is "adjacency map/adjacency set" the standard notion here?
- [ ] p. 10 Reachability relation R_G: define earlier (before first use of term "reachability").

## Exposition

- [ ] Better summary of what this section achieves -- we're not just building intuition, we're giving definitions. Expand to include some of the other content. Drop claim about connecting to state=of-the-art -- we already said this section would not focus any more on explaining the connection to "Galois slicing" (although it will of course explain the relationship to Galois connections, which is different).
- [ ] (As opposed to a function) the dependency relation: delete these two sentences as the idea of a dependency relation as a function seems like a straw man.
- [ ] In each graph, we mark out a subset of the nodes X. This isn't really accurate as we don't separately mark out the "inputs" or "outputs" of a graph independently of the sources/sinks. What we can perhaps say here is that we can think of the reachability relation R when restricted to S(G) and T(G) as constituting a "I/O dependency" relation specifying how specific "inputs" (sources) are demanded by specific "output" (sinks). We can then go onto say "[because] we wish to consider the relationship between sets of inputs and sets of outputs.."
- [ ] "A related question [...] is sufficiency." Out of place here; move later to discussion of duality of △ and ▲.
- [ ] Lemma 3.4: "This makes sense as a condition for _demands_ and _demanded by_." What are we referring to by _demands_ and _demanded by_? Do we mean the I/O relation D for a graph? Do we mean the image/preimage for a graph? From statement of the lemma, it sounds like the latter, but then we should use the notation for those operators to be absolutely clear. The terminology is already difficult here so we need to say focused around the key terms and notation and work to reinforce those.
- [ ] Missing a definition of Galois connection.
- [ ] "We note that these two functions do not always form a Galois connection": confusing because it's not clear why one might suppose them to form a GC in the first place. At a minimum we should probably make the side-observation that if D is a _function_, then the image and preimage also form a Galois connection, but in the general case of a relation, they don't.
- [ ] Fig. 5: can probably omit names x_1, x_2 and just use points, since following the exposition expressed using just the names doesn't convey what's going on. Re-explain using the sets/colours instead. "Free" outputs is confusing because "free" can have a technical meaning, and in any event we don't explain here what we actually mean. Use colours that match the colours used elsewhere, e.g. shame shade of turquoise for primary selection, grey for secondary selection, etc. Perhaps grey out the node itself for nodes in the primary selection that aren't preserved by the round-trip. Rewrite Fig. 5 caption.
- [ ] Move definition of △▽ and ▽△ earlier so they immediately follow this discussion. By the time we get to Fig. 5, it should be clear we're talking about related inputs/outputs (captions should reflect that).
- [ ] "We observe that [...] then ▽ will preserve ⊥": not clear what "restricting" means or what X and Y are. Maybe simply "if there are no unused inputs..." . Relation subscript on ▽△ is missing. Maybe combine Lemma 3.5 and 3.6 into one? The operator mentioned before Lemma 3.5 isn't the one mentioned in the lemma.
- [ ] "If both of the lemmas are true": lemmas are always true, so we need a different condition here. "a(n antitone)" -> "an antitone".
- [ ] "data used by the original program" is unclear, rework. Perhaps mention that the graph semantics may require that every output is traceable to some input (satisfying one condition), and a user interface might choose to project away unused inputs (satisfying the other condition).
- [ ] Subsection title: Computing Demands and DemandedBy -- again not clear what is being referred to here. If we mean the image/preimage functions then use the notation for them.
- [ ] "The set of nodes that a value is demanded by can be represented by": express in terms of inputs/outputs. "can be represented by" -> "is simply". For the "demanded by" direction, make the connection to image in reachability relation. Delete "We use this intuition when defining [...]".
- [ ] Restriction R'_G: not sure that "restriction" is the right terminology as one typically domain-restricts or range-restricts with respect to a subset of X or Y. Would intersection do here? Maybe introduce a function IO which takes a graph to its "IO relation". Define ▽_G and △_G point-free. Do we need "demands" and "demanded by" on the right here? Shouldn't these names come earlier? Give types of operators in terms of powerset S(G) and T(G).
- [ ] When explaining related inputs/outputs over a graph, maybe streamline by omitting "selection" as an explicit step. (Instead: "To calculate related inputs for an input selection X \subseteq S(G)..".) No need to prime X', Y' as there is no ambient X, Y.
- [ ] Does 6a "compute reachability"? Is the notion of "reachable subgraph" relevant? The phrases "accumulating their neighbours" and "its own neighbours" are unclear. Is "enqueue" the right term if V is a set? . Is "reaches" an appropriate term, give that its adjoint is called "suffices" and in the exposition we refer to "demanded"? Why not "demands"? "only considering the sinks" -> "intersecting with the sinks"?
- [ ] It seems we've switched "reaches" from "demands" to "demanded by". If that's how we want to proceed, then we probably shouldn't explain it as the computations of "demands" as well. (Also the name should match what's being computed; see below.) What do "Demands/Demanded By/Sufficiency" refer to in subfigure captions? We could describe them as computing △ and ▲, but probably better just to gives names of the algorithms. Caption text "Rules which define the algorithms" seems unnecessarily indirect, ok to describe these as algorithms.
- [ ] "Now we have [...] The next step is to take this set [...]": spurious; delete. Similarly for following paragraph starting "When trying to compute related outputs".
- [ ] Design question: why compute G if we only care about T(G)?
- [ ] "In the main subroutine": describe as an "auxiliary definition". Rather than "In [...], we consider", simply "[...] takes". E is a set, not a list; omit commas surrounding E. Say "and then add" rather than "before adding". It's not just α that's added to G, but the entire star graph at α. The "inefficient in the adjacency map" comment could perhaps be restated as: our implementation makes it trivial to flip between G and G^{op} so we can freely make use of both in the algorithm. By the time I get to "Otherwise", it's not clear what condition is being referred to. The second occurrence of suffEdges-pendinng should be suffEdges-done. The sentence containing "sort of front of nodes" is hard to understand. "traversed at least one node" -> "reached at least one node".

## Minor

- [ ] (In various places) "We shall introduce" -> "We introduce" (avoid inflection where possible)
- [ ] Standardise macro names (e.g. `demand` vs `demands`, `suffices` vs. `sufficient`)
- [ ] It's a bit easier on the eyes to say "write X" instead "we write X"
- [ ] (In various places) it's -> its
- [ ] "in edges of node α in graph G" -> just say "in edges of α in G" (take advantage of the metavariable conventions). Better still, simplify to "in edges and out edges of α in G", so we don't have to say the whole phrase twice.
- [ ] The statement "when we refer to Boolean algebras, we usually mean the powerset lattice" isn't quite what we mean -- when we refer to Boolean algebras, we mean Boolean algebras, and similarly for powerset lattices, so we must mean something else here.
- [ ] Kill "As mentioned earlier in the paper, we make use of DDGs" (it doesn't seem like a helpful sentence unless we unpack what we want to use them for, which is probably premature).
- [ ] "We shall make use of the fact that" sets up an unrequired expectation. Maybe just "Clearly". Also the equivalence of △_D and ▽_{D^{-1}} would be clearer expressed point-free.
- [ ] Omit the first formulation of conjugates and just say parenthetically that Jonsson and Tarski use the contrapositive formulation but that we find this one more intuitive.
- [ ] Omit (·) after △ and ▽ in Lemma 3.4. The sets X', Y' aren't used in the definition. Omit proof block for now.
- [ ] "ie" -> "i.e."
- [ ] "We now provide some detail on the computation" -> "We now show how to compute" (be more direct).
- [ ] "Once a graph has been constructed" can be omitted.
- [ ] "cognacy in natural language": this idea has been introduced in Sections 1 and 2 so here can be assumed. Maybe explain related inputs as cognacy in G^{-1}, i.e. "related outputs and related inputs as cognacy in G and G^{-1} respectively".
- [ ] p.11 has "demandedBy" as yet another synonym.
- [ ] Avoid starting sentences with a identifier that starts with a lowercase (e.g. "reaches").
- [ ] algorithms -> algorithm's
- [ ] graphs -> graph's
- [ ] "snapshot of the algorithm" -> "example run of the algorithm"? Use a colour scheme corresponding to the ones used elsewhere (e.g. turqoise for selected, white for unselected). We can probably managed without giving the vertices names; the visual notation is more informative. When we say "dotted edges are those under consideration", does this mean edges that have been included into H? In step 3, x_5 should be orange not green because it is still in H; it doesn't become part of G' (and thus turn green) until step 4. Arrowheads clash a bit in steps 5, 6 and 7. In step 8, the arrow into x7 is still part of H so should remain dotted (to illustrate your point). In general we need to be careful about referring to H, G' etc as "abstract components of the configuration" vs. actual metavariables that occur in the rules.
