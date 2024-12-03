Review #89C
Overall merit

4. Accept
Reviewer expertise

1. No familiarity
Paper summary

The paper introduces a new program analysis framework that uses dynamic dependence graphs to explore fine-grained input-output relationships, using the concept of “cognacy” to identify linked inputs and outputs. The approach supports interactive provenance queries, enabling transparent interactive visualisations. Benchmarking compares graph-based approach favourably to trace-based in a single implementation using a small selection of short programs. The graph-based approach’s performance is attributed to efficient graph traversal and avoidance of expensive join operations.
Comments for authors

# Strengths

+ A very worthy aim for this strand of work

+ Thoroughly executed work: theory, implementation, benchmarking, online demo 

+ Well-written paper

# Discussion

I enjoyed this paper a lot and I am impressed that it manages to cover a lot of different forms of contributions in relatively tight space. Implementing a programming language to address this problem instead of developing a library for a more well-known language such as Python is an interesting choice. Then again, I regularly meet people who implement their own Smalltalk’s so they can keep programming in their favourite language, and so it is not so surprising that at ESOP, new functional languages are developed motivated by needs such as in this paper. 

I found the demo at https://opencomputation.org/ almost unusable because it was so slow (on a modern laptop; Fig 4 worked much faster than Fig 2 for some reason — and presumably this is a JavaScript issue). Maybe I was using the wrong browser. I did not get the arrows pointing from the figure to the data. Maybe they were only part of the figures in the paper? If so that would have been good to state (or I missed this). However, it was a cool demo, and I clearly see the value of being able to generate this interactive artefact automatically. As a tool note, unrelated to the topic of the paper, it would be very cool to also reveal the source code that generates the figures and allow it to be edited. Manipulating something and see the effects always helps me understand and gain confidence in correctness. 

The definition of the language was well-written but I thought that the syntax, names and abbreviations could be improved. They are optimised for writing and fitting things on one line rather than for communicating clearly with a reader. I could not follow most of §4 so I have a hard time understanding some of the novelty claims. 

I am missing a discussion about possible limitations of this approach. Does the dependency graph approach ”fall over” at some point, or require any specific co-design with programming language constructs?

I was very happy to see an implementation and an actual practical evaluation. EXCELLENT. I think the benchmark questions are well-chosen. Thank you also for clearly stating your hypothesis. Comparing two implementations of the dependency-tracking runtime where all system components are shared by the two implementations, and the only differences are the algorithms of interest is also very good. This seems to be a real apples to apples comparison. 

The benchmarks are run 10 times each, but I don’t find any analysis or even argument for this number. We also don't know much of the implementation of this language, making it harder to evaluate the results — do we need warm-up for example? (I assume not.)

The row for edge-detect in Table 2 seems to be broken. I suspect the T-Demands cell has lost a digit. 

It is clear from the benchmarks that graph construction has clear performance advantages over trace-based approaches, at least in this implementation. I was a little annoyed by using the most permissive ”SLA” for the results in Table 1 where graph-based is always slower and highlighting how both implementations always fit in this category whereas in Table 2 where graph-based is always faster, we talk about instantaneous. While this is all correct, it felt slightly fishy. 

I appreciated the discussion and analysis of the underlying reason for the performance results and it seems believable to me. 

# Minor

Page 8 §3 ”We write to x denote” (word order)
