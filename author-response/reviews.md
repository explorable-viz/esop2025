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

# Review #60B

## Overall merit
B. OK paper, but I will not champion it

## Reviewer Expertise
Y. I am knowledgeable in this area, but not an expert

## Reviewer Confidence
3. Good: I am reasonably sure of my assessment

## Paper summary
The paper presents a technique for data provenance on analytics, where data
analysts can ask questions of different kinds. They are mainly categorized as
follows:

- (a) Choosing some inputs, which outputs do they affect?
- (b) Choosing some inputs, which outputs are only computed with them?
- (c) Choosing some outputs, which inputs do they need to be computed?
- (d) Choosing some outputs, which inputs are solely responsible for their computation?

There is a duality between (a) and (c), and (b) and (d), and it is precisely
this duality what authors exploit to develop a uniform, principled solution.
They mathematically show that it is enough to answer (a) (in the general sense,
not only with inputs and outputs) with a graph of "forward dependencies", the
ability to reverse that graph, and by exploiting some properties (conjugate)
between how to answer (a) and (c).

Despite such connections and the minimal requirements to answer the questions
above, the authors then provided algorithms to compute the answers for (a) and
(b) and then just used the ability to reverse the graph to answer (c) and (d)
using the *same* algorithms. All of this, in the name of performance--which is
fine!

All of the results above are provided in a language-independent manner, i.e.,
just using graph representations. The paper then provides a programming language
in which semantics also constructs a dependency graph that is then used to
answer the data analysts' questions on data provenance.

The main competitor of this work is that of Perera et al. [2022], which is less
expressive and uses a more heavyweight technique (backward interpretation). Some
benchmarking is presented against that work.

## Assessment of the paper
The paper presents a nice theoretical development with graphs and conjugate /
Galois connections as well as a bit of PL.

On the positive side, it makes super clear the dualities of input-output
dependencies, where the operators proposed to answer (a) and (c) can be combined
to obtain "related inputs" -- i.e., if I select some inputs, then I see which
outputs it affects but I also see which other inputs influence those outputs. In
a similar manner, the dual composition gives rise to the "related outputs" --
i.e., I select some outputs, then I see which inputs influence them but also
which other outputs those inputs affect. I like as well that they create a
programming language where the syntax is transparent to all of such input-output
dependency analysis.

On the negative side, the terminology of the paper is hard to grasp in the first
sections where terms like "sufficiency" or "De Morgan Dual" are mentioned -- it
took me a while to see what you meant precisely. It is also a pity that all the
duality connections using conjugate / Galois connection / De Morgan Dual in the
end is not used. So, I was wondering why, as I reader, I need to spend much time
to understand every technical detail of that and the paper cannot just mention
it as an alternative formulation and talk more about case studies or the PL part
(see my comments below).

## Questions for authors’ response
Please, see my questions in the comments below.

## Comments for authors
### Data provenance motivation

The paper is about data provenance, but sometimes the introduction argues for it
due to poor label descriptions in visualizations. For instance,

- ln 63, "What does the colour scheme indicate?"

- ln 140, "In the scatter plot, the label on the x-axis suggests that it
represents some kind of part-to-whole ration.. "

When I think about data provenance, I usually think about providing evidence
that the right pieces of information were considered for the output. However,
the paper seems to hint that it is also helpful to understand potentially poorly
designed charts. Which aspect are you concerned about? Both? Please, clarify.

### Introduction

In the introduction, you talked about a Galois connection between minimal
$\traingledown$ and sufficient $\backtriangleup$, but then in Figure 2 you use
"demanded by" $\triangleup$. That puzzled me, and it was confusing. Please,
unify the example with the connection you want to state (or simply remove it).

You mention "De Morgan dual" in the intro but it is never defined or given an
intuition.

### Control flows

Ln 384 says that the dependency graph only considers data dependencies and not
control ones. I was wondering then, what kind of analytics your approach helps
the most and which ones will perform poorly. Imagine a program that computes an
histogram with two bins to count how many people come from developing and
industrialized countries:

