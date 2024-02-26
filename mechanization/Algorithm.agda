{-# OPTIONS --allow-unsolved-metas #-}

module Algorithm where

open import Relation.Binary.PropositionalEquality
open import Data.Empty
open import Data.Unit
open import Data.Sum
open import Data.List
open import Data.Product
open import Relation.Unary hiding (U)
open import Relation.Nullary
open import Level hiding (suc)
open import Data.Nat
open import Relation.Nullary.Decidable

open import Data.Bool hiding (T)

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

isIn : (a : Label) -> (G : Graph) -> Dec (proj₁ G a)
isIn a G with proj₁ G a | inspect (\x -> proj₁ x a) G
... | p | [ eq ] = {!p!}


emptyGraph : Graph
emptyGraph = emptySet , emptySet

subgraph : Graph -> Graph -> Set
subgraph (V , E) (V' , E') =
  Σ (subset V V') (\sub -> {a b : Label} -> (v1 : V a) -> (v2 : V b) -> E (v1 , v2) -> E' (sub {a} v1 , sub {b} v2))

cons : (a : Label) ->  Vertices -> Vertices
cons a V = \a' -> (a ≡ a') ⊎ V a

postulate
  headAndTail : (V : Vertices) -> Σ Label (\a -> Σ Vertices (\V' -> cons a V' ≡ V))

