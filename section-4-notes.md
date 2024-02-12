# Section 4 to dos

- [ ] Paragraph 1. Need a clearer picture of what this section sets out to achieve. Section 3 could be characterised as defining the abstract setting of dependence graphs and conjugate operators over such graphs. This section shows how we implement that graphical abstraction for the programming language used to implement the figures in Section 2. Then go on to unpack how we do that.
- [ ] Merge closing sentence of para. 1 with opening sentence of para. 2; and the operational semantics doesn't really allow "the user to automatically compute demands/demanded by". As well as mentioning the big-step semantics, although mention the auxiliary definitions for dealing with pattern-matching and mutual recursion (as another a way of signposting the features of the language).
- [ ] In the summarising statements for the language, include the name of the language (\OurLang) and point to the scatter plot source code as an example of a program written in the language. Mention that it is a pure functional language.
- [ ] I would rename "regular terms" to "raw terms" (since "regular" can have technical meanings), and "graph terms" to just "terms". Introduce "terms" early -- at the same time as introducing raw terms, and explain the pattern of mutually inductive definition of e and raw e. I probably wouldn't describe terms as raw terms "indexed by" addresses but rather as "paired with".
- [ ] It may be confusing to use the term "vertex" to refer to α at this stage. Terms are trees are graph and thus have vertices already and it might be less ambiguous to refer to the αs as "addresses" and then say that these addresses will (later) form the vertices of the graphs that we build.
- [ ] Def. 4.1 (Vertices of a term). This should come later, when it becomes relevant. The sentence "which may themselves be vertices and/or contain [...] vertices" sounds odd, not sure how either of these things can "be" vertices (addresses).
- [ ] For continuations, give some intuition, e.g.: "A continuation κ describes how an execution proceeds after a value is pattern-matched and is either of the form e or σ.
- [ ] A record eliminator doesn't bind variables \seq{x} to the components of the record -- those bindings are specified by κ (via any variable eliminators contained therein). The \seq{x} in a record eliminator only specifies how to project out a corresponding sequence of values from the record.
- [ ] "Trie" needs some citations. I would use the Hinze paper Generalising Generalised Tries. The Peyton-Jones citation might be better off without saying "technical report". "serve as a plausible desugaring target" feels a bit too similar to the wording from POPL 2022, maybe restate and say that the piecewise function definitions in \OurLang shown in e.g. Fig 6 are desugared into eliminators but we omit the details.

## Discussion points

These aren't proposals for specific text -- just observations that may warrant some kind of dicussion or at least should contextualise how we write this section. Some are design questions that we still need to resolve.

### Terms of a given shape as representable functors

It might be useful to think of terms as carrying not specifically addresses but rather arbitrary data (so that a term of a given "shape" is a representable container with a zippy applicative instance). This might prove important for explaining how we convert between "selections" and sets of vertices (cf. the implementation). This may become even more important if we want to discuss e.g. the notion of secondary vs. primary selections which again depends on being able to store "data" other than addresses in terms. The shape of a term is what you get if you map (const unit) over it.

### Terms graphs and sharing

When introducing the graphical syntax, "term graph" is a potentially useful bit of terminology; we do effectively represent terms as graphs too (not to be confused with the DDGs). It's arguably important to understand them in this way because sharing arises during execution, in particular the "same" value may be mentioned multiple times by different occurrences of a variable and the same closure will often appear many times in a given environment. This is observable inasmuch as a graph slice that identifies a resource as "used" will identify that resource as used wherever it occurs.

There are design decisions about how to represent terms as graphs. For example, a "hash consing" representation would be legitimate (one that assigns the same address to all terms of the same shape). We just assume every subtree of the starting program has a unique address and moreover that every value constructed at runtime has a unique address. Other strategies in between these two are possible.

We should also clarify what it means for a term to be well-formed (w.r.t. to any addresses contained within it, i.e. what counts as a valid labellig of subtrees with addresses). The requirement is that if any two subtrees have the same address then they be identical (not just have the same shape). So (3_α, 4_α) is ill-formed but (3_α, 3_α) is ok and would be an example of hash-consing.

### Graph evaluation

We need to point out that there are also design choices here about what kind of dependency information to capture. For example, whether to only store value-value dependencies or also store value-expression dependencies. (We probably need some other examples; the usual "control" vs. "data" distinction probably doesn't apply in our pure setting, though.)

Regarding our own language, there may be a case for omitting expression dependencies. They aren't made use of anywhere in the examples. The implementation currently ignores them (projecting away the e in γ, e). It might make more sense to omit them and include the discussion in future work about intensional transparency.
