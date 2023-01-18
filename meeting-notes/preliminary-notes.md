# Preliminary notes

We have identified two interesting problem/opportunities:

- (Galois) slicing for imperative languages, using the backward analysis to isolate data and execution steps that contribute to specific parts of the output
- (Galois) slicing for debugging DSLs and languages with syntactic sugar, where we want to express program slices in surface syntax

These two problems are only related inasmuch as the imperative languages we consider may have syntactic sugar,
and we may want to consider imperative (effectful) DSLs. So the problems are not intrinsically related, but we
may end up having to consider both.

## Methodology

Some decisions we can probably take now:

- work in a pure functional setting, using algebraic effects for imperative features, because:
  - functional programming is the way forward
  - monads are tedious/uncompositional, algebraic effects are better compositional approach
  - algebraic effects are becoming mainstream (e.g. WebAssembly, Multicore OCaml)
- build on Galois dependencies for analysis technique, because:
  - nice mathematical properties
  - use my existing language implementation (Fluid) as a starting point

## Working examples

We will need at least one other, but let's start with Joe's suggestion:

- compute a graph from some data; select edge to jump to step in the computation where the edge was added

## Initial plan

- pick simple graph algorithm that we want to implement, and some small dataset
- prototype in (e.g.) Haskell using an algebraic effects library
- formalise core calculus with algebraic effects, based on existing calculi
- give a "standard" denotational semantics, plus a Galois dependencies semantics
