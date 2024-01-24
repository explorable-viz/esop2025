## Abstract skeleton

### ChatGPT input:

Write a 350-word abstract for a computer science paper, describing the following research. Minimise the use of adjectives and write as directly as possible.

- Charts, figures and text curated by scientists and journalists from data play an important role in policy making and everyday decision-making.
- Making sense of these artefacts requires understanding how they relate to the data they were derived from. This can be difficult and time-consuming, because of the way data is transformed during the computational pipeline. Even for an expert with access the source code and data, reconstructing these relationships after the fact is difficult.
- In this paper we present a new program analysis framework based on dynamic dependence graphs, which allows interactive exploration of the fine-grained relationships between input data and visualisations or other output. Our main contributions are the formulation of a novel notion in data provenance which we call "related inputs", a relation of mutual relevance or "cognacy" between inputs that arises when they contribute to a common feature of the output. We use Jonsson and Tarski's notion of conjugate operators on Boolean algebras to formalise related inputs and show it can be computed over a dependence graph G by composing the image function for the reachability relation in G with the same function in G^{\op}.
- We also show how our work generalises and extends existing work based on Galois connections and execution traces which addressed the dual problem of relating parts of outputs when they compete for the same inputs. Our approach language agnostic, more performant, and can be implemented with a single procedure rather than requiring separate forward and backwards analyses over a trace.

#### Still to include/clarify

- Projection operators for focused queries

### Next inputs to ChatGPT:

Rewrite but avoid adjectives wherever possible.

Replace phrases like “the paper presents” by “we present”.
