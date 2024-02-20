# 1. Introduction: Towards Transparent Research Outputs

## Automated data transparency

- [ ] We call this broad idea of [..] _data transparency_, and illustrate this in Fig 2 using our implementation, which builds on the ideas of Psallidas et al and Perera et al.
- [ ] Consider the two charts at the top of the figure. As with the histogram, there are many questions even a domain expert might have about these charts. For example, in renewable energy one must be careful not to confuse _capacity_ with _output_ -- which of these is being shown in the bar chart? What kinds of energy count as "non-renewable"? In the scatter plot, the label on the x-axis suggests that it represents some kind of part-to-whole ratio (renewables to total energy capacity, perhaps), whereas the y-axis purports to represent the ``capacity factor'' of clean energy sources. But these labels are little more than informal commentary. Moreover there are _two_ outputs here and so the question of if and how they might be related also arises.
- [ ] A system with automated data transparency allows the user to investigate questions like these by interacting directly with the artefacts. By selecting an interesting part of the output, they can obtain a view of the relevant data. On the left the bar segments highlighted with a dark border indicate such a selection; the table underneath shows the demanded data (computed using our version of the ▽ operator) and we are also able to automatically select any outputs in the other chart which demand any of the same data using an other operator △ (``demanded by''). The overlapping demand, which we call the \emph{mediating input}, is highlighted in  [...] Perera et al defined such an △ operator as the De Morgan dual of the ``suffices for'' operator ▲; one of our contributions (as we shall see in \secref{} below) is to show that △ can be computed in a more direct fashion using dependence graphs.

## Contributions

- [ ] In this paper, we develop the idea of data transparency in two new directions. First we approach the problem in a more language-independent way, using _dynamic dependence graphs_. This separates the problem of defining queries over the I/O dependencies for a particular program, from the problem of generating a dependence graph for that program. Dependence graphs are a proven technique: they have been used extensively for program slicing (mainly of imperative programs~\cite{ferrante87}), but have not yet been applied to data analyses based on adjoint pairs of operators (such as ▽ and ▲). These approaches (e.g. Ricciotti et al) have to date involved defining a “bidirectional interpreter” that builds an execution record in the form of a \emph{trace} during the forwards analysis, folding that trace back into a program slice during the backwards analysis. This method is quite inefficient and non-trivial to prove correct; a graph-based implementation factors the problem into a (language-specific) graph-building interpreter plus (language-agnostic) adjoint analyses over the graph. This partitioning reduces the implementation burden and improves performance compared to approaches based on bidirectional interpretation.

- [ ] Second, we introduce a new kind of provenance query called _related inputs_, a relation of mutual relevance which arises between inputs when they contribute to common features of the output. Queries of this form allow readers to ask questions like ``What outputs use this data element, and what other data elements are used along with it?''. Such questions explore \emph{cognacy} (common ancestry) in a dependence graph $G$, and are formally dual to the ``related outputs'' feature shown in Fig.1 inasmuch as it can be understood as cognacy in $G^{\op}$. In the graphical setting these are both easy to compute, since they amount to the two ways of composing reachability in $G$ with reachability in its opposite.

- [ ] Section 2 presents an overview of our approach and language, and motivates the idea of ``related inputs'' query from an end-user perspective. The rest of the paper is then organised as follows: [..]

  - [ ] Section 3 defines a new program analysis framework over dynamic dependence graphs, introducing the cognacy operator $\relInput$ (``related inputs'') and unpacking the intuitive relationship between its two components $\demandR$ (``demands'') and $\demandByR$ (``demanded by'') in terms of \citeauthor{jonsson51}'s notion of conjugate operators over Boolean algebras. We also introduce the dual cognacy operator $\relOutput$ (``related outputs'') and explain the relationship to Galois connections: $f$ and $g$ being conjugate
  is equivalent to $f$ and the De Morgan dual of $g$ forming a Galois connection. We give procedures for
  computing $\demandR_{D}$ and $\demandByR_{D}$ over a directed graph with reachability relation $D$
  - [ ] \secref{core} defines a core functional language with an operational semantics that pairs every result with a
  dynamic dependence graph suitable for computing $\demandR$ and $\demandByR$. We show how to represent (parts of) values as nodes in the graph.
  - [ ] \secref{evaluation} compares the performance of our implementation based on graphs and conjugates with an implementation due to \citet{perera22} based on traces and Galois connections, contrasting the overhead of building trace   vs.~building dependence graphs, computing $\demandR$ and $\demandByR$ over each, and the relative implementation burden of the two approaches ().
  - [ ] Section 6 reviews related work in more detail, including program slicing and DDGs.

- [ ] Section 7 wraps up with a discussion of some limitations and plans for future work. In particular, the sort of transparency infrastructure proposed in this paper is purely extensional and falls short of providing full explanations of how output parts are related to input parts. We discuss extending this to more ``intensional'' forms transparency and propose some other ways of improving on the present system.

# 2. Overview of approach and solution

