We thank our four reviewers for their detailed reviews and suggestions for improving the paper. We address the
specific comments (C) asked by each reviewer below, along with some proposed
improvements to the paper.

## Reviewer A

C1. _Difficulty understanding graph construction from formalisation in Section 4._ We agree that the DDG
examples are rather simple relative to the richness of the language, and that overall this section could be
improved by some richer examples that show how the presented semantics leads to interesting dependency
relationships.

## Reviewer B

C1. _Relationship to prior work in provenance and explainability/transparency._ Thank you for pointing out
these omissions:

1) Multiverse analyses. The multiverse work is an important perspective that deserves discussion; we see
our approach as complementary (for example different analysis choices would induce different selections on the
input data, which could be informative).

2) Database provenance. We intended to include a discussion of related ideas in database provenance (beyond
the brief mention in Section 6), but this fell by the wayside; we will be sure to expand the discussion in
Section 6 and also use it to provide better context to the introduction/overview.

3) Explanation in visual analytics. We have looked at Wu's thesis and subsequent papers and this also seems
highly relevant/complementary so we look forward to dicussing this as well.

C2. _Motivation leans too heavily on developer ease-of-use and end-user benefits._ This is a fair comment. We
will de-emphasise or remove motivation that isn't supported explicitly by our evaluation; for example we will
set out the end-user scenarios we wish to support, without making specific claims about ergonomic benefits
beyond responsiveness, and for developers simply point out that the interpreter only needs to be implemented
in a single direction rather than bidirectionally, without suggesting that this is automatically "simpler"
(which would be a claim in need of empirical support). We will then clarify that the primary motivation is a
more responsive/performant UI, as supported by our evaluation.

## Reviewer C

C1. _Graph dependencies via conjugate operators is complicated_. Conjugacy is important because it is the
formal framework for relating forward and backwards analysis over the graph, for example explaining why you
can compute the same function (extensionally) in two different ways, with potentially different performance,
using the De Morgan dual. We will streamline this section and also reorganise things so that the graph
semantics comes first (with richer examples, as per Reviewer A), and the conjugate operators over the graph
are presented afterwards, with a cleaner presentation.

C2. _Graph algorithms don't pay attention to properties of operators_. By the time the graph algorithms are
presented with a graph, that graph already captures the kind of information you are referring to; so in the
running example you mention, the dependence graph already captures the specific fact that x2 * x3 only depends
on x2 (because it is zero), not x3. Thus whereas the procedure that builds the graph must depend on facts like
these, the algorithms that operate on the graph can act uniformly on the graph without having to consider
those details, which is one of the key benefits of factoring things this way.

C3. _Would prefer shorter intro, omitting 1.1 but expanding on contributions/roadmap._ Indeed Section 2 is
rather short and Section 1 goes into a lengthy worked example before getting to contributions/roadmap, so we
will reorganise along the lines you suggest.

C4. _Inference rule presentation of algorithms._ This way of presenting algorithms (as inductively defined
relations, which one may subsequently prove to be deterministic and/or total) is useful for establishing the
required metatheory (for example Propositions 3.17 and 3.19). These theorems would be difficult to prove for
pseudocode presentations of the algorithms.

## Reviewer D

C1. _Claims of novelty_. While there is prior work on (1) generating provenance/dependency graphs, (2)
brushing and linking over such graphs, and (3) database-based queries over such graphs, we are not aware of
such a feature being used to relate data sources to other data sources (as opposed to relate visualisations to
other visualisations), nor are we aware of other approaches where these two kinds of linking can be understood
as formally dual. We will make sure to emphasise these as novel contributions of our approach.

C2. _Relationship to Database Provenance._ While it is true that many systems involve databases, end-to-end
provenance solutions for such systems will also need to handle visualisation and analytics code written in
general-purpose languages like R and Python. In this work we focus on supporting provenance-based linking in a
general-purpose language rather than database, to close this gap in the literature. As mentioned in our
response to Reviewer A, we will include a proper discussion of related work in database provenance.

C3. _Relationship to Visualization Linking and Provenance._ While provenance-based brushing and linking has
been explored before in database settings, most real-world systems have substantial visualisation and
analytics components written in general-purpose languages like R and Python. Our contribution is to develop
compositional provenance-based techniques for languages like these, which will be needed to interoperate with
database-based solutions. Thanks for pointing us to more of the relevant literature.
