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