for r in dataset:
    if r.nationality \in Europe
    then h[0]++
    else h[1]++

h[0].label = "industrialized countries"
h[1].label = "dev. countries"

plot(h)

*Both* h[0] and h[1] depend on r.nationality, however, it does not say much
about how it has been used to create h[0] and h[1]. If I consider your approach
as helping understand poor labels in visualization charts, then I believe it
will not help much in this case.

How do you plan to deal with this? Are there any of the programs in Section 5
have a branching on the content of the data similar to my example above?

### Direct algorithms

The direct algorithms in 3.5.1 and 3.5.2 are one of the main contributions of
this work.

Isn't it the case that demBy algorithm can be implemented as a (forward)
breadth-first graph algorithm? Why is it presented in this rule-based way? Does
it help in the proof of Proposition 3.18? The rule extends gave me a hard time,
i.e., what does it mean $H = {\alpha: Y}$? H is "added" to a graph $G' = (V',
E')$ but also to a set of vertices $X$, so it does not type-check in my mind.
Did I miss something? A similar observation to the algorithm $suffE_G$. At this
point, I wish you provided concrete runs of your algorithms.

### Soundness of graph construction

In the operational semantics, you show how to build the graph of dependencies.
Is there a soundness theorem that indicates that it is properly constructed? I
am thinking that some rules are not trivial (e.g., let-rec).

One soundness statement I could think of could be to say that: given no branches
in the code, and a resulting graph for a given execution E1, then for any input
X you choose, you determine the outputs that it sufficiently affects, i.e.,
$\blacktriangleup(X)$. Now, given another execution E2 obtained by changing
other inputs not in X, then the outputs in $\blacktriangleup(X)$ should not be
changed and they should be equal to those in E1. If you have branches, then you
need to be sure that whatever values you pick for E2, those values take the same
branches as those you hit in E1. You might be looking at "Explicit Secrecy: A
Policy for Taint Tracking" by Schoepe et al. for inspiration of soundness
statements.

### Miscelaneous

- ln 375: should it be $\neg$ indexed by X ? Strictly speaking, it is not a
unary operator, it needs "the universe" to obtain the relative complement.

- ln 426, How often is an IO relation a function in analytics? Can it be
characterized somehow?

- ln 450, aren't you missing $\exits x \in X' \cdot (x,y) \in R$? -- the same
occurs in the next line. Otherwise, I am afraid I am not understanding the
definition.

- line 511, "G demBy V_G" --> "G',X demBy V_G" ?

# Review #60C

## Overall merit
B. OK paper, but I will not champion it

## Reviewer Expertise
Z. I am not an expert; my evaluation is that of an informed outsider

## Reviewer Confidence
2. OK: I have some confidence in my assessment

## Paper summary
In the realm of data visualizations, it can be quite useful to interactively query some displays (graphs, figure, plots, charts) to understand the relationships between once piece of data. Or, specifically, how one one quantity relates to one another, because one input influences the output of another, or vice-versa.

This paper presents the design of a DSL that supports a novel method for inferring those relationships. Rather than relying on traces of execution, the technique instead relies on an interpreter that builds a graph of relationships and allows querying this graph for various flavors of relatedness.

The contributions are the new way of thinking (with a neat presentation of the operators) in terms of graphs, the design and implementation of the corresponding language, and an evaluation that shows the authors' technique, while more expensive to initially set up, then is more reactive for interactive queries.

## Assessment of the paper
### Strengths.
- Neat, polished presentation, with a rigorously-written and well-presented paper.
- Clearly an improvement over the '22 previous work. In comparison, the previous trace-based approach feels very ad-hoc, while this feels very principled and grounded in a solid framework for *thinking* about these kinds of relationships between pieces of data.
- Strong evaluation that highlights the strengths and weaknesses of the two approaches.

