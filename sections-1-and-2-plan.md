# 1. Introduction: Towards Transparent Research Outputs

- [ ] Whether formulating a national policy or [..], we increasingly rely on [..] created by scientists and journalists. Interpreting these visual and textual summaries is essential to making informed decisions.
- [ ] However, most of the artefacts we encounter are \emph{opaque}: unable to reveal anything about how they relate to the data they were derived from.
- [ ] While one could in principle try to use the source code and data sources to reverse engineer some of these relationships, this requires substantial expertise, as well as valuable time spent away from the “comprehension context” in which we encountered the output in question.
- [ ] These difficulties are only compounded when the information presented draws on multiple data sources, such as [...]
- [ ] Even professional reviewers may lack the resources or inclination to get too involved. Perhaps more often than we would like, we end up taking things on trust.

## Paragraph

- [ ] With traditional print media, there is not much we can do about this ``disconnect'' between outputs like chart and figures and the underlying data. For digital media, other options are open to us.
- [ ] One way to improve things is to engineer visual artefacts to be more ``self-explanatory'', so they can reveal to an interested user the relationship to the underlying data.
- [ ] Consider the histogram in Fig. 1, which shows urban population growth in Asia from [..]. Ignore for a moment the pop-up showing information about Chiang Mai, and consider just the histogram. There are many questions a reader might have about what the chart “represents” – in other words how visual elements map to underlying data. Whether the points represent individual cities, what the colour scheme indicates, which of the points represents large cities or small cities, etc.
- [ ] Sometimes legends and other text can help, but ambiguities inevitably remain. These do not necessarily reflect a problem with the visualisation. The entire value proposition of a summary, after all, is exactly that it presents the ``big picture'' at the expense of detail.
- [ ] Bremer implemented her charts in a way that allowed a user to explore some of these questions themselves _in situ_, that is to say without leaving the context of the chart, via additional interactions. For example, by selecting the red dot shown, they are able to bring up a view of the data that the dot ``represents`` (was calculated from).

## Automated data transparency

- [ ] These features are valuable comprehension aids, but are also laborious to implement. They also require the author to anticipate the kinds of query a user might have. The supported interactions don't naturally generalise: for example Bremer's visualisation only allows the user to select more than one of the circles at a time.
- [ ] Recently, there has been interest in treating this as programming language infrastructure problem: baking dependency metadata directly into outputs, so that these sorts of queries can be supported automatically.
- [ ] The promise of this approach to the content consumer is to offer them the best of both worlds: the high-level overview provided by the visual summary, plus as much detail as they want about the underlying data on an as-needed basis. The relationship to data can be "incrementally discoverable", revealed as the user interacts with the parts of the output they care about, ideally with some kind of formal guarantee that the revealed data is ``minimal and sufficient''.
- [ ] To the best of our knowledge, Psallidas et al were first to highlight some deep connections between visual interactions, such as selection of visual elements, and data provenance, sketching out (in a vision paper) [..]; Perera et al implemented similar ideas using a pair of ``dependency tracking'' operators, written here as ▽ (demands) and ▲ (suffices for), linking specific output selections to input selections. The formal guarantee that the corresponding input selections are ``minimal and sufficient'' was captured by ▽ and ▲ forming a \emph{Galois connection}, a pair of functions related in the following near-reciprocal way: [give the 'iff' equation]
- [ ] (Here \leq is the inclusion relation over sets of data elements.) This says that if a set of outputs Y demands a set of inputs X, then X is the smallest set of inputs which suffices for Y [and vice versa]. (A Galois connection thus generalises an order isomorphism in the sense of relaxing the usual isomorphism laws to inequalities.) Galois connections lend themselves well to bidirectional reasoning about resource consumption because the ▲ direction (sufficiency) can be interpreted in terms of (fine-grained) reproducibility: a way of verifying that a supplied data set (perhaps a subset of a larger one) is in fact sufficient to reproduce a particular feature of a complex output [clarify "generic" reading of GC].

