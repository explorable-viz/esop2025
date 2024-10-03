# ESOP 2025 revision plan

Given the relatively incremental contribution of this paper and the various technical issues surrounding our
current graph-based approach, the writeup needs to be compelling.

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

### Section 3

- [ ] [3.5] "we can use the notion of sufficiency as a test of correctness" doesn't really make sense.
- [ ] [3.5] "This leads us to define the following pair of functions.." How are the definitions that follow
  supposedly suggested by the intuition just given?
- [ ] [3.5] The decision to omit ▼ from subsequent discussion weakens the story a bit: why make a big point of
  adjoint/conjugate pairs if one element of the pair is irrelevant? (And we do refer to it later: Lemma 3.13
  mentions it.) As it happens, it does now have a role in the implementation (since ▼(bot) picks out the
  "inert" input, i.e. input that isn't used anywhere) so we can justify in that way. Even if that were not so
  I think it would be preferable to include it for symmetry, especially in Fig. 7, where its omission invites
  confusion.
- [ ] [Fig. 8 and supporting paragraph] A number of problems here:
  - [ ] The appropriate notion here is not monotonicity. (▽△ and its dual are composed of monotonic parts so
    they are necessarily monotonic.) If x ⊆ f(x) for any x then f is said to be _increasing_ (or sometime
    _extensive_ or _inflationary_).
  - [ ] The colours here are confusing -- how do they relate to the colours used in Fig. 2? The sets and how
    they overlap are hard to discern. Very little of the detail in the diagram seems to be in the service of
    conveying the desired intuition.
  - [ ] "It is not hard to see how the same concept arises for linked outputs...": missing intuition here.
  - [ ] "a smoother experience for an end user": bit of an amorphous claim; just stick to the facts. Perhaps
    we can connect this to the use of ▼ (see above).

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

### Section 2 spurious

- [ ] 2.1 is too abstract to be useful and 2.2 too short to be useful. This section just adds to the sense
  that the paper isn't telling a clear story.

### Sections 3 and 4 out-of-sequence

- [ ] Section 3 doesn't follow well from Section 1. Assuming we extend Section 1 with an example program or
  two (which I think is essential) then the most natural step from there is probably Section 4, i.e. a
  formalisation of the core language (including "values with addresses" and how these serve as vertices) and
  its (graph-building) semantics. That will require a minimum set up for DDGs (i.e. some of what is in 3.2)
  but that can move into what is now Section 4 and that section moved before what is currently Section 3.
- [ ] The running example in Section 3 is quite problematic:
   - We haven't introduced the language yet or the idea that values in the program have "addresses" that act
     as vertices in the DDG.
   - Given that DDGs are a standard concept, the example is perhaps too simple: it only really illustrates the
  behaviour of primitive operations with an annihilator.
   - The DDG shown is apparently a simplification of the actual DDG of the program, which seems unfortunate
     given the triviality of the program, and a further opportunity for confusion (what details are omitted?).
   - The various "Example" paragraphs that refer to the running example are too fragmentary and would be
     better off collated into a single paragraph or two. They are also quite confusing. The first (about
     powersets) is oddly expressed and the second is quite unclear given that we don't know what it means for
     a node to be "associated to a value". The third Example paragraph says the example isn't complex enough
     to illustrate the distinction just made in the formalism (suggesting it's too simple as an example).
