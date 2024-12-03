ESOP'25 Paper #89 Reviews and Comments
===========================================================================
Paper #89 Conjugate Operators for Transparent, Explorable Research Outputs


Review #89A
===========================================================================

Overall merit
-------------
4. Accept

Reviewer expertise
------------------
3. Knowledgeable

Paper summary
-------------
The paper presents a general-purpose approach for "transparent visualizations". Technically the program
generating the data is run to produce a heap augmented with dependency edges. This induces a lattice over the
powerset of heap locations which can be traversed to answer / expose visualization questions.

Comments for authors
--------------------
Not being an expert, I found the paper quite creative, novel, and technically interesting. It is remarkable
that fairly standard PL techniques can produce such an elegant system for transparent visualizations.

There is a gap in my understanding that I hope the authors can clarify. My understanding is that the
underlying program is run once to generate the heap / graph, and then further queries traverse the graph. So
is the graph stored in memory with as many entry points as there are locations? There is never any
re-execution of the program to re-generate parts of the graph on demand, right?

A smaller technical question: it seems that one can make the semantics look even more conventional by using a
store semantics. May be even use a state monad to separate the standard use of locations from the novel
fragments of the implementation.



Review #89B
===========================================================================

Overall merit
-------------
4. Accept

Reviewer expertise
------------------
2. Some familiarity

Paper summary
-------------
A pressing problem in data journalism is linking data visualisations to their
source data: the current status quo requires, in essence, users to take any
visualisations on trust, with little understanding of the provenance of the
source data.

This paper introduces a programming language that tracks data dependencies using
a dynamic dependency graph, which allows powerful provenance queries without
needing trace-based approaches.  The core language is strikingly close to a
regular functional programming language (which is a huge positive, given that
users do not need to program in adjust their programming style to benefit from
the language): a lambda calculus with records, constructions, and an
environment-based big-step operational semantics. The interesting features are a
trie-based pattern matching semantics and runtime name generation for values,
allowing data dependencies to be tracked in a dependency graph.

The dependency graph can then be used for so-called 'cognacy queries':
specifically, calculating related inputs based on common ancestors in a
dependency graph; these are used to describe (declaratively) demands and
demanded-by operations. The paper then shows how to (algorithmically) implement
the operations and proves correctness.

The language is implemented and evaluated against a trace-based approach on a
series of benchmarks, with results compared against Nielsen's guidelines for
performance.

Comments for authors
--------------------
# Evaluation

## Pros

  * Interesting and important problem domain
  * Very well-rounded paper with theory, practice, and implementation

## Cons
  * Writing could be tightened up in places
  * Some room for improvement on performance; no discussion of potential
    optimisations.
  * Unclear how well the approach scales based on size of dataset


## Overall
For context: I'm not an expert, but bid for this paper because I thought it
would be interesting -- so hopefully this review helps from an 'interested
non-specialist' perspective.

Overall I really enjoyed the paper. The problem domain is important, the key
ideas and formalisms are neat, and there is an implementation and evaluation. I
was particularly impressed with the language design (and the code snippet used
in the paper) -- it really is quite remarkable that all of this is possible
without forcing the user to write code awkwardly (the given code basically looks
like stock OCaml). The formalism is tidy, and I could follow the technical
development.

My only quibble really was about performance: playing around myself with the
anonymised version, there were some notable delays. I wonder whether you have
thought of any potential optimisations that could be done? I also wonder how
well the language / approach scales with program and data size.

There were also a few places the writing could be tightened up slightly; see
details below.


