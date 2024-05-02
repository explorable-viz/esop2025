We thank our four reviewers for their detailed reviews and suggestions for improving the paper. We respond to
questions asked by two or more reviewers first, and then address any remaining questions. At the end we
summarise our proposed improvements to the paper.

## 1. Response to Reviewer Questions

### Q1. Delta with respect to POPL 2022 paper (Reviewers A and D)

As Reviewers A and D point out, the delta from the prior POPL 2022 work on which the paper builds is moderate
in the core aims and ideas, but lies instead in a redesigned approach to the implementing the concepts. We
believe the approach proposed provides sufficient benefits to warrant separate study, and we have identified
some areas in which this could be emphasised.

Although related inputs is indeed formally dual to related outputs, this was not readily obtained in the POPL
2022 work, because the Galois connections were of types f: I → O1 and g: I → O2 (where 'I' indicates input and
'O' output). In this setup, f can be composed with (dual g) and (dual f) with g, but each of those composites
is a "linked outputs" analysis of type O1 → O2 or O2 → O1. For linked inputs, we need to formulate f and g as
a single Galois connection of type I → O1 × O2 which can then be either pre- or post-composed with its own
dual, one yielding a "linked inputs" analysis of type I → I; the other composite (of type O1 × O2 → O1 × O2)
can be used to recover the old approach precisely via projection operators which also have conjugates. (For
example the projection π₁: O1 × O2 → O1 has a conjugate [id , const ⊥] : O1 → O1 × O2 which supplies the
bottom demand for the right view.) This also provides the formal account of "brushing and linking" requested
by Reviewer A.

Explaining this will clarify the delta from the previous work and show how additional general-purpose
combinators for reasoning about data dependencies are easy to derive. Our implementation uses the "projections
with conjugates" on language-level constructs such as environments to provide more focused queries (e.g.
finding outputs that are related via a specific environment variable); we will use this to further connect
graphs/graph queries (section 3) to programs/executions (section 4), as also highlighted by Reviewer A.

### Q2. Correctness statements relating graphs/graph operators to semantics (Reviewers A and B)

Reviewer A asks whether we could formulate a correctness theorem for the DDG (analogous to Theorem 3.11 in the
prior work), relating it to the big-step evaluation in 4 and/or graph operators in 3. Reviewer B asks whether
there might be a soundness theorem that indicates that the graph is properly constructed.

In the prior work, a theorem stated that if a computation evaluated to a trace, then the forwards and
backwards analysis over that trace yield a Galois connection between "selections" on the original program and
selections on the output. In the present paper, there is a similar result for graphs but nothing that relates
this directly to the original program. Mediating between these two formulations (from program to graph and
back again) happens in our implementation but is not described in the paper; fixing this will serve to relate
the two formalisations and also tie sections 3 and 4 together better (raised by Reviewer A).

The question of whether there is a soundness theorem for the graph itself is slightly trickier. The intuition
offered by Reviewer B for such a theorem sounds reasonable (and is perhaps related to "dependency correctness"
from Cheney et al [2011]); we alluded to this in future work ("semantically justified dependency relation")
and are happy to expand on this to say more precisely what such a property might look like, but this is likely
to remain out-of-scope for the present paper.

### Q3. Eliminators vs. case expressions (Reviewers C and D)

Reviewers C and D ask why the core language has the deep pattern-matching construct ("eliminators"), rather
than a more standard one-level `case` construct. Moving to a lambda calculus with separate sums, products and
recursive types would make the connection to our implementation more indirect (and the formalisation less
useful to a potential implementor). For data science applications, we have found it useful to have records and
data types (both with pattern-matching) as core constructs and this decision lends itself to the eliminator
design. Moreover there is now some precedent (Peyton-Jones et al [2022]) for repurposing tries in this way, so
on balance our preference is for better motivating this decision rather than moving towards a more abstract
calculus.

### Q4. Verifying data provenance vs. understanding poorly designed charts (Reviewers B and D)

Reviewer B points out that our intended use cases are a bit unclear, e.g. checking that the appropriate data
were used vs. understanding a potentially poorly designed or labelled chart. Reviewer D makes a similar point:
the main example is hard to follow because of various suboptimal visualisation choices, and it's unclear
whether our interest is in such visualisations specifically, or whether well-designed visualisations can also
benefit. Both use cases -- verifying provenance in "good" visualisations and diagnosing/understanding "bad"
ones -- but it should be clearer that our approach is intended to support both. Including a simpler example
(where the visual output is not itself problematic) will help.

