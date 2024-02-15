# 1. Introduction: Towards Transparent Research Outputs

- [ ] Whether formulating a national policy or [..], we increasingly rely on [..] created by scientists and journalists. Interpreting these visual and textual summaries is essential to making informed decisions.
- [ ] However, for the most part such artefacts are \emph{opaque}: unable to reveal anything about how they relate to the data they were derived from.
- [ ] While one could try to use the source code and data sources to reverse engineer some of these relationships, this requires substantial expertise, as well as valuable time spent away from the “comprehension context” in which we encountered the artefact.
- [ ] These difficulties are only compounded when the information presented draws on multiple data sources, such as [...]
- [ ] Even professional reviewers may lack the resources or inclination to get too involved. Perhaps more often than we would like, we end up taking things on trust.

## Paragraph

- [ ] With traditional print media, there is not much we can do about this ``disconnect'' between outputs like chart and figures and the underlying data. For digital media, other options are open to us.
- [ ] One way to improve things is to engineer visual artefacts to be more ``self-explanatory'', so they can reveal to an interested user the relationship to the underlying data.
- [ ] Consider the histogram in Fig. 1, which shows urban population growth in Asia from [..]. Ignore for a moment the pop-up showing information about Chiang Mai. Given just the histogram, there are many questions a reader might have about what the chart “represents” – in other words how visual elements map to underlying data. Whether the points represent individual cities, what the colour scheme indicates, which of the points represents large cities or small cities, etc.
- [ ] Sometimes legends and other text can help, but ambiguities inevitably remain. These do not necessarily reflect a problem with the visualisation. The entire ``value proposition'' of a summary, after all, is exactly that it emphasises aggregate information at the expense of detail.
- [ ] Bremer made it possible for the user to explore some of these questions themselves _in situ_, that is to say without leaving the context of the chart, via additional interactions. For example, by selecting the red dot shown, theey are able to bring up a view of the data that the dot ``represents`` (was calculated from).

## Automated data transparency

- [ ] These features are extremely valuable comprehension aids, but they are also laborious to implement. They also require the author to anticipate the kind of query the user might have. Things don't naturally generalise: for example Bremer's visualisation doesn't allow the user to select more than one of the circles at once.
- [ ] Recently, there has been interest in treating this as programming language infrastructure problem: baking dependency metadata directly into outputs, so that these sorts of queries can be supported automatically.
- [ ] The promise of this approach to the content consumer is to offer them the best of both worlds: the high-level overview provided by the visual summary, plus as much detail as they want about the underlying data on an as-needed basis. The relationship to data can be "incrementally discoverabile", revealed as the user interacts with the parts of the output they care about, ideally with some kind of formal guarantee that the revealed data is ``minimal and sufficient''.
- [ ] To the best of our knowledge, Psallidas et al were first to highlight some deep connections between visual interactions, such as selection of visual elements, and data provenance, sketching out (in a vision paper) [..]; Perera et al implemented something resembling this idea using a pair of ``dependency tracking'' operators, written here as ▽ (demands) and ▲ (suffices for), linking specific output selections to input selections. The formal guarantee that the corresponding input selections are ``minimal and sufficient'' is captured by ▽ and ▲ forming a \emph{Galois connection}, a pair of functions related in the following near-reciprocal way: [give the 'iff' equation]
- [ ] (Here \leq is the inclusion relation over sets of data elements.) This says that if a set of outputs Y demands a set of inputs X, then X is the smallest set of inputs which suffices for Y [and vice versa]. (A Galois connection thus generalises an order isomorphism in the sense of relaxing the usual isomorphism laws to inequalities.) Galois connections lend themselves well to bidirectional reasoning about resource consumption because the ▲ direction (sufficiency) can serve as a fine-grained notion of reproducibility: a way of verifying that a supplied data set (perhaps a subset of a larger one) is in fact sufficient to reproduce a particular feature of a complex output.

