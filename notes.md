## Abstract skeleton

### ChatGPT input:

Write a 350-word abstract for a computer science paper, describing the following research. Minimise the use of adjectives and write as directly as possible.

- Charts, figures and text curated by scientists and journalists from data play an important role in policy making and everyday decision-making.
- Making sense of these artefacts requires understanding how they relate to the data they were derived from. This can be difficult and time-consuming, because of the way data is transformed during the computational pipeline. Even for an expert with access the source code and data, reconstructing these relationships after the fact is difficult.
- In this paper we present a new program analysis framework based on dynamic dependence graphs, which allows interactive exploration of the fine-grained relationships between input data and visualisations or other output. Our main contributions are the formulation of a novel notion in data provenance which we call "related inputs", a relation of mutual relevance or "cognacy" between inputs that arises when they contribute to a common feature of the output. We use Jonsson and Tarski's notion of conjugate operators on Boolean algebras to formalise a self-conjugate related inputs operator and show it can be computed over a dependence graph as the image function for the graph's reachability relation R composed with its converse R^{-1}.
- The image function for the other composite R^{-1};R gives rise to a "related outputs" operator captures a cognacy relation between output features that compete for common inputs; we show how to recover a prior approach to this dual problem based on Galois connections and execution traces by composing the resulting operator with projections that admit conjugates. We show that our graphical approach not only generalises the prior work but is both faster and language agnostic, and can be implemented with a single procedure rather than requiring separate forward and backwards analyses over a trace. We present various non-trivial examples which show how visual outputs can be automatically enriched with interactions which support "related inputs" and similar queries, and also how projection operators can be used to factor out contributions by particular inputs or demand induced by particular outputs, to support contextualised, more informative queries.

### Next inputs to ChatGPT:

Rewrite but avoid adjectives wherever possible.

Replace phrases like “the paper presents” by “we present”.
