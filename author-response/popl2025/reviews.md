# Review #99A

## Overall merit
3. Weak accept

## Reviewer expertise
2. Some familiarity

## Paper summary
This paper presents language runtime that outputs a program dependence graph as a by-product of execution. The program dependence graph enables calculation of queries about what inputs influence an output and what outputs are influenced by an input. These queries can be composed as well. The method is implemented and evaluated on data visualization tasks.

## Comments for authors
Pros:
- Well motivated
- Implementation
- Evaluation

Cons:
- Bulk of paper focuses on standard theoretical trivia

The general approach of the paper to generate a PDG via an instrumented runtime makes a lot of sense because (1) expressing computation is easy for developers, (2) subsequent queries can be executed faster. This is demonstrated by the implementation and evaluation.

The definition of PDG and the forwards and backwards analysis problems on the graph all seem rather boilerplate to me. I am unable to give much credit for novelty here.

The most interesting aspect of the paper is exactly how the program runtime is instrumented to generate the PDG efficiently. Section 4 covers this material but I had a hard time understanding intuitively the graph construction from the formalization there. Part of the problem is that the language is fairly rich but we don't have full examples of programs in this rich language to show what the PDG generated from a sample execution looks like.  I would have liked to see more space devoted to explanation here using realistic examples.

# Review #99B

## Overall merit
3. Weak accept

## Reviewer expertise
3. Knowledgeable

## Paper summary
This work describes an approach for using dependence graph analysis, applied to data visualization programs, to offer end-user interactions around: (i) identifying what data influenced a given output visualization component, (ii) identifying what output visualization component was influenced by a given data point, (iii) identifying what data points are together influencing the same output components (bidirectional analysis, in comparison to i and ii doing single-direction), (iv) identifying what other output components are being influenced by the same input data points (again bidirectional).

## Comments for authors
This is a very well-organized paper with a compelling simplifying vision for the problem space.  I hope to see the work presented.  I have a few small concerns, but I think they can all be addressed with small paper text edits.

### Strengths

I appreciated the presentation.  The organization was lovely, the explanations very clear, and highlighting the intuitions at every stage made it an easy read.  I appreciated the concrete examples.

Finally, a quick note.  I anticipate that some may argue the technique is too simple to warrant inclusion.  To head that off, I want to say that if so, why don’t we see the earlier POPL work ([22]) doing the same?  Clearly there’s a benefit from framing the problem in this way and pointing out how dependence graph analyses apply in this space, and the benefits they confer.  Even if the techniques are simple once the appropriate mapping to existing formalisms are made, the work of making those appropriate mappings is very difficult.  I appreciated that the writeup did a good job of centering the core insight/mapping.

### Weaknesses

I felt the discussion of the relationship to prior work was surprisingly scant.  I would have appreciated a more complete picture of the relationship to the broader (outside of PL) landscape that connects with this work.  Especially since this work is aimed at a PL audience that will probably similarly lack that context, this farther-afield discussion feels pressing.  Here are a few of the areas that came to mind as offering points of connection, from my perspective as an outsider to the Databases and Viz communities: (1) the line of work on multiverse analyses, maybe especially the work on embedding multiverse analysis tools in papers (e.g., https://dl.acm.org/doi/10.1145/3290605.3300295 “Increasing the Transparency of Research Papers with Explorable Multiverse Analyses”) (2) The long line of provenance maintenance work in databases, (3) the same, but published in the Viz and design communities.  I’m sure there are other related spaces, but as an outsider these were the ones that came to mind.

E.g., take a look at Explaining Data in Visual Analytic Systems, Eugene Wu.

One other comment on the related work, although not nearly as pressing as the above–how would the authors describe the relationship to work from the ExcelLint line of work?  Clearly a very different set of techniques, and static rather than dynamic, and generally a quite different space, but I wonder if there are interesting connections to draw out.  It came to mind as another example of PL work aiming to offer end users insights into data and how data affect the outputs they’re seeing.  Might be an interesting discussion.

This last comment is really only a question of the writing.  The introduction and motivation leaned heavily on implicit and explicit programmability claims.  Given that the paper does not evaluate programmability/developer ease-of-use, I think the motivation and evaluation would align better if the motivation focused on what *was* evaluated–performance benefits relative to the state of the art trace-based approach.  In fact, I would repeat the same concern for claims about end-user usability as well.  (Especially in the scenarios presentation, there is a temptation to fall back on making unsupported claims about users rather than simply claims about what the tool can show.)

# Review #99C

## Overall merit
2. Weak reject

## Reviewer expertise
2. Some familiarity

## Paper summary
This paper introduces a language [OurLanguage], and a corresponding core calculus, that, during evaluation, produces a graph capturing the dependencies between inputs and outputs. Reachability queries on that graph can then be used to answer questions about what data was used to produce an output, what outputs depend on a given input, and more. The authors evaluate their approach on a set of benchmarks, showing that the running time of the algorithm improves on the state of the art.

## Comments for authors
This was an interesting paper to read. I thought the idea of computing dependencies via reachability makes perfect sense, and the performance improvements compared to the trace-based approach seem significant.

However, overall I did not come away from this paper convinced that it is ready for publication yet, for two reasons. First, a major component of the paper, casting graph dependencies using conjugate operators, really felt overly complicated on reading it. Aside from yielding a point of comparison to a poor implementation choice, I didn't get much out of this framing of the problem. I would have been entirely convinced by reading the (nice) semantics in Figs 10, 11, and 12, and then seeing some algorithmic pseudocode for graph reachability, completely skipping the conjugate stuff. Perhaps there is something I'm missing but, if so, it needs to be brought out far more in the writing.

Second, I have some fundamental confusion about the technique and the running example. Lines 479-480 emphasize that because x2=0 in the example, the value of x3 doesn't matter in computing part of the output. (I think this also comes up elsewhere but I didn't note the location.) However, line 951 seems to contradict this, saying the algorithm is not affected by changes in the semantics of the language, and the algorithm in Fig 5 seems to be a pure graph algorithm that does not pay attention to values and properties of operators. Hence I'm pretty confused about this difference. Is it as simple as the example being wrong or is there something I'm missing from the algorithm?

