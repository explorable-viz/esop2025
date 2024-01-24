## Abstract skeleton

ChatGPT input:

Write a 350-word abstract for a computer science paper, describing the following research

- Charts, figures and text curated by scientists and journalists from data play an important role in policy making and everyday decision-making.
- Making sense of these artefacts requires understanding how they relate to the data they were derived from. This can be difficult and time-consuming, because of the way data is transformed during the computational pipeline. Even for an expert with access the source code and data, reconstructing these relationships after the fact is difficult.
- In this paper we present a new program analysis framework based on dynamic dependence graphs, which allows interactive exploration of the fine-grained relationships between input data and visualisations or other output. Our main contributions are the formulation of a novel notion in data provenance which we call "related inputs", a characterisation inputs that are related because they contribute to a common feature of the output. We use Jonsson and Tarski's notion of conjugate operators on Boolean algebras to formalise this intuition and show that computing the conjugate of the "demands" operator for a dependence graph G is simply that operator on the opposite graph.
- We also show how our work generalises and extends existing techniques based on Galois connections which address the dual problem of relating parts of outputs when they compete for the same inputs.
