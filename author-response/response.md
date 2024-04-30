We thank our four reviewers for their careful and engaged reviews. We respond to comments made by two or more
reviewers first, and then address any remaining questions. At the end we summarise our proposed improvements
to the paper.

# Issues raised by multiple reviewers

## R1. Delta with respect to POPL 2022 paper (Reviewers A and D)

As Reviewers A and D point out, the delta from the prior POPL 2022 work on which the paper builds is not
huge. However, we believe the approach proposed provides sufficient benefits to warrant separate study, and we
have identified some areas in which this could be emphasised.

Although related inputs is indeed formally dual to related outputs, this was not readily obtained in the
earlier work, because the Galois connections were of types f: O1 -> I and g: O2 -> I (where 'O' indicates
output and 'I' input). In this setup, f can be composed with (dual g) and (dual f) with g, but each of those
composites is a "linked outputs" analysis of type O1 -> O2 or O2 -> O1. For linked inputs, we need to
formulate f and g as a single Galois connection of type I -> O1 × O2 which can then be composed with its own
dual in two different ways, one of which corresponds to a "linked inputs" analysis of type I -> I. This
construction relies on projections having conjugates (so that for example the projection π₁: O1 × O2 -> O1 has
a conjugate [id , const ⊥] : O1 -> O1 × O2 which supplies the bottom demand for the right view).

This is an example of how additional generic "graph combinators" for manipulating and reasoning about data
dependencies can be useful, and it also can be used to clarify the relationship of "brushing and linking" to
the formal development in Section 3 (additional points raised by Reviewer A).

## R2. Correctness statements relating DDG to big-step evaluation and/or graph operators (Reviewers A and B)

Reviewer A asks whether we could formulate a correctness theorem for the DDG (analogous to Theorem 3.11 in the
prior work), relating it to the big-step evaluation in 4 and/or graph operators in 3. Reviewer B asks a
similar question: is there a soundness theorem that indicates that the graph is properly constructed?

In the prior work, a theorem stated that if a computation evaluated to a trace, then the forwards and
backwards analysis over that trace yield a Galois connection between "selections" on the original program and
selections on the output.

[expand]

## 3. Eliminators in core calculus (Reviewers C and D)

Reviewers C and D both ask why the core language has the "eliminator" pattern-matching construct, rather than
the standard non-nested `case`` construct one would have in a lambda-calculus with sums. We agree this would
be more standard and would remove the need to talk about eliminators/tries, etc; however [expand].

## Questions raised by Reviewer A

- _Typing rules._ These were included in the POPL 2022 work for clarity but omitted here for reasons of space; we will
  include them in an Appendix.

- _Correctness statement on DDG._ See response (R2) above.

- _Overhead compared to core language without DDG annotations._ This is a good question that would be relatively
  straightforward to answer, without taking up too much space; we will do so.

Additional points made by Reviewer A:

- _Lack of connection between Sections 3 and 4._ This is indeed a weakness of the present paper. We will do two
  things to address this:

  1. As per (R2) above, we will set out how the operators defined in 3 (which compute a Galois connection
  between sinks and sources of G) also determine a Galois connection between selections on the original
  program and output. Our implementation performs this conversion (mediating from the program to the graph and
  back again), but we did not explain how this works in the submitted draft.

  2. We will explain how general-purpose graph operators (such as the "projections with conjugates" mentioned
  in (R1) above can be applied to language-level constructs such as environments. Again, our implementation
  relies on this to allow more focused queries, for example finding outputs that are related via a specific
  environment variable; showing how this works will further deepen the connection between the world of graphs
  and conjugate operators and the executions they can be used to reason about.

- _"Strictness condition" in Lemma 3.22 and provenance tracking as an effect._ There is almost certainly a
  connection between Galois slicing and the notion of strictness that arises in denotational semantics; in
  particular, for foreign functions or primitive operations to "play well" (i.e. compose with) our system,
  they must be _stable_ (in the sense of Berry 1978) in order for the appropriate minima to exist. For
  example, multiplication may be non-strict is either one argument or the other, but not both, i.e. may
  satisfy at most one of (⊥ * n = ⊥) and (n * ⊥ = ⊥) for non-zero n. We also think it possible to model Galois
  slicing as an effect, using a "lifting" monad similar to the non-termination monad that arises in
  denotational semantics. Exploring these in more detail will be the topic of another paper, but we will
  include some discussion in related/future work.

- _Slowdown observed in G-DemBy-Suff (Section 5.2.4)_. This does raise some questions, but at the moment is
  not a pressing concern as our implementation does not use the "dual of `suff`" implementation of `demBy`.

## Questions raised by Reviewer D

- _Delta compared to POPL 2022._ The reviewer asks whether the choice of moving to a DDG and query operators
  over the graph and its opposite, plus the new notion of "related inputs", correctly characterize the main
  delta from the prior work. This is correct; these are indeed the main contributions, and each in their own
  way is straightforward. We address this in (R1) above.

- _Highlight that underlying idea is quite straightforward_.

- _Continuations and eliminators_. We understand the concern and address this in (R3) above.

## List of proposed changes


### Minor discussion points

- Discuss (e.g. in 6.3) benefits of developing this approach for general-purpose language vs. a visualisation
  DSL like Vega (Reviewer A)
- Related work: consider relationship to developments in provenance for aggregates or recursive queries; and potential for using the conjugate operators identified here in other settings with negation (e.g. databases) (Reviewer A).

***

# Review B

**Specific points highlighted for authors' response**
- Terminology of paper is hard to grasp in the first sections. E.g. intro talks about a Galois connection between minimal $\triangledown$ and sufficient $\blacktriangleup$, but then in Figure 2 you use "demanded by" $\triangleup$. Similarly, "De Morgan dual" is mentioned in intro but never defined or given an intuition
- Duality connections using conjugate / Galois connection / De Morgan Dual seem to be used; perhaps just mention as an alternative formulation and talk more about case studies or PL part
- Are you interested in providing evidence that the right pieces of information were considered for the output, or in helping understand potentially poorly designed charts? Please clarify
- You say dependency graph only considers data dependencies and not control dependencies -- what about branching on content of data?
- Can demBy can be implemented as a (forward) breadth-first graph algorithm? Does presenting it in this rule-based way help in the proof of Proposition 3.18? The rule extends gave me a hard time, i.e., what does $H = {\alpha: Y}$ mean? H is "added" to a graph $G' = (V',
E')$ but also to a set of vertices $X$, so it does not type-check in my mind.
- I wish you provided concrete runs of your algorithms
- Line 450, aren't you missing $\exits x \in X' \cdot (x,y) \in R$?

# Review C

**Specific points to respond to**
- Why the absence of loops?
- Why no fixpoint operator?
- **No anonymous supplement provided to play with those visualizations in real time**
- If program is known statically, you should be able to compute graph along with data before serving it to the client