Additional comment:

* line 28, "deciding what groceries to buy" - I do not rely on anything created by scientists or journalists for my grocery shopping.

* line 70, "...that allow[s] a user...".

* Fig 2, CHN Bio has an output of 93.73, which is more than the capacity of 75.86. This is the only row where the output is greater than the capacity, so it seems strange. (Actually, I just spotted another one, petrolOut is more than petrolCap for DEU.)

* Section 1.1 feels like it's in the wrong place. I would recommend that the introduction have new text that expands on the bullets and roadmap in 1.2, and then 1.1 be moved to a new Overview section, or similar, right after the intro.

* line 642 and elsewhere, always put a comma after i.e., like this, and e.g., as well.

* Fig 5, it's okay but a bit surprising to see this written in natural deduction rules rather than algorithmic pseudocode.

* Tables 1-3, there's no need to show so many digits of precision for these numbers. Fewer significant figures would make the tables easier to read.

# Review #99D

## Overall merit
2. Weak reject

## Reviewer expertise
3. Knowledgeable

## Paper summary
This paper introduces the concept of backward and forward provenance tracing over a provenance graph, and how it can support backward and forward linking in interactive visualizations.   It models backward and forward queries as a pair of conjugate operators, and claims to develop a language-independent approach by developing a custom language.   The authors compare with a prior language based on Galois connections and show on visualizations of unknown complexity and over datasets of unknown schema and size that the new language is less slow.

The main claim in this paper appears to be: "here is a new approach that is able to express linked visualizations using provenance."

The major area where the paper can be improved is more carefully establishing its claims of novelty.  Specifically, relative to related work in the DB and Vis communities, to highlight the aspects of this paper that are necessary.   This is because prior work
1. supports generating provenance (dependency) graphs
2. supports brushing and linking over such a graph.
3. database systems are capable of querying graphs in many ways, with backward and forward tracing being a special case.

Perhaps, the definition of provenance in general programming languages is not well defined?  Or there is more performance to be gained?  Or this work expresses a richer set of visualizations or interactions that database approaches?   In either case, a deeper treatment of prior work would help.

### Provenance
There is substantial work in the database literature on supporting provenance, varying from Dietrich's logging based approach, Glavic's query rewrite approach, and Psallidas and Mohammed's instrumentation based approaches.  In all, the focus is on the expressiveness of the underlying queries that can be instrumented, the space and latency overhead of capture, and the latency of provenance query execution.    Benchmarks are typically over TPC-H or analytic benchmarks and at a scale of at least 1GB.

Since these works can generate provenance graphs, and most visualization applications are developed over SQL databases, I would expect a comparison with such systems.

### Visualization Linking and Provenance
This paper's introduction describes provenance-powered linking as a new concept, but it has been developed and studied in the database community, particularly with Psallidas' works [1-4].   It has also been established that most visualizations are developed and/or executed on top of database systems, which is why collecting provenance at this layer is pragmatic.

[1] Provenance in Interactive Visualizations.  HILDA18
[2] Demonstration of Smoke: A Deep Breath of Data-Intensive Lineage Applications.  SIGMOD Demo 18
[3] Smoke: Fine-grained Lineage at Interactive Speeds.  VLDB 18
[4] Combining Design and Performance in a Data Visualization Management System.  CIDR17
