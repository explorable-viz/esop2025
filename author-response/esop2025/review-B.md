Review #89B
Overall merit

4. Accept
Reviewer expertise

2. Some familiarity
Paper summary

A pressing problem in data journalism is linking data visualisations to their source data: the current status quo requires, in essence, users to take any visualisations on trust, with little understanding of the provenance of the source data.

This paper introduces a programming language that tracks data dependencies using a dynamic dependency graph, which allows powerful provenance queries without needing trace-based approaches.  The core language is strikingly close to a regular functional programming language (which is a huge positive, given that users do not need to program in adjust their programming style to benefit from the language): a lambda calculus with records, constructions, and an environment-based big-step operational semantics. The interesting features are a trie-based pattern matching semantics and runtime name generation for values, allowing data dependencies to be tracked in a dependency graph.

The dependency graph can then be used for so-called 'cognacy queries': specifically, calculating related inputs based on common ancestors in a dependency graph; these are used to describe (declaratively) demands and demanded-by operations. The paper then shows how to (algorithmically) implement the operations and proves correctness.

The language is implemented and evaluated against a trace-based approach on a series of benchmarks, with results compared against Nielsen's guidelines for performance.
Comments for authors

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
For context: I'm not an expert, but bid for this paper because I thought it would be interesting -- so hopefully this review helps from an 'interested non-specialist' perspective.

Overall I really enjoyed the paper. The problem domain is important, the key ideas and formalisms are neat, and there is an implementation and evaluation. I was particularly impressed with the language design (and the code snippet used in the paper) -- it really is quite remarkable that all of this is possible without forcing the user to write code awkwardly (the given code basically looks like stock OCaml). The formalism is tidy, and I could follow the technical development.

My only quibble really was about performance: playing around myself with the anonymised version, there were some notable delays. I wonder whether you have thought of any potential optimisations that could be done? I also wonder how well the language / approach scales with program and data size.

There were also a few places the writing could be tightened up slightly; see details below.

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
