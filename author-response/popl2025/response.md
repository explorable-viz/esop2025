We thank our four reviewers for their detailed reviews and suggestions for improving the paper. We address the
specific comments (C) asked by each reviewer below, along with some proposed improvements to the paper.

# Responses to Reviewers

## Reviewer A

C1. _Difficulty understanding graph construction from formalisation in Section 4 (Graph Semantics)._ We agree
that the DDG examples are rather simple relative to the richness of the language. We think this would be
improved by using the running example from Section 2 to illustrate both the language and semantics in Section
4, and how the presented semantics leads to interesting dependency relationships.

C2. _Dependency graph and algorithms are somewhat standard_. We will simplify Section 3 (Conjugate Operators
over Graphs) so that the role of these abstractions is clearer and there is less emphasis on standard
constructions.

## Reviewer B

C1. _Relationship to prior work in provenance and explainability/transparency._ Thank you for pointing out
these omissions. We will include all of these. A few notes:

1) Multiverse analyses. The multiverse work is an important perspective; we see our approach as complementary.
For example, different analysis choices would induce different selections on the input data, which could be
informative. We will discuss this in Related Work.

2) Database provenance. We did indeed omit a discussion of related ideas in database provenance beyond the
brief mention in Section 6; we will be sure to expand that discussion and also use it to provide better
context to the introduction/overview.

3) Explanation in visual analytics. We have looked at Wu's thesis and subsequent papers and this also seems
highly relevant/complementary so we look forward to dicussing this as well.

C2. _Motivation leans too heavily on developer ease-of-use and end-user benefits._ This is a fair comment; we
will de-emphasise or remove motivation that isn't supported explicitly by our evaluation. When setting out the
end-user scenarios we wish to support, we will avoid any implied claims about ergonomic benefits beyond
responsiveness and what can be shown, and when discussing implementation overhead, will simply point out that
the interpreter only needs to be implemented in a single direction rather than bidirectionally, without
implying that this is necessarily "simpler" (which would be a claim in need of empirical support). We will
clarify that the primary motivation is a more responsive/performant UI, as supported by our evaluation.

## Reviewer C

C1. _Graph dependencies via conjugate operators seem complicated_. We agree that the section on conjugate
operators could be presented more clearly. Conjugacy is important because it is the formal framework for
understanding the relationship between forwards and backwards analysis over the graph. For example, it
explains why the same function can be computed in two different ways, with potentially different performance,
using the De Morgan dual. We will streamline this section to make this clear, and also reorganise so that the
graph semantics comes first (with richer examples, as per Reviewer A), and the conjugate operators afterwards,
with a cleaner presentation.

C2. _Graph algorithms don't pay attention to properties of operators_. Graph building depends on the semantics
of the language, and thus can capture that x2 * x3 depends only x2 when x2 = 0, whereas graph queries are
semantics-agnostic (what is being referred to in line 951). This modularity is one of the key advantages of
structuring the system this way. We will clarify this in the paper.

C3. _Would prefer shorter intro, omitting 1.1 but expanding on contributions/roadmap._ Indeed Section 2 is
rather short and Section 1 goes into a lengthy worked example before getting to contributions/roadmap, so we
will reorganise along the lines you suggest.

C4. _Inference rule presentation of algorithms (Fig 5)._ This way of presenting algorithms (as inductively
defined relations, which one may subsequently prove to be deterministic and/or total) is useful for
establishing the required metatheory (for example Propositions 3.17 and 3.19). These theorems would be
difficult to prove for pseudocode presentations of the algorithms.

## Reviewer D

C1. _Claims of novelty_. Agreed, this needs clarification. While there is indeed prior work on (1) generating
provenance/dependency graphs, (2) brushing and linking over such graphs, and (3) database-based queries over
such graphs, we believe we are the first to:

- Consider the problem of linked selections between different inputs (data sources), rather than linking
selections across outputs (visualisations); this is a key contribution of our approach.
- Show how this new flavour of brushing and linking can be understood as formally dual to the traditional one.

We will make sure to emphasise these as novel contributions of our approach with respect to (2). We claim no
specific novelty with respect to (1) or (3), but will do a better job of contextualising our work with
respect to these in the Introduction and in Related Work.

C2. _Relationship to Database Provenance._ While it is true that many systems involve databases, end-to-end
provenance solutions for real-world systems will also need to handle visualisation and analytics code written
in general-purpose languages like R and Python. In our work, we focus on supporting provenance-based linking
in a general-purpose language rather than a database language, to address this gap. As mentioned in our
response to Reviewer A, more discussion of related work in database provenance is needed and we will make
sure to include this.

C3. _Relationship to Visualization Linking and Provenance._ While provenance-based brushing and linking has
been explored before in databases, most real-world systems have substantial visualisation and analytics
components written in general-purpose languages, as mentioned above. Our contribution is to develop
compositional provenance-based techniques for such languages, which will be needed to interoperate with
database-based solutions. Thanks for pointing us to more of the relevant literature.

# List of Proposed Changes

We will implement all the minor corrections provided, and in addition propose the following improvements to the paper.

### Sections 1 and 2 (Intro/Overview)

- Emphasise primary motivation as performance-related and de-emphasise developer or end-user benefits
  (Reviewer B, C2)
- Move Section 1.1 from Introduction to Overview (Reviewer C, C3)
- Clarify novelty in relation to prior work in database provenance and brushing and linking over provenance
  graphs (Reviewer D, C1)

### Sections 3 and 4 (Graph Semantics and Conjugate Operators over Graphs)

- In Section 4,  provide richer examples (reusing running example from Section 2) to give better intuition for
  graph semantics (Reviewer A, C1)
- Streamline Section 3 (Conjugate Operators over Graphs) to simplify presentation (Reviewer C, C1 and Reviewer
  A, C2)

### Sections 6 (Related Work)

- New section on prior work on provenance graphs and database provenance (Reviewer B, C1 and Reviewer D, C1 &
  C2)
- Discuss related work on multiverses/explainability/transparency in visual analytics (Reviewer B, C1)
- Incorporate discussion on Psallidas' work on database-based visualisation linking into 6.3 (Reviewer D, C3)
