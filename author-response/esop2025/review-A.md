Review #89A
Overall merit

4. Accept
Reviewer expertise

3. Knowledgeable
Paper summary

The paper presents a general-purpose approach for "transparent visualizations". Technically the program generating the data is run to produce a heap augmented with dependency edges. This induces a lattice over the powerset of heap locations which can be traversed to answer / expose visualization questions.
Comments for authors

Not being an expert, I found the paper quite creative, novel, and technically interesting. It is remarkable that fairly standard PL techniques can produce such an elegant system for transparent visualizations. 

There is a gap in my understanding that I hope the authors can clarify. My understanding is that the underlying program is run once to generate the heap / graph, and then further queries traverse the graph. So is the graph stored in memory with as many entry points as there are locations? There is never any re-execution of the program to re-generate parts of the graph on demand, right?

A smaller technical question: it seems that one can make the semantics look even more conventional by using a store semantics. May be even use a state monad to separate the standard use of locations from the novel fragments of the implementation.
