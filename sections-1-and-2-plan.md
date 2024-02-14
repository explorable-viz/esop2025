# 1. Introduction: Towards Transparent Research Outputs

- [ ] Whether formulating a national policy or [..], we increasingly rely on [..] created by scientists and journalists. Interpreting these visual and textual summaries is essential to making informed decisions.
- [ ] Unfortunately such artefacts are \emph{opaque}: they are unable to reveal anything about how they relate to the data they were derived from.
- [ ] If we have the appropriate skills, a lot of time, and access to the source code and data sets, we may be able to reverse engineer some of these relationships for fact-checking or comprehension purposes. But this is unlikely to be easy, and more often than not we have to take things on trust.
- [ ] These difficulties are only compounded when the information presented draws on multiple data sources, such as [...]

- [ ] One way to address this problem is to engineer visual artefacts to be more ``self-explanatory'', i.e. able to reveal to an interested reader the relationship to underlying data
- [ ] Consider the histogram in Fig. 1, which shows urban population growth in Asia from [..], ignoring for a moment the pop-up showing information about Chiang Mai. Given just the histogram, there are many questions a reader might have about what the chart “represents” – how visual elements map to underlying data.
- [ ] Partial information is conveyed by legends and axis labels, but many questions remain: what are the individual points, what does the colour scheme indicate, do individual points represents large cities or small cities, etc.
- [ ] These uncertainties do not necessarily reflect a problem with the visualisation; any summary must inevitably emphasis aggregate information at the expense of detail
- [ ] What Bremer did was add interactions to her chart to allows the user to explore some of these questions themselves _in situ_, i.e. without leaving the context of the chart

## Automated data transparency
- [ ] However, coding up visualisations like Bremer's is laborious and requires the author of the visualisation to anticipate the kind of queries the user might have. Things don't naturally generalise: for example Bremer's visualisation doesn't allow the user to select more than one of the circles at once.
- [ ] Recently, there has been interest in treating this a programming language infrastructure problem: baking data dependency information directly into outputs, so that "provenance queries" can be supported automatically. - [ ] While there are many challenges in doing this, the potential is great too. Ideally the user to have the best of both worlds: the high-level overview provided by the visual summary, plus "incremental discoverability" of as much detail as they want about the underlying data, only about the parts they care about.
- [ ] Psallidas et al identified some connections between key concepts in data visualisation such as selection of visual elements, and data provenance; Perera et al implemented something resembling this idea using dependency tracking to link specific output selections to input selections
- [ ] We call this broad idea of [..] _data transparency_, and illustrate this using our implementation in Fig 1. The rectangles that we asked the reader to disregard earlier are an _output selection_ […]
- [ ] Although it falls short of providing a full explanation […] this does significantly improve on the current state of affairs

- [ ] Consider stacked bar chart in upper part of Fig. 1, for example (ignoring rectangles highlighted with a dark border for now)
- [ ] While one could try to use the source code and data sources to answer some of these questions, this requires substantial expertise and time spent offline from the “comprehension context” in which the questions originally arose
- [ ] Even a reviewer of a scientific paper may lack the resources or inclination to do this and any time spent on this is time taken away from reviewing the science

## Contributions

# 2. Overview of approach and solution

## Focus of this paper
- [ ] In this paper, we develop the idea of data transparency in two new directions. First we approach the problem in a language-independent way, using _dependence graphs_ […]. This separates the problem of defining queries over the graph from the problem of generating a dependence graph for a particular program. This approach is well-known from the program slicing literature, but has not yet been applied to data transparency [which operates under slightly different assumptions?]. In particular, previous approaches based on traces (e.g. Ricciotti et al) have involved defining a “reverse interpreter” that folds a trace back into a program slice, whereas with a graph […]
- [ ] This partitioning both reduces the implementation burden and improves performance compared to approaches that […]
- [ ] Second, we introduce a new kind of provenance query called _related inputs_, which allows a user to explore relations of cognacy (common ancestry) in the graph […]. In the graphical setting this is an easy thing to compute, since it amounts to reachability in $G$ composed with reachability in the opposite graph.
- [ ] Fig 2 illustrates related inputs, again using images from our implementation. [..]
- [ ] Finally, the graphical setting makes it straightforward to compose reachability in G and its opposite the other way around, producing another provenance query called _related outputs_ which allows the user to […].
