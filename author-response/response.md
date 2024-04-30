We thank our four reviewers for their careful and engaged reviews. We respond to comments made by two or more
reviewers first, and then address remaining questions raised by specific reviewers.

# Issues raised by multiple reviewers

## 1. Delta with respect to POPL 2022 paper (Reviewers A and D)

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

## 2. Correctness statements relating DDG to big-step evaluation and/or graph operators (Reviewers A and D)

Reviewer A asks whether we could formulate a correctness theorem for the DDG, relating it to the big-step
evaluation in 4 and/or graph operators in 3.

## Questions raised by Reviewer A

- Typing rules. These were included in the POPL 2022 work for clarity but omitted here for reasons of space; we will
  include them in an Appendix.

- Correctness statement on DDG. See our response to issue (2) above.

- Overhead compared to core language without DDG annotations. This is a good question that would be relatively
  straightforward to answer, without taking up too much space; we will do so.

Additional points made by Reviewer A

- Lack of connection between Sections 3 and 4. This is indeed a weakness of the present paper. We will address
  this by []

### List of proposed changes

***

## Review A

**Additional points that might warrant commentary**
- "Strictness condition" in Lemma 3.22 (image of empty set is empty set) may suffice for adjoints; may be worth exploring if this originates from a more fundamental principle
- Slowdown observed in G-DemBy-Suff (Section 5.1.4) raises some questions, as it's one of the main applications highlighted in the paper
- Relationship to recent advancements in provenance for aggregates or recursive queries to handling of recursive functions in the core language;conversely, the conjugate operators identified here may hold applications in databases as well
- Is provenance management a form of effect that can be captured through a monad in a Haskell-like style?
- Some discussion (e.g. in Section 6.3) regarding benefits of a general-purpose functional language vs. Visualization DSL like Vega

# Review B

**Specific points highlighted for authors' response**
- Terminology of paper is hard to grasp in the first sections. E.g. intro talks about a Galois connection between minimal $\triangledown$ and sufficient $\blacktriangleup$, but then in Figure 2 you use "demanded by" $\triangleup$. Similarly, "De Morgan dual" is mentioned in intro but never defined or given an intuition
- Duality connections using conjugate / Galois connection / De Morgan Dual seem to be used; perhaps just mention as an alternative formulation and talk more about case studies or PL part
- Are you interested in providing evidence that the right pieces of information were considered for the output, or in helping understand potentially poorly designed charts? Please clarify
- You say dependency graph only considers data dependencies and not control dependencies -- what about branching on content of data?
- Can demBy can be implemented as a (forward) breadth-first graph algorithm? Does presenting it in this rule-based way help in the proof of Proposition 3.18? The rule extends gave me a hard time, i.e., what does $H = {\alpha: Y}$ mean? H is "added" to a graph $G' = (V',
E')$ but also to a set of vertices $X$, so it does not type-check in my mind.
- I wish you provided concrete runs of your algorithms
- Is there a soundness theorem that indicates graph is properly constructed?
- Line 450, aren't you missing $\exits x \in X' \cdot (x,y) \in R$?

# Review C

**Specific points to respond to**
- Why distinction between eliminators and expressions? Why not a "normal" core lambda-calculus?
- Why the absence of loops?
- Why no fixpoint operator?
- **No anonymous supplement provided to play with those visualizations in real time**
- If program is known statically, you should be able to compute graph along with data before serving it to the client

# Review D

**Specific points to respond to**
- Delta to POPL 2022 may be too small -- Do the above two items correctly characterize the main delta?
- Better to highlight that underlying idea is quite straightforward
- Continuations and eliminators irrelevant to subject of paper. Why doesn't the calculus just have a one-level deep explicit case statement? This would be more standard and remove the need to even talk about eleminators and "trie-like" objects etc.
