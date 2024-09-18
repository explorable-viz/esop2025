We thank our four reviewers for their detailed reviews and suggestions for improving the paper. We address the
specific comments (C) and questions (Q) asked by each reviewer below, along with some proposed
improvements to the paper.

## Reviewer A

C1. _Difficulty understanding graph construction from formalisation in Section 4._ We agree that the DDG
examples are rather simple relative to the richness of the language, and that overall this section could be
improved by some richer examples that show how the presented semantics leads to interesting dependency
relationships.

## Reviewer B

C1. _Relationship to prior work in provenance and explainability/transparency._ Thank you for pointing out
these omissions. We intended to include a discussion of related ideas in database provenance (beyond the brief
mention in Section 6), but this fell by the wayside; we will be sure to expand the discussion in Section 6 and
also use it to provide better context to the introduction/overview. The multiverse work is an important
perspective and also deserves discussion; we see our approach as complementary (for example different analysis
choices would induce different selections on the input data, which could be informative). We are less familiar
with the line of work on explanation in visual analytics (e.g. Wu's thesis and subsequent papers) but this
also seems highly relevant/complementary so we look forward to dicussing this as well.

C2. _Motivation leans too heavily on developer ease-of-use and end-user benefits._ This is a fair comment. We
will clarify that the primary motivation is a more responsive/performant UI. For example we can set out
the end-user scenarios we wish to support, without making specific claims about ergonomic benefits beyond
responsiveness, and for developers simply point out that the interpreter only needs to be implemented in a
single direction rather than bidirectionally, without suggesting that this is automatically "simpler" (which
would be a claim in need of empirical support).

## Reviewer C

C1. _Graph dependencies via conjugate operators was complicated_. The notion of conjugacy is important because
it is the formal framework for relating forward and backwards analysis over the graph, and explains why you
can compute the same function (extensionally) in two different ways, with potentially different performance.
It is true that the current presentation is more complex than it needs to be.

C3. _Graph algorithms don't pay attention to properties of operators_. By the time the graph algorithms are
 presented with a graph, that graph already captures the kind of information you are referring to (for example
 the specific behaviour of * in relation to 0). The algorithms can thus act uniformly on the graph without
 having to consider the specific semantics of the language or its primitive operators, which is one of the key
 benefits of factoring things this way.

C4. _Would prefer shorter intro, omitting 1.1 but expanding on contributions/roadmap._ Indeed Section 2 is
 rather short and Section 1 goes into a lengthy worked example before getting to contributions/roadmap, so we
 will considers a reorganisation along the lines you suggest.

C5. _Inference rule presentation of algorithms._ This way of presenting algorithms (as inductively defined
relations, which one may subsequently prove to be deterministic and/or total) is useful for establishing the
required metatheory (for example Propositions 3.17 and 3.19). These theorems would be difficult to prove for
pseudocode presentations of the algorithms.
