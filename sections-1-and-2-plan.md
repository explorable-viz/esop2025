# 1. Towards transparent research outputs

## Overall problem space
- [ ] [?] Before we turn to the details of our approach in Section 3, we take some time to explain the overall problem space we are interested in and how our work advances upon work to date in this area
- [ ] Basic problem we are concerned with is that charts and other visual summaries are _opaque_ – diconnected from data used to produce them
- [ ] Consider stacked bar chart in upper part of Fig. 1, for example (ignoring rectangles highlighted with a dark border for now)
- [ ] Many questions one might have about what the chart “represents” – how visual elements map to underlying data
- [ ] Partial information is conveyed by legends and axis labels – for example..
- [ ] While one could try to use the source code and data sources to answer some of these questions, this requires substantial expertise and time spent offline from the “comprehension context” in which the questions originally arose
- [ ] Even a reviewer of a scientific paper may lack the resources or inclination to do this and any time spent on this is time taken away from reviewing the science

## Work in this area to date
- [ ] One way to address these comprehension problems is to build provenance information directly into visual artefacts
- [ ] The value of doing so has been recognised for some time in the field of data visualisation, such as Bremer’s award-winning visualisation of [..]
- [ ] However, coding these things up by hand is laborious and error-prone, and so their has been recent interest in treating this an “infrastructure” problem
- [ ] Psallidas et al identified some connections between key concepts in data visualisation such as selection of visual elements, and data provenance; Perera et al implemented something resembling this idea using dependency tracking to link specific output selections to input selections
- [ ] We call this idea of [..] _data transparency_, and illustrate this using our implementation in Fig 1. The rectangles that we asked the reader to disregard earlier are an _output selection_ […]
- [ ] Although it falls short of providing a full explanation […] this does significantly improve on the current state of affairs

## Contributions

# 2. Overview of approach and solution

## Focus of this paper
- [ ] In this paper, we develop the idea of data transparency in two new directions. First we approach the problem in a language-independent way, using _dependence graphs_ […]. This separates the problem of defining queries over the graph from the problem of generating a dependence graph for a particular program. This approach is well-known from the program slicing literature, but has not yet been applied to data transparency [which operates under slightly different assumptions?]. In particular, previous approaches based on traces (e.g. Ricciotti et al) have involved defining a “reverse interpreter” that folds a trace back into a program slice, whereas with a graph […]
- [ ] This partitioning both reduces the implementation burden and improves performance compared to approaches that […]
- [ ] Second, we introduce a new kind of provenance query called _related inputs_, which allows a user to explore relations of cognacy (common ancestry) in the graph […]. In the graphical setting this is an easy thing to compute, since it amounts to reachability in $G$ composed with reachability in the opposite graph.
- [ ] Fig 2 illustrates related inputs, again using images from our implementation. [..]
- [ ] Finally, the graphical setting makes it straightforward to compose reachability in G and its opposite the other way around, producing another provenance query called _related outputs_ which allows the user to […].