- [ ] We call this broad idea of [..] _data transparency_, and illustrate this in Fig 2 using our implementation, which builds on the ideas of Psallidas et al and Perera et al.
- [ ] Consider the two charts at the top of the figure. As with the histogram, there are many questions even a domain expert might have about these charts. For example, in renewable energy an important distinction is that between _capacity_ and _output_ -- which of these is being shown in the bar chart? What kinds of energy are counting as "non-renewable"? In the scatter plot, the label on the x-axis suggests that it represents some kind of part-to-whole ratio (renewables to total energy capacity, perhaps), whereas the y-axis purports to represent the ``capacity factor'' of clean energy sources. But these labels are little more than informal commentary. Moreover there are _two_ outputs here and so the question of if and how they might be related also arises.
- [ ] A system with automated data transparency allows the user to investigate questions like these by interacting directly with the outputs. By selecting an interesting part of the output, they can obtain a view of the relevant data. On the left the bar segments highlighted with a dark border indicate such a selection; the table underneath shows the demanded data (computed using our version of the ▽ operator) and we are also able to automatically select any outputs in the other chart which demand the same data using an other operator △ (``demanded by''). Perera et al also defined such an operator as the De Morgan dual of the ``suffices for'' operator ▲; one of our contributions (as we shall see in \secref{} below) is to show that △ can be computed in a more direct fashion using dependence graphs.
- [ ] These sorts of transparency features fall short of providing a full ``explanations'' of how output parts are related to input parts. They do, however, significantly improve on the current state of affairs. Queries do not have to be anticipated in advance by the author of the visualisation, and laboriously hand-coded. The infrastructure providing them can be validated once for a given language rather than implemented on an ad hoc basis for each application. In future work we discuss extending this ``extensional'' notion of transparency to more explanatory ``intensional'' information.

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
  vs.~building dependence graphs, computing $\demandR$ and $\demandByR$ over each, and the relative
  implementation burden of the two approaches (\secref{evaluation}).

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

## Conjugate operators over dependence graphs

- [ ] Our insight in this paper is that dependence graphs provide an alternative approach to data transparency
that is more language-independent and [...] Moreover, certain problems are much easier to formulate in the
graphical setting. For example the ``related outputs'' operator illustrated in Fig 2. amounts to computing
_cognacy_ (common ancestry) in G^{\op}, or common descendancy in G, which in turn simply amounts to computing
backwards reachability in G and composing that with backwards reachability in G^{\op} (or equivalently,
reachability in G^{\op} composed with reachability in G) (△▽). The concept of ``conjugate''
operators~\cite{jonsson51}, functions between Boolean algebras which come in reciprocating pairs, turns out to
nicely capture these relations of cognacy. Conjugate pairs are closely related to Galois connections; if $f$ and $g$ are conjugate, then $f$ and the De Morgan dual of $g$ form a Galois connection [connecting our approach to the work above]
- [ ] In our setting, we rely mainly on ▽ and its conjugate △ computed as ▽ on G^{\op}. We also give an implementation of ▲ (``suffices for'') over G for the reasons mentioned above; it too can be defined in a language-agnostic way and also turns out to be useful as the basis of an alternative implementation of △ using the De Morgan dual which under some circumstances is faster.
- [ ] Our second contribution is that the graphical setting makes it straightforward to compose reachability in G and its opposite the other way around, producing another provenance query called _related inputs_ (▽△) which allows the user to query the input elements that are ``cognate'' in G to some inputs of interest (i.e.have a common ancestor in $G$).
- [ ] Related inputs characterises the relation of \emph{mutual relevance} which arises between two input elements when they contribute to a common output element (by element we mean some part of the input or output data). Users are able to ask questions of the form ``What outputs use this data element, and what other data element are used along with it?''
- [ ] Fig 2 illustrates related inputs, again using images from our implementation. [..]
- [ ] The easy symmetry of these two operations over G are interesting because △ is the De Morgan dual of ▲, the adjoint of ▽. This is actually a very simple notion arising as the image and preimage of the reachability relation of G; for functions, the image and preimage are adjoint, but for general relations they are _conjugate_.

## \OurLang: A Data-Transparent Programming Language

- [ ] We implement the abstract framework outlined above in a programming language called \OurLang, which [...].
- [ ] Example of scatter plot from Fig. 2
- [ ] Key point is that the author of the visualisation just expresses their output as a pure function of the inputs -- all the transparency features come for free. We provide a d3.js front end and a set of data types for common visualisations, and then enrich the d3.js renderings of the outputs with (a) selection information, and (b) additional interactions that [...]
- [ ] In the rest of the paper, we set out the formal graph framework (\secref{conjugate}), show how our Fluid interpreter implements the graph framework (\secref{core}) and then [performance] (\secref{evaluation}). Our implementation is open source and available at [...], which also has several interactive demos.
