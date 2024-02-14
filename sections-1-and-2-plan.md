# 1. Introduction: Towards Transparent Research Outputs

- [ ] Whether formulating a national policy or [..], we increasingly rely on [..] created by scientists and journalists. Interpreting these visual and textual summaries is essential to making informed decisions.
- [ ] Unfortunately such artefacts are \emph{opaque}: they are unable to reveal anything about how they relate to the data they were derived from.
- [ ] While one could try to use the source code and data sources to answer some of these questions, this requires substantial expertise and time spent offline from the “comprehension context” in which the questions originally arose.
- [ ] Even a reviewer of a scientific paper may lack the resources or inclination to do this and perhaps more often than we would like we have to take things on trust.
- [ ] These difficulties are only compounded when the information presented draws on multiple data sources, such as [...]

## Paragraph

- [ ] With traditional print media there is not much we can do about this ``disconnect'' between outputs like chart and figures and the underlying data, but for digital media, other options are open to us.
- [ ] One way to address this problem is to engineer visual artefacts to be more ``self-explanatory'', i.e. able to reveal to an interested reader the relationship to underlying data
- [ ] Consider the histogram in Fig. 1, which shows urban population growth in Asia from [..], ignoring for a moment the pop-up showing information about Chiang Mai. Given just the histogram, there are many questions a reader might have about what the chart “represents” – how visual elements map to underlying data. What are the individual points, what does the colour scheme indicate, do individual points represents large cities or small cities, etc.
- [ ] These uncertainties do not necessarily reflect a problem with the visualisation; any summary must inevitably emphasis aggregate information at the expense of detail
- [ ] What Bremer did was add interactions to her chart to allows the user to explore some of these questions themselves _in situ_, i.e. without leaving the context of the chart

## Automated data transparency
- [ ] However, coding up visualisations like Bremer's is laborious and requires the author to anticipate the kind of queries the user might have. Things don't naturally generalise: for example Bremer's visualisation doesn't allow the user to select more than one of the circles at once.
- [ ] Recently, there has been interest in treating this as programming language infrastructure problem: baking data dependency information directly into outputs, so that these sorts of queries can be supported automatically.
- [ ] The promise of this approach is that the user can have the best of both worlds: the high-level overview provided by the visual summary, plus "incremental discoverability" of as much detail as they want about the underlying data, only about the parts they care about, with some kind of formal guarantee that the revealed data is "minimal" and "sufficient".
- [ ] Psallidas et al identified some connections between key concepts in data visualisation such as selection of visual elements, and data provenance; Perera et al implemented something resembling this idea using dependency tracking (▽) to link specific output selections to input selections. Here the formal guarantee that input selections are ``correct'' w.r.t. output selections is captured by a forward analysis (▲) called ``suffices for'' adjoint to ``demand``: if a set of outputs Y demands a set of inputs X, then X is the smallest set of inputs which suffices for Y.

- [ ] We call this broad idea of [..] _data transparency_, and illustrate this using our implementation in Fig 2.
- [ ] Consider the two charts at the top of the figure. As with the histogram, there are many questions even an expert reader might have about what these charts are showing. For example when it comes to renewable energy, there is an important distinction between _capacity_ and _output_. Which of these is being shown in the bar chart? What kinds of energy count as "non-renewable"? For the scatter plot, the label on the x-axis suggests that it represents some kind of part-to-whole ratio (renewables to total energy capacity, perhaps), whereas the y-axis purports to represent the ``capacity factor'' of clean energy sources. But these labels are really just informal commentary, and many questions remain. Moreover there are _two_ outputs here and so the question of how they might be related also arises.
- [ ] In a system with automated data transparency, the user can investigate questions like these in open-ended ways by selecting arbitrary parts of the output to obtain a view of the relevant data. Here the bar segments highlighted with a dark border represent such an output selection […] The table underneath shows the demanded data (▽) and also we are able to automatically select any outputs in the other chart which demand the same data (△). The main contribution of Perera et al was to show that △ can be computed using the De Morgan dual of the ``suffices for'' operator ▲, which here we call ``demanded by``.
- [ ] Although it falls short of providing a full explanation […] this does significantly improve on the current state of affairs. Queries do not have to be anticipated in advance by the author of the visualisation. The infrastructure providing them can be validated once for a given language rather than implemented on an ad hoc basis for each application. While several visualisation libraries support related outputs, these are ad hoc and not transparent. In future work we discuss extending this ``extensional'' notion of transparency to a more explanatory ``intensional'' information.

## Contributions

- [ ] In this paper, we develop the idea of data transparency in two new directions. First we approach the problem in a language-independent way, using _dependence graphs_ […]. This separates the problem of defining queries over the graph from the problem of generating a dependence graph for a particular program. Dependence graphs are a form of execution record that has been used extensively for program slicing (mainly of imperative programs~\cite{ferrante87}), but have not yet been applied to data transparency [which operates under slightly different assumptions?]. In particular, previous approaches based on traces (e.g. Ricciotti et al) have involved defining a “reverse interpreter” that folds a trace back into a program slice, whereas with a graph […] This partitioning both reduces the implementation burden and improves performance compared to approaches based on reverse interpretation over a trace.