- [ ] We call this broad idea of [..] _data transparency_, and illustrate this in Fig 2 using our implementation, which builds on the ideas of Psallidas et al and Perera et al.
- [ ] Consider the two charts at the top of the figure. As with the histogram, there are many questions even a domain expert might have about these charts. For example, in renewable energy one must be careful not to confuse _capacity_ with _output_ -- which of these is being shown in the bar chart? What kinds of energy count as "non-renewable"? In the scatter plot, the label on the x-axis suggests that it represents some kind of part-to-whole ratio (renewables to total energy capacity, perhaps), whereas the y-axis purports to represent the ``capacity factor'' of clean energy sources. But these labels are little more than informal commentary. Moreover there are _two_ outputs here and so the question of if and how they might be related also arises.
- [ ] A system with automated data transparency allows the user to investigate questions like these by interacting directly with the artefacts. By selecting an interesting part of the output, they can obtain a view of the relevant data. On the left the bar segments highlighted with a dark border indicate such a selection; the table underneath shows the demanded data (computed using our version of the ▽ operator) and we are also able to automatically select any outputs in the other chart which demand any of the same data using an other operator △ (``demanded by''). The overlapping demand, which we call the \emph{mediating input}, is highlighted in  [...] Perera et al defined such an △ operator as the De Morgan dual of the ``suffices for'' operator ▲; one of our contributions (as we shall see in \secref{} below) is to show that △ can be computed in a more direct fashion using dependence graphs.

## Contributions

- [ ] In this paper, we develop the idea of data transparency in two new directions. First we approach the problem in a more language-independent way, using _dynamic dependence graphs_. This separates the problem of defining queries over the I/O dependencies for a particular program, from the problem of generating a dependence graph for that program. Dependence graphs are a proven technique: they have been used extensively for program slicing (mainly of imperative programs~\cite{ferrante87}), but have not yet been applied to data analyses based on adjoint pairs of operators (such as ▽ and ▲). These approaches (e.g. Ricciotti et al) have to date involved defining a “bidirectional interpreter” that builds an execution record in the form of a \emph{trace} during the forwards analysis, folding that trace back into a program slice during the backwards analysis. This method is quite inefficient and non-trivial to prove correct; a graph-based implementation factors the problem into a (language-specific) graph-building interpreter plus (language-agnostic) adjoint analyses over the graph. This partitioning reduces the implementation burden and improves performance compared to approaches based on reverse interpretation.

- [ ] Second, we introduce a new kind of provenance query called _related inputs_, a relation of mutual relevance which arises between inputs when they contribute to common features of the output. Queries of this form allow readers to ask questions like ``What outputs use this data element, and what other data elements are used along with it?''. Such questions explore \emph{cognacy} (common ancestry) in a dependence graph $G$, and are formally dual to the ``related outputs'' feature shown in Fig.1 inasmuch as it can be understood as cognacy in $G^{\op}$. In the graphical setting these are both easy to compute, since they amount to the two ways of composing reachability in $G$ with reachability in its opposite.

- [ ] Section 2 presents an overview of our approach and language, and motivates the idea of ``related inputs'' query from an end-user perspective. The rest of the paper is then organised as follows: [..]

  - [ ] Section 3 defines a new program analysis framework over dynamic dependence graphs, introducing the cognacy operator $\relInput$ (``related inputs'') and unpacking the intuitive relationship between its two components $\demandR$ (``demands'') and $\demandByR$ (``demanded by'') in terms of \citeauthor{jonsson51}'s notion of conjugate operators over Boolean algebras. We also introduce the dual cognacy operator $\relOutput$ (``related outputs'') and explain the relationship to Galois connections: $f$ and $g$ being conjugate
  is equivalent to $f$ and the De Morgan dual of $g$ forming a Galois connection. We give procedures for
  computing $\demandR_{D}$ and $\demandByR_{D}$ over a directed graph with reachability relation $D$
  - [ ] \secref{core} defines a core functional language with an operational semantics that pairs every result with a
  dynamic dependence graph suitable for computing $\demandR$ and $\demandByR$. We show how to represent (parts of) values as nodes in the graph.
  - [ ] \secref{evaluation} compares the performance of our implementation based on graphs and conjugates with an implementation due to \citet{perera22} based on traces and Galois connections, contrasting the overhead of building trace   vs.~building dependence graphs, computing $\demandR$ and $\demandByR$ over each, and the relative implementation burden of the two approaches ().
  - [ ] Section 6 reviews related work in more detail, including program slicing and DDGs.

