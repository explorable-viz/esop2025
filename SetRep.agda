module SetRep where

open import Relation.Binary.PropositionalEquality
open import Data.Empty
open import Data.Product
open import Relation.Unary hiding (U)
open import Relation.Nullary
open import Level

-- # Set construction

set : {l : Level} -> Set l -> Set (suc l)
set {l} U = (u : U) -> Set l

variable
  U : Set
  V : Set

-- # Some key constructions on sets

emptySet : set U
emptySet _ = ⊥

subset : set U -> set U -> Set
subset X' X = {x : _} -> X' x -> X x

emptyIsInitial : (X : set U) -> subset emptySet X
emptyIsInitial X {x} p = ⊥-elim p

power : set U -> (set U) -> Set
power X Y = subset Y X

_ᶜ : set U -> set U
X ᶜ = \x -> ¬ (X x)

_⊗_ : {l : Level} {U V : Set l} -> set U -> set V -> set (U × V)
(X ⊗ Y) (x , y) = X x × Y y

-- ## Properties of these constructions

selfInPower : (X : set U) -> (power X) X
selfInPower X z = z

emptyInPower : (X : set U) -> (power X) emptySet
emptyInPower X z = ⊥-elim z

-- # Functions and relations

rel : (X : set U) -> (Y : set V) -> (R : set (U × V)) -> Set
rel X Y R = subset R (X ⊗ Y)

image : {X : set U} {Y : set V} -> (R : set (U × V)) -> (u : U) -> set V
image {X} {Y} R x y = R (x , y)

-- func : (X : set U) -> (Y : set V) -> (R : set (U × V)) -> Set
-- func X Y F = subset F (X ⊗ Y) ×