- [ ] As outlined in \secref{intro}, the aim of data transparency is to enrich the computed content with
interactions that allow the user to query relationships between data sources and visualisations and other
outputs \emph{in situ}, i.e. within the ``comprehension context'' in which these sorts of questions naturally
arise. Crucially, we want to make this feature automatic. Hand-crafted efforts like Bremers are not only
labour-intensive, but involve manually embedding metadata about the relationship between visual outputs and
inputs into the same program. The validity of this metadata is fragile: whenever the visualisation or data
analysis logic changes, the relationships between inputs and outputs also change. By shifting the
responsibility for gathering this information into the programming language, the author or data scientist can
concern themselves purely with analysis and visualisation, and defer responsibility for transparency
features to the infrastructure used to implement and host the visualisation.
- [ ] However, computing the bidirectional dependency information need to realise this idea is costly both in
terms of performance and implementation burden. For example, the approach taken by Perera et al to implement
the ``related outputs'' analysis required to implement a feature similar to the one shown in Fig 2. requires
two separate analyses: a backwards ``demands'' analysis to determine data needed by an output selection, and a
forwards ``suffices for'' analysis whose De Morgan dual determines any parts of the other chart that also need
any of that data. These analyses need to be defined separately and each depends on details of the language,
imposing a significant burden on the implementor. Moreover each runs over an execution record or trace of the
entire computation regardless of whether all of the trace is relevant.

## 2.1 Conjugate operators over dependence graphs

- [ ] Our insight in this paper is that dependence graphs provide an alternative, more language-agnostic
foundation for data transparency that both improves performance and reduces the implementation burden.
Moreover, certain problems are much easier to formulate in the graphical setting. For example ``related
outputs'' simply amounts to computing common ancestry, or _cognacy_, in G^{\op}, which turns out to be nicely
captured by the concept of ``conjugate'' operators~\cite{jonsson51} between Boolean algebras.
- [ ] Definition: f and g are _conjugate_ := f(X) \cap Y \neq \emptyset \iff X \cap g(Y) \neq \emptyset
- [ ] The canonical example of a conjugate pair are the image functions for a relation R \subset X \times Y
and its converse R^{-1}: if the image in R^{-1} of Y' \subseteq Y has at least one element in common with X'
\subset X, then the image in R of X' has at least one element in common with Y' (and vice versa). Conjugate
pairs are also closely related to Galois connections; if $f$ and $g$ are conjugate, then $f$ and the De Morgan
dual of $g$ form a Galois connection.
- [ ] If we now take R to be reachability in G, then our setting technically only requires a single operator
▽_R, since its adjoint ▲_R is readily computed as ▽_R^{-1} and its conjugate △_R as the De Morgan dual of
▽_{R^{-1}}. In particular related outputs is simply ▽_{R;R^{-1}}. It is well-known that extensionally these
things determine each other, but in the graph setting we can also derive efficient procedures for all of these
in terms of reachability. Since going via the De Morgan dual can be inefficient, we also give a direct implementation of ▲_G which improves on the derived version in those cases.

## 2.2 Related inputs

- [ ] Our second insight is that the graphical setting makes it straightforward to compose reachability in G and its opposite the other way around, producing another provenance query called _related inputs_ (▽△). Fig 2 illustrates related inputs, again using our implementation. Here the user starts from one of the input data sets, expressing interest in the bioenergy capacity of China for 2018 by moving their mouse over the appropriate cell in the table (\figref{related-inputs-main} step 1, green selection). The system generates two further selections in response. First, any scatter plot elements that demand the selected input are given a similar green highlight; here just one point is highlighted, and in fact only the $y$ coordinate of that point (step 2, tooltip).
- [ ] We call this output selection the \emph{mediating output} because of its role in establishing a
connection between otherwise unrelated inputs. Finally, any other inputs demanded by the mediating output
(that were needed to compute the $y$ coordinate of that point) are highlighted in grey (steps 3a and 3b).
(They grey is used to visually distinguish the \emph{answer} to the query from the selection that initiated
the query in the first place.)
- [ ] The result of a related inputs query can be thought of as a unit of comprehension or unit of reuse. It
picks out all the relevant data needed to understand or make use of the original selected input, and it does
so in a way that identifies the common output elements that explain why the inputs are related. Sometimes a
single input is used in many different outputs, or different features of a single output, in which case the
query result can be quite noisy (because lots of inputs turn out to be related); in \secref{} we also show how
selectively projecting away irrelevant parts of the mediating output can refine the query and produce a more
precise answer. (The same approach can be used to discard irrelevant mediating inputs in a related outputs
query to obtain more precise results.)

## 2.3 \OurLang: A Data-Transparent Programming Language

- [ ] We implement the abstract framework outlined above in a programming language called \OurLang, which [...].
- [ ] Example of scatter plot from Fig. 2
- [ ] Key point is that the author of the visualisation just expresses their output as a pure function of the inputs -- all the transparency features come for free. We provide a d3.js front end and a set of data types for common visualisations, and then enrich the d3.js renderings of the outputs with (a) selection information, and (b) additional interactions that [...]
- [ ] In the rest of the paper, we set out the formal graph framework (\secref{conjugate}), show how our Fluid interpreter implements the graph framework (\secref{core}) and then [performance] (\secref{evaluation}). Our implementation is open source and available at [...], which also has several interactive demos.
