# Overall Thoughts (not to be included in response)
- None of the reviewers consider themselves to be experts on the material
- Recurring themes:
  - Minor delta vis-a-vis POPL 2022 paper

## Reviewer A
B. OK paper, but I will not champion it
Y. I am knowledgeable in this area, but not an expert
2. OK: I have some confidence in my assessment

**Specific points highlighted for authors' response**
- Small delta vs. POPL 2022 (shared examples, segment of core language, use of Galois connections)
- Needs additional connections between Sections 3 and 4. As reviewer notes, more general-purpose graph queries may be possible on of DDG, which is a benefit of keeping them separate, but currently not clear how the two are related
- Any reason for omitting typing rules (vs. POPL 2022)
- POPL 2022 establishes a connection between Galois connection and the semantics through theorem 3.10. Is it possible to formulate a correctness statement relating DDG to graph operators?
- Overhead when comparing against core language without DDG annotations?

**Additional points that might warrant commentary**
- Relationship of "brushing and linking" to formal development in Sections 3 and 4
- "Strictness condition" in Lemma 3.22 (image of empty set is empty set) may suffice for adjoints; may be worth exploring if this originates from a more fundamental principle
- Slowdown observed in G-DemBy-Suff (Section 5.1.4) raises some questions, as it's one of the main applications highlighted in the paper
- Relationship to recent advancements in provenance for aggregates or recursive queries to handling of recursive functions in the core language;conversely, the conjugate operators identified here may hold applications in databases as well
- Is provenance management a form of effect that can be captured through a monad in a Haskell-like style?
- Some discussion (e.g. in Section 6.3) regarding benefits of a general-purpose functional language vs. Visualization DSL like Vega

# Reviewer B

## Overall merit
B. OK paper, but I will not champion it

## Reviewer Expertise
Y. I am knowledgeable in this area, but not an expert

## Reviewer Confidence
3. Good: I am reasonably sure of my assessment

# Reviewer C
B. OK paper, but I will not champion it
Z. I am not an expert; my evaluation is that of an informed outsider
2. OK: I have some confidence in my assessment

**Specific points to respond to**
- Why distinction between eliminators and expressions? Why not a "normal" core lambda-calculus?
- Why the absence of loops?
- Why no fixpoint operator?
- **No anonymous supplement provided to play with those visualizations in real time**
- If program is known statically, you should be able to compute graph along with data before serving it to the client

# Reviewer D
C. Weak paper, though I will not fight strongly against it
Z. I am not an expert; my evaluation is that of an informed outsider
2. OK: I have some confidence in my assessment
