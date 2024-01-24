## Abstract skeleton

### ChatGPT input:

Write a 350-word abstract for a computer science paper, describing the following research.

- Charts, figures and text curated by scientists and journalists from data play an important role in policy making and everyday decision-making.
- Making sense of these artefacts requires understanding how they relate to the data they were derived from. Even for an expert with access the source code and data, reconstructing these relationships after the fact is difficult because of the way data is transformed and manipulated during the computational pipeline.
- In this paper we present a new program analysis framework based on dynamic dependence graphs, which allows interactive exploration of the fine-grained relationships between input data and visualisations or other output. We formulate a novel notion in data provenance which we call "related inputs", a relation of mutual relevance or "cognacy" between inputs that arises when they contribute to a common feature of the output. We use Jonsson and Tarski's notion of conjugate operators on Boolean algebras to formalise a "related inputs" operator and show it can be computed over a dependence graph as the image function for $R^{-1};\relComp R$, where $R$ is the reachability relation for the graph.
- The image function for the other composite $R^{-1};R gives rise to a "related outputs" operator captures a dual cognacy relation between output features that compete for common input data. We show how composing this operator with projections recovers a prior approach the dual problem based on Galois connections and execution traces. The graphical approach is also faster on similar problems and moreover is language agnostic and can be implemented with a single procedure rather than requiring separate forward and backwards analyses. We present various examples which show how visual outputs can be automatically enriched with interactions which support "related inputs" and similar queries, and also how to use projection operators to factor out contributions by particular inputs or demand induced by particular outputs, providing contextualised, more informative queries.

### Next inputs to ChatGPT:

Rewrite but avoid adjectives wherever possible.

Replace phrases like “the paper presents” by “we present”.
