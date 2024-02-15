module Algorithm where

open import Relation.Binary.PropositionalEquality
open import Data.Empty
open import Data.Product
open import Relation.Unary hiding (U)
open import Relation.Nullary
open import Level

open import SetRep

postulate
  Label : Set

Vertices : Set₁
Vertices = set Label

Edges : (Label -> Set) -> Set₁
Edges V = {a b : Label} -> (V a × V b) -> Set

Graph : Set₁
Graph = Σ Vertices (\V -> Edges V)

emptyGraph : Graph
emptyGraph = (λ u → ⊥) , (λ x → ⊥)

subgraph : Graph -> Graph -> Set
subgraph (V , E) (V' , E') = Σ (subset V V') (\sub -> subedges sub E E')
  where
    subedges : (sub : {x : Label} -> V x -> V' x) -> Edges V -> Edges V' -> Set
    subedges sub e e' = {a b : Label} -> (v1 : V a) -> (v2 : V b) -> E (v1 , v2) -> E' (sub {a} v1 , sub {b} v2)

-- properties
emptyGraphIsInitial : (G : Graph) -> subgraph emptyGraph G
emptyGraphIsInitial (V , E) = (emptyIsInitial V) , (λ v1 v2 x → {!!})

reflexiveSubgraph : (G : Graph) -> subgraph G G
reflexiveSubgraph (V , E) = (λ x → x) , (λ v1 v2 x → x)

-- sources
S : Graph -> Vertices
S (V , E) a = (v1 : V a) -> ((a' : Label) -> (v0 : V a') -> ¬ E (v0 , v1))

-- sinks
T : Graph -> Vertices
T (V , E) a = (v1 : V a) -> ((b : Label) -> (v2 : V b) -> ¬ E (v1 , v2))

-- Computation of demands/demanded by
mutual

  data Reaches (G : Graph) : (V : Vertices) -> (V' : Vertices)
               -> (prf1 : subset V (S G)) -> (prf2 : subset V' (T G)) -> Set where
     reaches : {V : Vertices}
               -> ReachesV G emptyGraph V G (emptyGraphIsInitial G) (reflexiveSubgraph G)
               -> Reaches G V (T G) {!!} {!!}

  data ReachesV (G'' : Graph) : (G : Graph) -> (V : Vertices) -> (G' : Graph)
               -> subgraph G G' -> subgraph G' G'' -> Set where