graphUnion : Graph -> Graph -> Graph
graphUnion (V , E) (V' , E') = (union V V' , E'')
  where
    E'' : {a b : Label} -> (union V V' a × union V V' b) -> Set
    E'' (inj₁ x , inj₁ y) = E (x , y)
    E'' (inj₂ x , inj₂ y) = E' (x , y)
    E'' (inj₁ x , inj₂ y) = ⊥
    E'' (inj₂ x , inj₁ y) = ⊥

positivity : {G1 G2 G3 : Graph}
             -> subgraph (graphUnion G1 G2) G3
             -> subgraph G1 G3
positivity {G1} {G2} {G3} (sub , rel) = (λ x → sub {!!}) , {!!}

subGraphHomom : {G0 G1 G : Graph} -> subgraph G0 G1 -> subgraph (graphUnion G0 G) (graphUnion G1 G)
subGraphHomom {G0} {G1} (fst , snd) = (λ x → {!!}) , {!!}

toGraph : (a : Label) -> Vertices -> Graph
toGraph a V = (cons a V , E)
  where
    E : Edges (cons a V)
    E {.a} {b'} (inj₁ refl , inj₁ _) = ⊥ -- a does not link to a
    E {.a} {b'} (inj₁ refl , inj₂ y) = ⊤
    -- Nothing else is connected
    E {a'} {b'} (inj₂ _ , _)         = ⊥

postulate
  splitOut : (a : Label)
          -> (G : Graph)
          -> proj₁ G a
          -> Σ Vertices (\V' ->
               Σ Graph (\G0 -> G ≡ graphUnion G0 (toGraph a V')))


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

--
Tempty : T emptyGraph ≡ emptySet
Tempty = isoSetIsEq TemptyIso TemptyIso'
  where
    TemptyIso : (a : Label) -> T emptyGraph a -> emptySet a
    TemptyIso a ()

    TemptyIso' : (a : Label) -> emptySet a -> T emptyGraph a
    TemptyIso' a ()


-- prop
homomT : (G G' : Graph) -> subgraph G G' -> subset (T G) (T G')
homomT G G' = {!!}

-- TODO: there may be a better way than this...
-- can do this by composing the edges relation with itself n times where n is the number
-- of vertices.
-- reachability

reachability : (V : Vertices) -> (E : Edges V) -> ℕ -> Edges V
reachability V E zero {a'} {b'} (va , vb) = E (va , vb)
reachability V E (suc n) {a'} {b'} (va , vb) =
  (a' ≡ b') ⊎ (Σ Label (\c -> (vc : V c) -> E (va , vc) × reachability V E n (vc , vb)))

-- Computation of demands/demanded by
mutual

  data Reaches (G0 : Graph) : (V : Vertices) -> (V' : Vertices) -> Set₁ where

     reaches : {V : Vertices} {G : Graph}
               -> (prf1 : subset V (S G0))
               -- -> (prf2 : subset V' (T G0))
               -> ReachesV G0 emptyGraph V G
               -- ford
               -> forall (V' : Vertices) -> V' ≡ T G
               -> Reaches G0 V V'

  data ReachesV : (G0 : Graph)  -> (G : Graph) -> (V : Vertices) -> (G' : Graph) -> Set₁ where
-- -> subgraph G G' -> subgraph G' G0

     reachesV-done : {G0 G : Graph}
                  -> (prf : subgraph G G0)
                  -> ReachesV G0 G emptySet G

     reachesV-skip : {G0 G G' : Graph} {V : Vertices}
                     -> ReachesV G0 G V G'
                     -> (a : Label)
                     -> (ainV : proj₁ G a)
                     -> ReachesV G0 G (cons a V) G'

     reachesV-extend : {G0 G G' : Graph} {V V' : Vertices}
                     -> (a : Label)
                     -> ReachesV (graphUnion G0 (toGraph a V')) (graphUnion G (toGraph a V')) (union V' V) G'
                     -> ReachesV (graphUnion G0 (toGraph a V')) G (cons a V) G'
------

postulate
  verticesToList : Vertices -> List Label
  listToVertices : List Label -> Vertices
  emptyListVertices : listToVertices [] ≡ emptySet
  convIso : {V : Vertices} -> listToVertices (verticesToList V) ≡ V
  convCons : {a : Label} {V : List Label} -> listToVertices (a ∷ V) ≡ cons a (listToVertices V)

-- Proof that these relations are actually functions

reachesVIsAFunction : (G0 : Graph) -> (G : Graph) -> (V : List Label) -> subgraph G G0 -> Σ Graph (\G' -> ReachesV G0 G (listToVertices V) G')
reachesVIsAFunction G0 G (a ∷ Vrest) prf with isIn a G
reachesVIsAFunction G0 G (a ∷ Vrest) prf | yes p' rewrite convCons {a} {Vrest} =
 let (G' , demands) = reachesVIsAFunction G0 G Vrest prf
 in G' , reachesV-skip demands a p' 
reachesVIsAFunction G0 G (a ∷ Vrest) prf | no p' with splitOut a G0 {!!}
... | (V' , G0' , prf2) = 

 -- rewrite convCons {a} {Vrest} =

  let H = toGraph a V'
      (G' , demands) = reachesVIsAFunction (graphUnion G0 H) (graphUnion G H) (verticesToList V' ++ Vrest) (subGraphHomom {G} {G0} {H} prf)
  in G' , {!!}
reachesVIsAFunction G0 G [] prf rewrite emptyListVertices = G  , reachesV-done prf

reachesIsAFunction : (G0 : Graph) -> (V : Vertices) -> (subset V (S G0)) 
                   -> Σ Vertices (\V' -> Reaches G0 V V')
reachesIsAFunction G0 V prf rewrite sym (convIso {V}) =
  let (G , reachesV) = reachesVIsAFunction G0 emptyGraph (verticesToList V) (emptyGraphIsInitial G0) 
  in T G , reaches prf reachesV (T G) refl

-- ##  Properties on Reaches

relationship : (G0 : Graph) -> (G : Graph) -> (V : Vertices) -> (G' : Graph)
             -> ReachesV G0 G V G'
             -> (subgraph G G') × (subgraph G' G0)
relationship G0 G .emptySet .G (reachesV-done prf) = (reflexiveSubgraph G) , prf
relationship G0 G .(cons a V) G' (reachesV-skip {V = V} reach a aInV) =
 -- induction
 let (prf1 , prf2) = relationship G0 G V G' reach
 in prf1 , prf2
relationship G0 G .(cons a V) G' (reachesV-extend {V = V} {V' = V'} a reach) =
 -- induction + positivity
 let (prf1 , prf2) = relationship G0 (graphUnion G (toGraph a V')) (union V' V) G' reach
 in positivity {G} {toGraph a V'} {G'} prf1 , prf2

---

relationshipR : (G0 : Graph) -> (V : Vertices) -> (V' : Vertices)
             -> Reaches G0 V V'
             -> (subset V (S G0) × (subset V' (T G0)))
relationshipR G0 V V' (reaches {G = G} prf1 reach .V' eq) rewrite eq =
  let (prfa , prfb) = relationship G0 emptyGraph V G reach
  in prf1 , homomT G G0 prfb

-----

edgesToRelST : (V : Vertices) -> Edges V -> (set (Label × Label))
edgesToRelST V E (a , b) = Σ ((S (V , E)) a) (\isVa -> Σ ((T (V , E)) b) (\isVb -> E {a} {b} (proj₁ isVa , proj₁ isVb)))

Demands : (V : Vertices) -> (E : Edges V) -> (size : ℕ) -> (X' : Vertices) -> subset X' (S (V , E)) -> set Label
Demands V E n X' sub a =
  let r = reachability V E n
  in image {Label} {Label} {V} {V} (edgesToRelST V r) X' (sinkSub V E X' sub) a

emptyDemands : (V : Vertices) -> (E : Edges V) -> (size : ℕ)
            -> {a : Label} -> Demands V E size emptySet (emptyIsInitial (S (V , E))) a ≡ emptySet a
emptyDemands V E size = {!!}            

-----------
-- Reaches computes demanded by

theoremReaachesDemands1i : (V : Vertices) -> (E : Edges V) -> (size : ℕ) -> (X' : Vertices)
                         -> (prf : subset X' (S (V , E)))
                         -- -> subset (S (V , E)) V -- need strictness
                         -> (forall (V' : Vertices)
                          -> Reaches (V , E) X' V'
                            -> ({a : Label} -> Demands V E size X' prf a -> V' a))
theoremReaachesDemands1i V E n .emptySet prf V' (reaches prf1 (reachesV-done prf₁) .V' fprf) {a} ()

theoremReaachesDemands1i V E n .(cons a _) prf V' (reaches  prf1 (reachesV-extend {V = V0} {V' = V1} a x) .V' fprf) {b} demands with demands
... | y , inj₁ y-is-a , yreach , zreach = {!!}
... | y , inj₂ yinV0 , fst₂ , snd = {!!}


theoremReaachesDemands2 : (V : Vertices) -> (E : Edges V) -> (size : ℕ) -> (X' : Vertices)
                         -> (prf : subset X' (S (V , E)))
                         -- -> subset (S (V , E)) V -- need strictness
                         -> (forall (G' : Graph)
                           -> ({a : Label} -> Demands V E size X' prf a ≡ T G' a)
                          -> Reaches (V , E) X' (T G'))
theoremReaachesDemands2 = {!!}
