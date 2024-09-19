There are 3 comments I found most important to revisit:

-------------

# Reviewer D: C1

> C1. _Claims of novelty_. While there is prior work on (1) generating provenance/dependency graphs, (2)
> brushing and linking over such graphs, and (3) database-based queries over such graphs, we are not aware of
> such a feature being used to relate data sources to other data sources (as opposed to relate visualisations to
> other visualisations), nor are we aware of other approaches where these two kinds of linking can be understood
> as formally dual. We will make sure to emphasise these as novel contributions of our approach.

1. _"we are not aware of such a feature being used to ...."_

   I'm not sure what single feature we are talking about here below? I read 3 features having been listed.

2. _".. (as opposed to relat(ing) visualisations to other visualisations)"_

   I don't know what this means, both on its own, and in the context of the whole sentence.

   Do you mean "rather than just visualisations to other visualisations":

3. _" nor are we aware of other approaches where these two kinds of linking can be understood ..."_

   I'm not sure what two kinds of linking we are talking about?

4. I would add a gentle reminder/emphasis on why these two points below are important as our contributions; I personally can't at all measure their significance:

   - we are not aware of such a feature being used to relate data sources to other data sources.
   - nor are we aware of other approaches where these two kinds of linking can be understood as formally dual.

5. General suggested rewrite, without addressing my comments above:

>  C1. _Claims of novelty_. Agreed -- this can be better clarified.
>  While there is prior work on (1) generating provenance/dependency graphs, (2)
>  brushing and linking over such graphs, and (3) database-based queries over such graphs,
>  we are the first (as far as we know) to:
>
>    1. Use these features to relate data sources to other data sources, rather than
>       just visualisations to other visualisations.
>    2. Provide an understanding of these two kinds of linking as being formally dual
>
>  We will make sure to emphasise these as novel contributions of our approach.

-------

# Reviewer C: C1.

> C1. _Graph dependencies via conjugate operators is complicated_. Conjugacy is important because it is the
> formal framework for relating forward and backwards analysis over the graph, for example explaining why you
> can compute the same function (extensionally speaking) in two different ways, with potentially different performance,
> using the De Morgan dual. We will streamline this section and also reorganise things so that the graph
> semantics comes first (with richer examples, as per Reviewer A), and the conjugate operators over the graph
> are presented afterwards, with a cleaner presentation.

I'm not sure how our suggested solution ("We will streamline this section ...") addresses their comment, or if
it was supposed to.

My suggestion and a general rewrite:

> C1. _Graph dependencies via conjugate operators is complicated_. We agree that the section on conjugate
> operators could be presented more clearly. However, conjugacy is crucial because it provides the
> formal foundation for understanding the relationship between forward and backward analysis on the graph.
> It explains why the same function can be computed in two different ways, with potentially different performance,
> via De Morgan duals.
> We will make sure this importance is clear when introducing conjugacy. In addition, we will streamline the
> section, and also reorganise so that the graph semantics comes first (including richer examples as per Reviewer A)
> and the conjugate operators over the graph afterwards, with a cleaner presentation.

-------

# Reviewer C: C2.

> C2. _Graph algorithms don't pay attention to properties of operators_. By the time the graph algorithms are
> given a graph, that graph already captures the kind of information you are referring to; so in the
> running example you mention, the dependence graph already captures the specific fact that x2 * x3 only depends
> on x2 (because it is zero), not x3. Thus whereas the procedure that builds the graph must depend on facts like
> these, the algorithms that operate on the graph can act uniformly on the graph without having to consider
> those details, which is one of the key benefits of factoring things this way.

I would rewrite this to something like:

> C2. _Graph algorithms don't pay attention to properties of operators_.  Correct! However, by the time the graph
> algorithms are given a graph, that graph itself already captures the kind of necessary information
> you are referring to. So in the example you mention, the graph captures the fact that x2 * x3 only depends on x2
> (since x2 = 0), and not x3.
> The key point is that while the process of constructing the graph depends on semantic details like this, once the
> graph is built, the algorithms can operate uniformly over it, abstracting away from such specifics. This abstraction
> is a core advantage of structuring the system this way --- allowing graph algorithms to focus solely on the dependencies
> encoded within the graph.