- [ ] Second, we introduce a new kind of provenance query called _related inputs_, which allows a user to explore relations of cognacy (common ancestry) in the graph […]. In the graphical setting this is an easy thing to compute, since it amounts to reachability in $G$ composed with reachability in the opposite graph.

- [ ] Section 2 presents an overview of our approach and language, and motivates the idea of ``related inputs'' query from an end-user perspective. Our specific contributions are then as follows: [..]

  - [ ] We define a new program analysis framework over dynamic dependence graphs (Section 3), introducing the cognacy operator $\relInput$ (``related inputs'') and unpacking the intuitive relationship between its two components $\demandR$ (``demands'') and $\demandByR$ (``demanded by'') in terms of \citeauthor{jonsson51}'s notion of conjugate operators over Boolean algebras. We also introduce the dual cognacy operator $\relOutput$ (``related outputs'') and explain the relationship to Galois connections: $f$ and $g$ being conjugate
  is equivalent to $f$ and the De Morgan dual of $g$ forming a Galois connection. We give procedures for
  computing $\demandR_{D}$ and $\demandByR_{D}$ over a directed graph with reachability relation $D$
  - [ ] We define a core functional language with an operational semantics that pairs every result with a
   dynamic dependence graph suitable for computing $\demandR$ and $\demandByR$ (\secref{core}). We show how to represent (parts of) values as nodes in the graph.
  - [ ] We compare the performance of our implementation based on graphs and conjugates with an implementation
due to \citet{perera22} based on traces and Galois connections, contrasting the overhead of building trace
vs.~building dependence graphs, computing $\demandR$ and $\demandByR$ over each, and the relative implementation burden of the two approaches (\secref{evaluation}).

# 2. Overview of approach and solution

- [ ] So goal of data transparency is to enrich the computed content with interactions that allow the user to
query relationships between data sources and visualisations and other outputs \emph{in situ}, i.e. without
leaving the ``comprehension context'' in which their query arose. Crucially, we want to make this feature
automatic. Hand-crafted efforts like Bremers are not only labour-intensive, but involve manually embedding
knowledge of the relationship between visual outputs and inputs --- information that is usually implicit in
how the former is computed from the latter --- into the same program, rendering it potentially invalid every
time the visualisation logic changes. By putting this into a programming language instead, the author of the
visualisation can concern themselves purely with communication and visualisation, and defer responsibility for
transparency features to the infrastructure used to implement and host the visualisation.
- [ ] However, computing bidirectional dependency information that [..] is challenging both performance-wise and in terms of implementation burden. For example, the approach taken by Perera et al to implement features similar to the ones shown in Fig 2. require two separate analyses: a backwards analysis to determine data needed by an output selection, and then a forwards analysis whose De Morgan dual determines any parts of the other chart that also need any of that data. Although extensionally each determines the other, these analyses are defined separately and each depends on details of the language, imposing a significant burden on the implementor. Moreover each runs over an execution record or trace of the entire computation, [..]

# 2. Conjugate operators over dependence graphs

- [ ] Our insight in this paper is that dependence graphs provide an alternative approach to data transparency that is more language-independent and [...] Moreover, certain problems are much easier to formulate in the graphical setting. For example the ``related outputs'' operator illustrated in Fig 2. amounts to computing _cognacy_ (common ancestry) in the graph, which in turn simply amounts to computing backwards reachability in G and composing that with backwards reachability in G^{\op} (or equivalently, reachability in G^{\op} composed with reachability in G) (△▽). While retaining a forwards sufficiency analysis is useful for performance reasons, it can be defined in a language-agnostic way and is technically redundant.
- [ ] Our second contribution is that the graphical setting makes it straightforward to compose reachability in G and its opposite the other way around, producing another provenance query called _related inputs_ (▽△) which allows the user to query the input elements that are ``cognate'' in G^{\op} to some inputs of interest.
- [ ] Related inputs characterises the relation of \emph{mutual relevance} which arises between two input elements when they contribute to a common output element (by element we mean some part of the input or output data). Users are able to ask questions of the form ``What outputs use this data element, and what other data element are used along with it?''
- [ ] The easy symmetry of these two operations over G are interesting because △ is the De Morgan dual of ▲, the adjoint of ▽. This is actually a very simple notion arising as the image and preimage of the reachability relation of G; for functions, the image and preimage are adjoint, but for general relations they are _conjugate_.
- [ ] Fig 2 illustrates related inputs, again using images from our implementation. [..]

Our key insight is that two inputs are related in this sense if they are \emph{cognate}, i.e.~have a common
ancestor in the program's dependence graph $G$. This leads to a formalisation of related inputs in terms of
the composite relation $R^{-1} \relcomp R$ where $R$ is reachability in $G$, and we give a procedure for
computing related inputs over $G$. The concept of ``conjugate'' operators~\cite{jonsson51}, functions between
Boolean algebras which come in reciprocating pairs, turns out to nicely capture these relations of cognacy.
