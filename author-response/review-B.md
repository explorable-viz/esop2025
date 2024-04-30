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