The sort of transparency infrastructure proposed in this paper falls short of providing full ``explanations'' of how output parts are related to input parts. It does, however, significantly improve on the current state of affairs. Queries do not have to be anticipated in advance by the author of the visualisation and then laboriously hand-coded. The supporting infrastructure can be validated once for a given language rather than implemented on an ad hoc basis for each application. In Section 7 we discuss extending this ``extensional'' notion of transparency to more explanatory ``intensional'' information.

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
two separate analyses: a backwards ``demands'' analysis to determine data needed by an output selection, and
a forwards ``suffices for'' analysis whose De Morgan dual determines any parts of the other chart that also
need any of that data. Although extensionally each determines the other, these analyses need to be defined
separately and each depends on details of the language, imposing a significant burden on the implementor.
Moreover each runs over an execution record or trace of the entire computation regardless of whether all of
the trace is relevant.

## Conjugate operators over dependence graphs

- [ ] Our insight in this paper is that dependence graphs provide an alternative, more language-agnostic
foundation for data transparency that both improves performance and reduces the implementation burden. Moreover,
certain problems are much easier to formulate in the graphical setting. For example ``related outputs''
simply amounts to computing _cognacy_ (common ancestry) in G^{\op}, or common
descendancy in G, which in turn simply amounts to computing backwards reachability in G and composing that
with backwards reachability in G^{\op} (or equivalently, reachability in G^{\op} composed with reachability in
G) (△▽). The concept of ``conjugate'' operators~\cite{jonsson51} between Boolean algebras turns out to nicely capture these relations of cognacy.
- [ ] Definition
- [ ] Intuitively, this says that if a set of outputs Y demands a set of inputs X, then any set of inputs X' that overlaps with X is demanded by a set of outputs that overlaps with Y. The canonical example of a conjugate pair are the image and preimage functions for a relation R \subset
X \times Y. Conjugate pairs are also closely related to Galois connections; if $f$ and $g$ are conjugate, then
$f$ and the De Morgan dual of $g$ form a Galois connection.
- [ ] Because of these easy relationships, our setting technically only requires a single operator ▽_G, since
its conjugate △_G is readily computed as ▽_G^{\op} and its adjoint ▲_G as ▽_G^{\op}. It is well-known that
extensionally these things determine each other, but here we can also derive a procedure. We also give a
direct implementation of ▲_G which turns out to be useful as the basis of an alternative implementation of
△_G (again through De Morgan duality) which under some circumstances is faster.
- [ ] Our second insight is that the graphical setting makes it straightforward to compose reachability in G and its opposite the other way around, producing another provenance query called _related inputs_ (▽△). Fig 2 illustrates related inputs, again using images from our implementation. Suppose the user were this time to start from one of the input data sets, this time expressing interest in the bioenergy capacity of China for 2018. They do so by moving their mouse over the appropriate cell in the table (\figref{related-inputs-main} step 1), which turns green. In response the system generates two further selections automatically. First, any scatter plot elements that demand the selected input are given a similar green highlight; here just one point is highlighted, and in fact only the $y$ coordinate of that point (step 2, tooltip).
- [ ] We call this output selection the \emph{mediating output} because of its role in establishing a
connection between otherwise unrelated inputs. Finally, any other inputs demanded by the mediating output
(that were needed to compute the $y$ coordinate of that point) are highlighted in grey (steps 3a and 3b). (We
use a different colour to visually distinguish the \emph{answer} to the query from the selection that
initiated the query in the first place.)
- [ ] The result of a related inputs query can be thought of as a unit of comprehension, or perhaps reuse. It picks out all of the relevant data needed to understand how the original selected input is used. Moreover it
does so by identifying the common, or mediating, output elements that explain why the inputs are related. Sometimes a single input is used in many different outputs, or different aspects of a single output, resulting in a rather ``noisy'' query (lots of inputs are related); in \secref{} we also show how selectively projecting away irrelevant parts of the mediating output to obtain a refined query context in which more precise answers can be obtained. (The same approach can be used to discard irrelevant mediating inputs in a related outputs query to obtain more precise results.)

## \OurLang: A Data-Transparent Programming Language

- [ ] We implement the abstract framework outlined above in a programming language called \OurLang, which [...].
- [ ] Example of scatter plot from Fig. 2
- [ ] Key point is that the author of the visualisation just expresses their output as a pure function of the inputs -- all the transparency features come for free. We provide a d3.js front end and a set of data types for common visualisations, and then enrich the d3.js renderings of the outputs with (a) selection information, and (b) additional interactions that [...]
- [ ] In the rest of the paper, we set out the formal graph framework (\secref{conjugate}), show how our Fluid interpreter implements the graph framework (\secref{core}) and then [performance] (\secref{evaluation}). Our implementation is open source and available at [...], which also has several interactive demos.
