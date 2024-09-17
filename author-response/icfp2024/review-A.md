# Review #60A

## Overall merit
B. OK paper, but I will not champion it

## Reviewer Expertise
Y. I am knowledgeable in this area, but not an expert

## Reviewer Confidence
2. OK: I have some confidence in my assessment

## Paper summary
The authors introduce a general-purpose untyped functional language designed to automatically compute provenance relations between output and input data, particularly in the context of interactive and explainable graphical visualizations.

The authors present an algebraic approach based on Galois connections within Dynamic Dependences Graph (DDG) incorporating four inter-definable query operators that compute "sufficient" inputs and "demanded" outputs.

Subsequently, the authors delineate the core functional language, integrating an evaluation mechanism that both evaluate terms and compute their corresponding DDG.
They demonstrate the applicability through an ML-like user-language used to compute graphical visualizations.

Finally, the paper compares the experimental overhead induced by DDGs with that of Fluid language, a similar system which employs traces rather than graphs for provenance.

## Assessment of the paper
The interdisciplinary nature of the problem and its solution is very interseting, as the authors bridge diverse research domains including functional programming, data flow analysis, provenance analysis, and human-computer interaction.

The decision to employ a general-purpose language, rather than a domain-specific one tailored solely to graphical visualization (e.g., the Vega ecosystem built on declarative languages for interactive visualizations, see <https://vega.github.io/>), is innovative and aligns well with the context of ICFP.

Furthermore, the utilization of Galois connections and closure operators on DDG provides a robust and fruitful foundation, considering their ubiquity and depth within computer science ("adjoint functors arise everywhere").

These strong points are reinforced by the engaging prose throughout the paper.

However, a notable weakness lies in the comparison with Perera et al. [POPL'22]. The submission and the referenced paper appear closely related, sharing motivating examples, surface language, a segment of the core language (expanded from trace-based to graph-based semantics), and certain concepts underlying the algebraic framework (particularly Galois connections).

To strengthen the paper, additional connections between Section 3 (Conjugate operators for DDG) and Section 4 (A core language with graphical syntax and semantics) may be worth considering. Currently, there are limited cross-references from Section 4 onwards to the material developed in Section 3. While the notion of separating language-agnostic queries on DDG from the calculus is articulated, Sections 3 and 4 seem somewhat (too much) independent.

On one hand, additional operators beyond those presented in Section 3 may prove beneficial (e.g., a more general-purpose graph query language such as the forthcoming GQL Standard) atop the DDG constructed by the core language. On the other hand, any DDG, not solely the specific one built in Section 4, should be consumable by the operators in Section 3. Both sections undoubtedly contribute to the paper, but their contributions are somewhat segregated.

## Questions for authors’ response
The paper from [POPL'22] provides typing rules for the core language, whereas the language in this paper is untyped. Are there specific reasons for this choice?

The paper from [POPL'22] establishes a connection between Galois connection and the language's semantics through theorem 3.10. Is it possible to formulate a correctness statement on DDG based on the big-step evaluation or a relation between static (DDG from Section 4) and runtime (operators form Section 3) computations?

Is there an estimate of the overall overhead when comparing against the core language without DDG annotations, rather than against Fluid?  Considering the significant cost associated with adding provenance tags to relational database queries, I anticipate a similar overall overhead.

## Comments for authors
The problem of "brushing and linking" is mentioned several times but doesn't seem to be formally related to Sections 3 and 4.

Definition 3.10 uses double negation instead of a more direct style $\forall x \in X'. \ldots$.

Introducing a lemma encapsulating the determinism of $\textsf{demBy}$ in Section 3.5.1 could simplify the first paragraph and footnote #1.

The "strictness condition" in Lemma 3.22 (the image of the empty set is the empty set) may suffice for adjoints. I may be worth exploring if this originates from a more fundamental principle.

The usage of an older version of the V8 runtime in Section 5.2 seems peculiar; it could be the default version from the OS packages.

In Section 5.1.4, the slowdown observed in G-DemBy-Suff on the last four lines raises some questions, as it's one of the main application highlighted in the paper.

The database community has extensively developed an algebraic theory on data provenance for conjunctive queries, utilizing free semirings to construct provenance expressions linked to query results. The reference to Cheney et al. 2011 serves as a bridge between academic communities. However, I'm curious about the extent to which recent advancements in provenance for aggregates or recursive queries (e.g., as discussed in https://arxiv.org/abs/1101.1110 or https://arxiv.org/abs/2202.10766) intersect with the handling of recursive functions in the core language. Conversely, the conjugate operators identified here may hold applications in databases as well.

It might be worthwhile to mention that Galois connections are a special case of adjunction, and the associated closure operator corresponds to the monads that arise naturally through functor composition. This connection could suggest links with other research works. For instance, is provenance management a form of effect that can be captured through a monad in a Haskell-like style?

I'd be delighted to have further discussions (in Section 6.3 or earlier) regarding the benefits of a comprehensive functional programming language over a Visualization DSL grammar like Vega. Conversely, if we impose restrictions on the core language (e.g., no user-defined lambdas, a fixed set of data structures), does termination ensue? Moreover, does the language still retain greater expressivity than languages specifically tailored for data visualization?
