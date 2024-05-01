We thank our four reviewers for their careful reviews and suggestions for improving the paper. We respond to
comments made by two or more reviewers first, and then address any remaining questions. At the end we
summarise our proposed improvements to the paper.

# Issues raised by multiple reviewers

## Q1. Delta with respect to POPL 2022 paper (Reviewers A and D)

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

## Q2. Correctness statements relating graphs/graph operators to big-step evaluation (Reviewers A and B)

Reviewer A asks whether we could formulate a correctness theorem for the DDG (analogous to Theorem 3.11 in the
prior work), relating it to the big-step evaluation in 4 and/or graph operators in 3. Reviewer B asks a
slightly different but related question: is there a soundness theorem that indicates that the graph is
properly constructed?

In the prior work, a theorem stated that if a computation evaluated to a trace, then the forwards and
backwards analysis over that trace yield a Galois connection between "selections" on the original program and
selections on the output. [expand]

## Q3. Eliminators vs. case expressions in core calculus (Reviewers C and D)

Reviewers C and D both ask why the core language has the "eliminator" pattern-matching construct, rather than
the standard non-nested `case` construct one would have in a lambda-calculus with sums. We agree this would be
more standard and would remove the need to talk about eliminators/tries, etc; however [expand].

## Q4. Data provenance vs. understanding poorly designed charts (Reviewers B and D)

Reviewer B points out that we don't clearly distinguish different use cases, such as checking that the right
data were used in a particular chart, vs. helping understand a potentially poorly designed chart. Reviewer D
makes a similar point: the main example is hard to follow, with various suboptimal visualisation choices, and
it's unclear whether our goal is to help make sense of poorly-designed visualisations, or whether
well-designed visualisations can also benefit? [expand]

## Questions raised by Reviewer A

- _Typing rules._ These were included in the POPL 2022 work for clarity but omitted here for reasons of space;
  we will include them in an Appendix.

- _Correctness statement on DDG._ See response (Q2) above.

- _Overhead compared to core language without DDG annotations._ This is a good question that would be relatively
  straightforward to answer, without taking up too much space; we will do so.

Additional points made by Reviewer A:

- _Lack of connection between Sections 3 and 4._ This is indeed a weakness of the present paper. We will do two
  things to address this:

  1. As per (Q2) above, we will set out how the operators defined in 3 (which compute a Galois connection
  between sinks and sources of G) also determine a Galois connection between selections on the original
  program and output. Our implementation performs this conversion (mediating from the program to the graph and
  back again), but we did not explain how this works in the submitted draft.

  2. We will explain how general-purpose graph operators (such as the "projections with conjugates" mentioned
  in (Q1) above can be applied to language-level constructs such as environments. Again, our implementation
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

## Questions raised by Reviewer B

- _Difficult terminology and concepts in first 2 sections._ Introducing the key ideas was a challenge,
  especially given the multiple dimensions of "duality" (conjugates, De Morgan duals, adjoints), and we agree
  that this should be improved. We will give an intuition and definition for the De Morgan dual, but will also
  try to do a better job of the transition from the "adjoint" setting ($\triangledown$ and $\blacktriangleup$)
  to the conjugate setting ($\triangledown$ and $\triangleup$, and explain the role of the De Morgan dual in
  connecting these two.
- _Data provenance vs. understanding poorly designed charts_. We clarify this in (Q4) above.
- _Data dependencies vs. control dependencies_. We stated this a bit misleadingly -- we do track branching on
  content of data, using the pattern-matching rules which identify the (partial) value that was consumed in
  order to select a branch. [expand]
- _Presentation of demBy via inference rules_. Yes, demBy can also be expressed in more traditional
algorithmic form, but presenting it in this helps in the proof of Proposition 3.18, as you suggest [expand].
The rule extends gave me a hard time, i.e., what does $H = {\alpha: Y}$ mean? H is "added" to a graph $G' =
(V', E')$ but also to a set of vertices $X$, so it does not type-check in my mind.
- _Concrete runs of algorithms_. Fig. 6 was intended to illustrate a concrete run of `suff`, showing how edges
  are copied from the original graph to the slice; we will make this clearer (for example by indicating which
  `suff` is being applied in each subfigure).

## Questions raised by Reviewer C

- _Eliminators vs. expressions._ We recognise the concern and address this in (Q3) above.
- _Loops in surface language_. The surface and core language are both pure functional languages, so there are
  no loops as such (only recursion). Other work has looked at Galois slicing in an imperative language with
  arrays and loops [cite]; in future we also plan to look at these features, because of their importance in
  data science applications, supporting them either natively (via the FFI) or via an algebraic effects
  embedding.
- _Fixpoint operator_. Functions are always named in our calculus, via the binding environments ρ that we call
  "recursive definitions" (Fig. X), so there is no need for an explicit fixpoint operator.
- _Confusing example_. It is a difficult example, to some extent by design; we address this in (Q4) above, but
  also take your point that a simpler example, with a less challenging visualisation, would be useful (see
  next point).
- _Anonymised interactive demo_. We will look into anonymous hosting options and make sure to provide an
  onlione demo in time for the corrected version of the paper (May 20). We will include some simpler examples
  than the one provided in the paper; if it makes sense to include one or two of these into the paper as well
  we will, to help with your point above.

## Questions raised by Reviewer D

- _Delta compared to POPL 2022._ The reviewer asks whether the choice of moving to a DDG and query operators
  over the graph and its opposite, plus the new notion of "related inputs", together constitute the main delta
  from the prior work. This is correct; these are indeed the main contributions, and each in their own way is
  straightforward. We address this in (Q1) above.

- _Highlight that underlying idea is quite straightforward_. We also feel that the paper would benefit from
  making this clearer. The benefit comes from the factorisation of the previous approach, which eases the
  implementation burden, improves performance and introduces a cleaner design [expand].

- _Continuations and eliminators_. We understand the concern and address this in (Q3) above.

Additional points made by Reviewer D:

- _Computing graph along with data before serving to client_. This is indeed how our implementation works
  (broadly speaking, although it all happens on the client). We evaluate the program once to a graph when the
  page loads, and then any subsequent queries reuse the same graph.

## List of proposed changes

We will implement all the minor corrections provided by the reviewers. In addition we propose the following
more significant improvements to the paper.

- Sharpen the benefits of the new approach vis-a-vis the previous one (Q1):
  - Explain how the previous approach doesn't directly support related inputs, and how a simple family of
    operators (projections with conjugates) can be used both to recover the prior work precisely in the new
    setting, and support more focused queries. Use this to formally explain brushing-and-linking.
- Bridge the gap between sections 3 and 4:
  - Show how Galois connections/conjugate operator pairs on graph give rise to analogous operators on
    environment, program and value selections
- Evaluate overhead compared to core language without building DDG or trace
- Provide an anonymised web-based artefact to allow reviewers to play with the implementation
- Additional discussion in closing sections (Reviewer A)
  - Benefits of developing approach for general-purpose language vs. visualisation DSL like Vega
  - Relationship to developments in data provenance for aggregates or recursive queries, and potential for
    using conjugate operators identified here in other settings with negation (e.g. databases)
