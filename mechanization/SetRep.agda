{-# OPTIONS --allow-unsolved-metas #-}

module SetRep where

open import Relation.Binary.PropositionalEquality
open import Data.Empty
open import Data.Product
open import Data.Sum
open import Relation.Unary hiding (U)
open import Relation.Nullary
open import Level
open import Data.Nat hiding (suc)
open import Data.Bool

open import Relation.Nullary.Decidable

-- # Set construction

set : {l : Level} -> Set l -> Set (suc l)
set {l} U = (u : U) -> Set l

variable
  U : Set
  V : Set

-- # Some key constructions on sets

emptySet : set U
emptySet _ = ⊥

isEmptySet : (X : set U) -> Dec (X ≡ emptySet)
isEmptySet X with X {!!}
... | p = {!p!}

subset : {U : Set} -> set U -> set U -> Set
subset {U} X' X = {x : U} -> X' x -> X x

power : set U -> (set U) -> Set
power X Y = subset Y X

_ᶜ : set U -> set U
X ᶜ = \x -> ¬ (X x)

_⊗_ : {l : Level} {U V : Set l} -> set U -> set V -> set (U × V)
(X ⊗ Y) (x , y) = X x × Y y

union : set U -> set U -> set U
union X Y = \x -> X x ⊎ Y x

-- ## Properties of these constructions

reflexiveSubset : (X : set U) -> subset X X
reflexiveSubset X = \x -> x

emptyIsInitial : (X : set U) -> subset emptySet X
emptyIsInitial X {x} p = ⊥-elim p

selfInPower : (X : set U) -> (power X) X
selfInPower X z = z

emptyInPower : (X : set U) -> (power X) emptySet
emptyInPower X z = ⊥-elim z

-- # Functions and relations

rel : (X : set U) -> (Y : set V) -> (R : set (U × V)) -> Set
rel X Y R = subset R (X ⊗ Y)

invR : {X : set U} {Y : set V} -> (x : U) -> (y : V) -> (X ⊗ Y) (x , y) -> Y y
invR {X} {Y} x y (fst , snd) = snd

--image : {X : set U} {Y : set V} -> (R : set (U × V)) -> (u : U) -> set V
--image {X} {Y} R x y = R (x , y)

----------

image : {U : Set} {V : Set} {X : set U} {Y : set V}
          -> (D : set (U × V))
          -> (X' : set U)
          -> subset X' X
          -> set V
image {U} {V} {X} {Y} D X' sub y = Σ U (\x -> X' x × D (x , y))


image' : {U : Set} {V : Set} {X : set U} {Y : set V}
          -> (D : set (U × V))
          -> (rel : rel X Y D)
          -> (X' : set U)
          -> power X X'
          -> Σ (set V) (\Y' -> power Y Y')
image' {U} {V} {X} {Y} D rel X' p = (\y -> Σ U (\x -> X' x × Y y × D (x , y))) , prf
  where
    prf : subset (\y -> Σ U (\x -> X' x × Y y × D (x , y))) Y
    prf {y} (x , xmem , ymem , drel) = let r = rel drel  in  invR {U} {V} {X} {Y} x y r

postulate
  emptyImage' : {U V : Set} {X : set U} {Y : set V}
              -> (D : set (U × V))
              -> (rel : rel X Y D)
              -> image' {U} {V} {X} {Y} D rel emptySet (emptyIsInitial X) ≡ (emptySet , emptyInPower Y)
-- image' D rel emptySet (emptyIsInitial X)
-- = 
-- emptyImage {U} {V} {X} {Y} D rel = {!!}
-- \Sigma U (\x -> emptySet x × D (x, y))

emptyImageIso : {U V : Set} {X : set U} {Y : set V}
              -> (D : set (U × V))
              -> (y : V)
              -> (image {U} {V} {X} {Y} D emptySet (emptyIsInitial X)) y -> emptySet y
emptyImageIso {U} {V} {X} {Y} D y ()

emptyImageIso' : {U V : Set} {X : set U} {Y : set V}
              -> (D : set (U × V))
              -> (y : V)
              -> emptySet y -> (image {U} {V} {X} {Y} D emptySet (emptyIsInitial X)) y
emptyImageIso' {U} {V} {X} {Y} D y ()

postulate
  isoSetIsEq : {U : Set} {X X' : set U}
             -> ((x : U) -> X x -> X' x)
             -> ((x : U) -> X' x -> X x)
             -> X ≡ X'

emptyImage : {U V : Set} {X : set U} {Y : set V}
              -> (D : set (U × V))
              -> image {U} {V} {X} {Y} D emptySet (emptyIsInitial X) ≡ emptySet
emptyImage {U} {V} {X} {Y} D = isoSetIsEq (\y -> emptyImageIso {U} {V} {X} {Y} D y) (\y -> emptyImageIso' {U} {V} {X} {Y} D y)

{-with image {U} {V} {X} {Y} D emptySet (emptyIsInitial X) a | inspect (image {U} {V} {X} {Y} D emptySet (emptyIsInitial X)) a
... | sub | [ prf ] = {!!}
-}

{-
preimage : {U : Set} {V : Set} {X : set U} {Y : set V}
          -> (D : set (U × V)) -> {rel : rel X Y D}
          -> (X' : set U)
          -> power X X'
          -> Σ (set V) (\Y' -> power Y Y')
preimage {U} {V} {X} {Y} D {rel} X' sub = pre , λ x → {!!}
  where
    pre : set V
    pre y = Σ U (\x -> X' x × D (x , y))
-}

-- func : (X : set U) -> (Y : set V) -> (R : set (U × V)) -> Set
-- func X Y F = subset F (X ⊗ Y) ×
