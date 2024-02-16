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
S (V , E) a = Σ (V a) (\v1 -> ((a' : Label) -> (v0 : V a') -> ¬ E (v0 , v1)))

sinkSub : (V : Vertices) -> (E : Edges V) -> (X : Vertices) -> subset X (S (V , E)) -> subset X V
sinkSub V E X sub {a} va = let v = sub {a} va in proj₁ v

-- sinks
T : Graph -> Vertices
T (V , E) a = Σ (V a) (\v1 -> ((b : Label) -> (v2 : V b) -> ¬ E (v1 , v2)))

-- TODO: there may be a better way than this...
-- can do this by composing the edges relation with itself n times where n is the number
-- of vertices.
-- reachability
{-# TERMINATING #-}
reachability : (V : Vertices) -> (E : Edges V) -> Edges V
reachability V E {a'} {b'} (va , vb) =
  (a' ≡ b') ⊎ (Σ Label (\c -> (vc : V c) -> E (va , vc) × reachability V E (vc , vb)))

-- Computation of demands/demanded by
mutual

  data Reaches (G0 : Graph) : (V : Vertices) -> (V' : Vertices) -> Set₁ where

     reaches : {V : Vertices} {G : Graph}
               -> (prf1 : subset V (S G0))
               -- -> (prf2 : subset V' (T G0))
               -> ReachesV G0 emptyGraph V G
               -> Reaches G0 V (T G)

  data ReachesV (G0 : Graph) : (G : Graph) -> (V : Vertices) -> (G' : Graph) -> Set₁ where
-- -> subgraph G G' -> subgraph G' G0
               
     reachesV-done : {G : Graph}
                  -> (prf : subgraph G G0)
                  -> ReachesV G0 G emptySet G

     reachesV-skip : {G G' : Graph} {V : Vertices}
                     -> ReachesV G0 G V G'
                     -> (a : Label)
                     -- a in vertices of G
                     -> (proj₁ G) a
                     -> ReachesV G0 G (cons a V) G'

     reachesV-extend : {G G' : Graph} {V V' : Vertices}
                     -> (a : Label)
                     -> ReachesV G0 (graphUnion G (toGraph a V')) (union V' V) G'
                     -> ReachesV G0 G (cons a V) G'
------

edgesToRelST : (V : Vertices) -> Edges V -> (set (Label × Label))
edgesToRelST V E (a , b) = Σ ((S (V , E)) a) (\isVa -> Σ ((T (V , E)) b) (\isVb -> E {a} {b} (proj₁ isVa , proj₁ isVb)))

Demands : (V : Vertices) -> (E : Edges V) -> (X : Vertices) -> subset X (S (V , E)) -> set Label
Demands V E X sub a =
  let r = reachability V E
      g' = (V , r)
  in preimage' {Label} {Label} {V} {V} (edgesToRelST V r) X (sinkSub V E X sub) a

-- preimage i.e. Triang_D(X') = {y in Y | exists x in X' (x, y) in D}

-----------
-- Reaches computes demanded by

theoremReaachesDemands1 : (V : Vertices) -> (E : Edges V) -> (X' : Vertices)
                         -> (prf : subset X' (S (V , E)))
                         -- -> subset (S (V , E)) V -- need strictness
                         -> (forall (G' : Graph)
                          -> Reaches (V , E) X' (T G')
                            -> ({a : Label} -> Demands V E X' prf a ≡ T G' a))
theoremReaachesDemands1 V E X' prf k reach = {!reach!}


theoremReaachesDemands2 : (V : Vertices) -> (E : Edges V) -> (X' : Vertices)
                         -> (prf : subset X' (S (V , E)))
                         -- -> subset (S (V , E)) V -- need strictness
                         -> (forall (G' : Graph)
                           -> ({a : Label} -> Demands V E X' prf a ≡ T G' a)
                          -> Reaches (V , E) X' (T G'))
theoremReaachesDemands2 = {!!}