### Reviewer A

- _Typing rules._ These were included in the POPL 2022 work for clarity but omitted here for reasons of space;
  we will include them in an Appendix.

- _Correctness statement on DDG._ See response (Q2) above.

- _Overhead compared to core language without DDG annotations._ This is a good question that would be
  relatively straightforward to answer, without taking up too much space; we will do so.

Additional points made by Reviewer A:

- _Lack of connection between Sections 3 and 4._ This is indeed a weakness of the present paper which we
  respond to in (Q1) and (Q2) above.

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
  not a pressing concern as our implementation does not use the "dual of `suff`" implementation of `demBy`,
  but instead uses the faster approach of the 'G-DemBy' column.

### Reviewer B

- _Difficult terminology and concepts in first 2 sections._ Introducing the key ideas was a challenge,
  especially given the multiple dimensions of "duality" (conjugates, De Morgan duals, adjoints), and we agree
  that this should be improved. We will give an intuition and definition for the De Morgan dual, but will also
  try to do a better job of the transition from the "adjoint" setting (`\triangledown` and `\blacktriangleup`)
  to the conjugate setting (`\triangledown` and `\triangleup`, and explain the role of the De Morgan dual in
  connecting these two.
- _Data provenance vs. understanding poorly designed charts_. We clarify this in (Q4) above.
- _Data dependencies vs. control dependencies_. We stated this a bit misleadingly -- we do track branching on
  content of data, using the pattern-matching rules which identify the (partial) value that was consumed in
  order to select a branch, but this is not distinguished from any other kind of dependency. However, as your
  example program illustrates, distinguishing these two can be useful for explanations -- we do plan to
  revisit this in future work, as part of exposing "intensional" information to users ("how" in addition to
  "what"). We will expand that closing discussion to include this point and perhaps a simple example similar
  to yours.
- _Presentation of demBy via inference rules_. Yes, demBy can also be expressed in more traditional
  algorithmic form, but presenting it in this form indeed helps in the proof of Proposition 3.18, as suggested
  by the reviewer [expand].
- "The rule extends gave me a hard time, i.e., what does $H = {\alpha: Y}$ mean? H is "added" to a graph $G' =
  (V', E')$...". $H$ here is a (sub)graph with verties $\alpha$ and $Y$ and with edges from $\alpha$ to every
  vertex in $Y$. Somehow the explanation of this got swallowed during editing and we will add it back.
- _Concrete runs of algorithms_. Fig. 6 was intended to illustrate a concrete run of `suff`, showing how edges
  are copied from the original graph to the slice; we will make this clearer (for example by indicating which
  `suff` is being applied in each subfigure).

### Reviewer C

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

### Reviewer D

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

## 2. List of Proposed Changes

We will implement all the minor corrections provided, and in addition propose the following more significant
improvements to the paper.

### Sections 1 and 2 (Intro/Overview)

- Expand on differences between new approach vis-a-vis POPL 2022 approach (Q1):
  - Explain why previous approach doesn't directly support related inputs, and how a simple family of
    operators (projections with conjugates) can be used both to recover the prior work precisely in the new
    setting and formally explain brushing-and-linking.
  - Show how projections-with-conjugates (a form of biproduct) support more focused queries, with a new simple
    example.

### Sections 3 and 4 (Graph Operators/Semantics)

- Bridge gap between sections 3 and 4:
  - Show how adjoint/conjugate operators on graphs give rise to analogous operators on environment, program
    and value selections
- Clear rationale for choice of datatypes + eliminators vs. lambda calculus with sums, products and recursive
  types

### Section 5 (Evaluation)

- Evaluate overhead compared to core language without building DDG or trace
- Provide anonymised web-based artefact to allow reviewers to experiment with the implementation

### Sections 6 and 7 (Related/Future Work)

Additional discussion in closing sections
- Benefits of developing approach for general-purpose language vs. visualisation DSL like Vega (Reviewer A)
- Relationship to developments in data provenance for aggregates or recursive queries, and potential for
   using conjugate operators identified here in other settings with negation (e.g. databases) (Reviewer A)
- Mention idea of distinguishing information about choices/control flow from "content" and related to
   intensional explanations (Reviewer B)
- Expand discussion on "semantically justified" dependency relation to include a sketch of what a notion like
  "dependency correctness" might look like in our setting
