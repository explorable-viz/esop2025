## Issues surrounding "persistent desugaring"

### Observations

- There are core terms whose preimage is not in the orginal surface program but is an intermediate surface term, e.g. the "rest" of a list comprehension. I think this is a a non-trivial issue if we want to think about a single-step desugaring relation as having a type. It is not simply a subset of SExpr x Expr because a reduct may also contain s terms. The point seems to be that, during desugaring, the target term is _gradually_ being rewritten from s to e, so at what point can it be said to be fully an e? Maybe this points again to the idea of a suspended/pending desugaring; but then doesn't that suggest the entire s term is actually an e?)
- The preimage of e is the entire s, whereas for debugging we might want to examine the effect of a single desugaring step/rewrite.
- The backwards analysis is a bit cumbersome because we have to "rewind" the algorithm to extract the annotations. But this is overkill; all we need to do is traverse the (partial) structure built by the forward algorithm.
- Each rewrite rule matches (consumes) some partial input and generates (produces) some partial output. If we could make this explicit (i.e. by making it clear where the boundaries of these partial values are), we could address the above two points.
- Our Sugar constructor for e goes some way towards this, by indicating when an e is the image of some s (i.e. the root of two partial terms related by desugaring). But this information is only accessible from s.

### Ideas

- Could we also make it is explicit which e's are the preimage of some s? I.e. represent every "desugar" edge in the syntax tree? This would involve transforming e as well as s to insert additional Desugar nodes (maybe). This sounds a bit cyclic, though: a Desugar would contain a Sugar which would want to point back to the same Desugar.
- Could we use an entirely separate "relational" structure to store the (e, s) edges? (Actually s might be an e too, see above.) But then we would have to separately represent the partial terms (redex, reduct pairs) in the relation. Maybe it's overkill to have both.
- Can we combine the above two intuitions, and have Desugar(e, e') edges (and/or perhaps Desugar(e, s) edges) be contained on both sides? When we desugar e to e', we get back a Desugar edge which we use to replace the redex and the reduct?
