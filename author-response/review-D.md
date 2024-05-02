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
