# ESOP 2025 revision plan

Given the relatively incremental contribution of this paper and the various technical issues surrounding our
current graph-based approach, the writeup needs to be as compelling as possible.

## Minor changes

### Section 1

- [ ] Revisit title? (``Conjugate operators'' is a bit allusive.)
- [ ] Flow between end of 1.0 and start of 1.1 is a bit broken -- 1.0 needs to wrap-up with some kind of
  take-away for the reader before 1.1 starts.
- [ ] [1.1] "data exploration": probably not the right term -- it could be taken to connote exploratory
  data analysis, whereas we specifically mean exploring the relationship between visualisations and underlying
  data.
- [ ] [1.1] "the author of the content no longer...":
  - [ ] This suggests that previously they did have to concern themselves with these transparency features,
  but more typically these sorts of features are not provided at all.
  - [ ] [The author] "may find that they have an easier time exploring data, and building more complex models"
    is too speculative.
  - [ ] "the consumer of the content now has the ability..": but this is also the case with the manual
    solution. And perhaps "explore relationship to data" rather than "explore detail".
- [ ] "our system uses an operator ▽_G": integrate into the explanation of the scenario (or just omit). The
  subscript G is not short for graph; it's a metavariable (so probably doesn't belong at all in this section).
- [ ] [Linked inputs] "Additionally, our system will apply ▽_G": under what circumstances? Needs to be
  clearer/better motivated.
- [ ] [Linked outputs] Also needs better motivation. Second paragraph hard to understand.
- [ ] Contributions: emphasise that our contribution (vis-a-vis Psallidas, for example) is for general-purpose
  languages.
- [ ] Contributions: do we really need 3 separate citations of Perera et al. [2022], one in each bullet?
- [ ] Contributions: comparison to Bremer and Ranzijn doesn't really work here, because theirs is a fully
  manual approach (and therefore not a "solution" to our stated framing of data transparency as a
  infrastructure problem). By this point in the introduction we should have restricted interest to automated
  solutions. The concepts here are about _motivating_ the idea of an automated solution.

## More significant changes

### Contextualising our work

- [ ] [1.1, "programming language infrastructure problem"] It feels like we should reinstate Psallidas and Wu
[2018] discussion here, and perhaps the more general point about prior work on relationship between selection
in visualisation and data provenance, to better situate our work in a space that includes both work on
general-purpose languages and work in data viz. Currently these two paragraphs read as though the only prior
work in this space is Ricciotti et al. [2017] and Perera et al. [2022].

- [ ] [Contributions, closing paragraph] Also implies the only prior work in this space is Ricciotti et al.
  [2017] and Perera et al. [2022].

### Example programs

- [ ] Somehow we managed to omit any actual programs, which is fairly unforgivable in a PL paper (unless
  purely theoretical). The "let" expression in Section 3 is too toy to count, as are the "surface language"
  examples in Section 4 (which have their own problems).

### Fig. 2 example

- [ ] Fig. 2 example: maybe lead with something simpler (e.g. moving average) and either drop the more complex
  example entirely or use later.
- [ ] 4 scenarios introducing data transparency: we use the highlighting in Fig. 2 to illustrate 3 of our 4
  scenarios, but I think this is ambitious. The arrows in Fig. 2 illustrate only one of these scenarios
  (linked inputs), and the colours only really make sense from a linked inputs perspective too (because the
  grey inputs are the ``related inputs``). This is complicated further by the fact that when we talk about
  restricting the output selection to the y coordinate only, the reader has to imagine both the output and input
  selections being different from those shown in the figure.
