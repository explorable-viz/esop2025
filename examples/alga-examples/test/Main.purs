module Test.Main where

import Prelude

import Algebra.Graph (Graph(..), edgeList, clique)
import Algebra.Graph.Internal (fromArray)

import Data.List.Types (List(..), (:))
import Data.Map (fromFoldable)

import Data.Tuple (Tuple(..), snd)

import Effect (Effect)

import Graph.Utils (addVertex, compareArrays, outDegrees)

import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)

main :: Effect Unit
main = runTest do
   suite "graph utils" do
      test "compareLists ex" do
         Assert.equal (compareArrays [ 1, 2, 3, 4 ] [ 2, 2, 4, 5 ]) [ false, true, false, false ]
      test "Correctness of addVertex" do
         Assert.equal (edgeList (snd (addVertex Empty 1 [ 2, 3, 4, 5 ]))) (fromArray [ (Tuple 1 2), (Tuple 1 3), (Tuple 1 4), (Tuple 1 5) ])
      test "outDegrees correct" do -- odd, due to the directional nature of the graphs
         Assert.equal (outDegrees (clique (fromArray [ 1, 2, 3, 4 ]))) (fromFoldable ((Tuple 1 3) : (Tuple 2 2) : (Tuple 3 1) : (Tuple 4 0) : Nil))
