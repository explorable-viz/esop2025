module Test.Main where

import Prelude

import Algebra.Graph (Graph(..), edge, overlay, edgeList, vertices, clique)
import Algebra.Graph.Internal (fromArray)
import Control.Apply (class Apply)
import Control.Bind (class Bind)
import Control.Monad (pure)
import Control.Monad.State (State)
import Control.Monad.State.Trans (StateT(..))
import Control.Monad.State.Class (state)
import Data.Eq ((==))
import Data.Function ((#))
import Data.Functor (class Functor)
import Data.List.Types (List(..), (:))
import Data.List (zipWith)
import Data.Ord ((>=))
import Data.Tuple (Tuple(..))
import Data.Unfoldable (replicateA)
import Graph.Utils (compareLists, addVertex)

import Effect (Effect)
import Effect.Console (log)
-- Test Imports
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)


main :: Effect Unit
main = runTest do
  suite "graph utils" do
    test "compareLists ex" do
      Assert.equal (compareLists (1:2:3:4:Nil) (2:2:4:5:Nil)) (false : true : false : false : Nil)
    test "addVertex correct" do
      Assert.equal (edgeList (addVertex Empty 1 [2,3,4,5])) (fromArray [(Tuple 1 2) , (Tuple 1 3) , (Tuple 1 4) , (Tuple 1 5)] )