# Details

  * p1:
    - Note that the title on the paper is different to that in HotCRP
    - The abstract seems very long and quite technical at points. It would be
      helpful to trim this
  * p5 "emfissions" --> "emissions"
  * o6 "nuclearOut" would be better in \texttt{}
  * p9 I wonder whether there's a better name for "continuation" (as this
    immediately got me thinking about abstract machines
  * p12 I've never seen a big-step judgement with $\Rightarrow$ before! Maybe
    $\Downarrow$ would be better.
  * p13 I think it would be much better to have a much smaller example written
    in your core calculus, and then do the full graph for that, rather than an
    excerpt of a bigger graph (this will help readers more crisply understand
    the semantics)
  * p15 I found the Galois connection discussion a bit out of place, and a lot
    of technical details weren't motivated. I'd recommend putting the full
    comparison with Galois connections in an appendix, which would free up space
    to better motivate some of the definitions.
  * p17 I think the algorithmic definition of defBy might be much easier to read
    if done using pseudocode.



Review #89C
===========================================================================

Overall merit
-------------
4. Accept

Reviewer expertise
------------------
1. No familiarity

Paper summary
-------------
The paper introduces a new program analysis framework that uses dynamic dependence graphs to explore
fine-grained input-output relationships, using the concept of “cognacy” to identify linked inputs and outputs.
The approach supports interactive provenance queries, enabling transparent interactive visualisations.
Benchmarking compares graph-based approach favourably to trace-based in a single implementation using a small
selection of short programs. The graph-based approach’s performance is attributed to efficient graph traversal
and avoidance of expensive join operations.

Comments for authors
--------------------
# Strengths

+ A very worthy aim for this strand of work

+ Thoroughly executed work: theory, implementation, benchmarking, online demo

+ Well-written paper


# Discussion

I enjoyed this paper a lot and I am impressed that it manages to cover a lot of different forms of
contributions in relatively tight space. Implementing a programming language to address this problem instead
of developing a library for a more well-known language such as Python is an interesting choice. Then again, I
regularly meet people who implement their own Smalltalk’s so they can keep programming in their favourite
language, and so it is not so surprising that at ESOP, new functional languages are developed motivated by
needs such as in this paper.

I found the demo at https://opencomputation.org/ almost unusable because it was so slow (on a modern laptop;
Fig 4 worked much faster than Fig 2 for some reason — and presumably this is a JavaScript issue). Maybe I was
using the wrong browser. I did not get the arrows pointing from the figure to the data. Maybe they were only
part of the figures in the paper? If so that would have been good to state (or I missed this). However, it was
a cool demo, and I clearly see the value of being able to generate this interactive artefact automatically. As
a tool note, unrelated to the topic of the paper, it would be very cool to also reveal the source code that
generates the figures and allow it to be edited. Manipulating something and see the effects always helps me
understand and gain confidence in correctness.

The definition of the language was well-written but I thought that the syntax, names and abbreviations could
be improved. They are optimised for writing and fitting things on one line rather than for communicating
clearly with a reader. I could not follow most of §4 so I have a hard time understanding some of the novelty
claims.

I am missing a discussion about possible limitations of this approach. Does the dependency graph approach
”fall over” at some point, or require any specific co-design with programming language constructs?

I was very happy to see an implementation and an actual practical evaluation. EXCELLENT. I think the benchmark
questions are well-chosen. Thank you also for clearly stating your hypothesis. Comparing two implementations
of the dependency-tracking runtime where all system components are shared by the two implementations, and the
only differences are the algorithms of interest is also very good. This seems to be a real apples to apples
comparison.

The benchmarks are run 10 times each, but I don’t find any analysis or even argument for this number. We also
don't know much of the implementation of this language, making it harder to evaluate the results — do we need
warm-up for example? (I assume not.)

The row for edge-detect in Table 2 seems to be broken. I suspect the T-Demands cell has lost a digit.

It is clear from the benchmarks that graph construction has clear performance advantages over trace-based
approaches, at least in this implementation. I was a little annoyed by using the most permissive ”SLA” for the
results in Table 1 where graph-based is always slower and highlighting how both implementations always fit in
this category whereas in Table 2 where graph-based is always faster, we talk about instantaneous. While this
is all correct, it felt slightly fishy.

I appreciated the discussion and analysis of the underlying reason for the performance results and it seems
believable to me.


# Minor

Page 8 §3 ”We write to x denote” (word order)
