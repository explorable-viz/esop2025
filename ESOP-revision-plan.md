# ESOP 2025 revision plan

Given the relatively incremental contribution of this paper and the various technical issues surrounding our
current graph-based approach, the writeup needs to be as compelling as possible.

## Minor changes

- [ ] Revisit title? (``Conjugate operators'' is a bit allusive.)
- [ ] Flow between end of 1.0 and start of 1.1 is a bit broken -- 1.0 needs to wrap-up with some kind of
  take-away for the reader before 1.1 starts.
- [ ] 1.1, "data exploration": probably not the right term -- it could be taken to connote exploratory
  data analysis, whereas we specifically mean exploring the relationship between visualisations and underlying
  data.
- [ ] 1.1, "the author of the content no longer...":
  - [ ] This suggests that previously they did have to concern themselves with these transparency features,
  but more typically these sorts of features are not provided at all.
  - [ ] [The author] "may find that they have an easier time exploring data, and building more complex models"
    is too speculative.
  - [ ] "the consumer of the content now has the ability..": but this is also the case with the manual
    solution. And perhaps "explore relationship to data" rather than "explore detail".

### Contextualising our work

- [ ] "programming language infrastructure problem" in 1.1: it feels like we should reinstate Psallidas and Wu
[2018] discussion here, and perhaps the more general point about prior work on relationship between selection
in visualisation and data provenance, to better situate our work in a space that includes both work on
general-purpose languages and work in data viz. Currently these two paragraphs read as though the only prior
work in this space is Ricciotti et al. [2017] and Perera et al. [2022].

## More significant changes

- [ ] Fig. 2 example: maybe lead with something simpler (e.g. moving average) and either drop the more complex
  example entirely or use later.
- [ ] 4 scenarios introducing data transparency: we use the highlighting in Fig. 2 to illustrate 3 of our 4
  scenarios, but I think this is ambitious. The example is already difficult, the arrows in Fig. 2 illustrate
  only one of these scenarios (linked inputs), and the colours only really make sense from a linked inputs
  perspective too (because the grey inputs are the ``related inputs``).