### Weaknesses.
- I thought the design of the language would've benefited from more commenting.
  - Why this particular distinction between eliminators and expressions (i.e. putting pattern-matches at the top)? Does it play a key role later on? Why not a "normal" core lambda-calculus?
  - Why the absence of loops which, conceivably, would be quite natural to have in this language? Is it all desugared away?
- I thought I would see a fixpoint operator at some point because of the recursive definitions in your language, but I didn't see any mention of this. I know you try to explain this around line 848 but something clearly escaped me here, that would be worth clarifying.
- I thought your choice of example did you a disservice. The presentation of the graphics is really hard to follow and the choice of axes, data grouping, and tables is just... suboptimal. Then, is the point of your toolchain to alleviate poorly-designed data visualizations by helping make sense of them, or does your system shine with well-designed data visualizations, too? Maybe another example or two would've helped.
- It's really too bad, for such an interactive tool, that an anonymous supplement wasn't provided to see and play with those visualizations in real time.

## Questions for authors’ response
Please address weaknesses above.

## Comments for authors
- the numbers in line 1 of table 3 seem wrong
- how many of the queries in the evaluation can be compiled ahead of time? it feels like if the program is known statically, you should be able to compute the graph along with the data before serving it to the client; but maybe it truly is all dynamic

### Review #60D

## Overall merit
C. Weak paper, though I will not fight strongly against it

## Reviewer Expertise
Z. I am not an expert; my evaluation is that of an informed outsider

## Reviewer Confidence
2. OK: I have some confidence in my assessment

## Paper summary
This paper presents a simple pure functional language for creating
visual graphs and charts. The execution produces also a dependency
graph from inputs to outputs which can then be used to query the
graphs: what inputs were needed to produce a certain output value,
or what outputs depended on a certain input, and finally, what
inputs are related as a composition of the previous two. There
is a full implementation available.

## Assessment of the paper
The paper is nice to read and well formalized.
The main concern I have is that the delta to previous work [1] may
not be significant enough and much of the paper repeats results
from earlier work [1] in a very similar way. The main new contributions
are:

1. Instead of building an execution trace, the execution builds an
  explicit dependency graph from input values to output values.
  This graph can be analyzed to relate initial
  inputs (sources) to final outputs (sinks) and the other way around
  by reversing the arrows (taking the inverse graph).
  This is good of course, but it seems the obvious thing to do?
  When looking at the execution rules in Fig. 12 the construction of
  the dependency graph is straightforward without particular surprises?

2. The paper introduces the idea of "related inputs". Now, [1] also
  already discusses the dual "related outputs" so that seems a small
  step as well? Moreover, the related inputs are just a composition
  of the basic queries: what outputs depend on a certain input, followed
  by what (other) inputs are required for those outputs?

Question 1: Do the above two items correctly characterize the main _delta_ with respect [1]?

Nevertheless, even if the delta is essentially small, the current work based on an
explicit dependency graph does improve the results as it is much
easier implement and to understand the essence of the work.

One other concern is that the paper is still presented in a way that still
fails to convey the essence of the work clearly. The nice relation with
various standard math results is very satisfying but it would be better
to also highlight that the underlying idea is quite straightforward.
In essence, once we have a dependency graph between sources and sinks
we can compute all the queries on graphs as presented. As it stands,
the current presentation fails to communicate this well in my opinion.

Another example of this is in the language definition (which is almost exactly
as presented in [1]). Section 4.1.3 discusses the continuations and
eliminators. This is just a (lambda bound) case statement formulated
in a way to make the binding and tracking of dependencies convenient.
Question 2: Why doesn't the calculus just have a one-level deep explicit case
statement? This would be more standard and remove the need to even
talk about eleminators and "trie-like" objects etc. That is all irrelevant
to the subject of the paper?

[1] Roly Perera, Minh Nguyen, Tomas Petricek, and Meng Wang. 2022. Linked Visualisations via Galois Dependencies. Proc. ACMProgram.Lang.6,POPL,Article7(2022),29pages.
