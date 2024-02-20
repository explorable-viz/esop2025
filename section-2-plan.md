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
