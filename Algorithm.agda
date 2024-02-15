module Algorithm where

open import Relation.Binary.PropositionalEquality
open import Data.Empty
open import Data.Unit
open import Data.Sum
open import Data.Product
open import Relation.Unary hiding (U)
open import Relation.Nullary
open import Level

open import SetRep

-- # Graphs

postulate
  Label : Set
  _=?_ : (a : Label) -> (b : Label) -> Set

Vertices : Set₁
Vertices = set Label

Edges : (Label -> Set) -> Set₁
Edges V = {a b : Label} -> (V a × V b) -> Set

Graph : Set₁
Graph = Σ Vertices (\V -> Edges V)

emptyGraph : Graph
emptyGraph = emptySet , emptySet

subgraph : Graph -> Graph -> Set
subgraph (V , E) (V' , E') =
  Σ (subset V V') (\sub -> {a b : Label} -> (v1 : V a) -> (v2 : V b) -> E (v1 , v2) -> E' (sub {a} v1 , sub {b} v2))

cons : (a : Label) ->  Vertices -> Vertices
cons a V = \a' -> (a ≡ a') ⊎ V a

graphUnion : Graph -> Graph -> Graph
graphUnion (V , E) (V' , E') = (union V V' , E'')
  where
    E'' : {a b : Label} -> (union V V' a × union V V' b) -> Set
    E'' (inj₁ x , inj₁ y) = E (x , y)
    E'' (inj₂ x , inj₂ y) = E' (x , y)
    E'' (inj₁ x , inj₂ y) = ⊥
    E'' (inj₂ x , inj₁ y) = ⊥

toGraph : (a : Label) -> Vertices -> Graph
toGraph a V = (cons a V , E)
  where
    E : Edges (cons a V)
    E {.a} {b'} (inj₁ refl , inj₁ _) = ⊥ -- a does not link to a
    E {.a} {b'} (inj₁ refl , inj₂ y) = ⊤
    -- Nothing else is connected
    E {a'} {b'} (inj₂ _ , _)         = ⊥

-- properties
emptyGraphIsInitial : (G : Graph) -> subgraph emptyGraph G
emptyGraphIsInitial (V , E) = (emptyIsInitial V) , aux
  where
    aux : {a b : Label} (v1 : emptySet a) (v2 : emptySet b)
         -> emptySet (v1 , v2)
         ->  E {a} {b} (emptyIsInitial V v1 , emptyIsInitial V v2)
    aux _ _ e = ⊥-elim e

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
               -> (prf1 : subset V (S G)) -> (prf2 : subset V' (T G)) -> Set₁ where

     reaches : {V : Vertices}
               -> ReachesV G emptyGraph V G (emptyGraphIsInitial G) (reflexiveSubgraph G)
               -> Reaches G V (T G) {!!} (reflexiveSubset (T G))

  data ReachesV (G'' : Graph) : (G : Graph) -> (V : Vertices) -> (G' : Graph)
               -> subgraph G G' -> subgraph G' G'' -> Set₁ where

     reachesV-done : {G : Graph} {prf : subgraph G G''}
                  -> ReachesV G'' G emptySet G (reflexiveSubgraph G) prf

     reachesV-skip : {G G' : Graph} {V : Vertices} {prf1 : subgraph G G'} {prf2 : subgraph G' G''}
                     -> ReachesV G'' G V G' prf1 prf2
                     -> (a : Label)
                     -> ReachesV G'' G (cons a V) G' prf1 prf2

     reachesV-extend : {G G' : Graph} {V V' : Vertices} {prf1 : subgraph G G'} {prf2 : subgraph G' G''}
                     -> (a : Label)
                     -> ReachesV G'' (graphUnion G (toGraph a V')) (union V' V) G' {!!} prf2
                     -> ReachesV G'' G (cons a V) G'  {!!} prf2
------

Demands : Graph -> Vertices -> set Label
Demands = {!!}


-----------
-- Reaches computes demanded by

theoremReaachesDemands1 : (V : Vertices) -> (E : Edges V) -> (X' : Vertices)
                         -> (prf : subset X' (S (V , E)))
                         -- -> subset (S (V , E)) V -- need strictness
                         -> (forall (G' : Graph)
                          -> Σ (subset (T G') (T (V , E)))
                                 (\prf' -> Reaches (V , E) X' (T G') prf prf')
                            -> ({a : Label} -> Demands (V , E) X' a ≡ T G' a))

theoremReaachesDemands1 = {!!}

theoremReaachesDemands2 : (V : Vertices) -> (E : Edges V) -> (X' : Vertices)
                         -> (prf : subset X' (S (V , E)))
                         -- -> subset (S (V , E)) V -- need strictness
                         -> (forall (G' : Graph)
                           -> ({a : Label} -> Demands (V , E) X' a ≡ T G' a)
                          -> Reaches (V , E) X' (T G') {!prf!} {!!})

theoremReaachesDemands2 = {!!}
