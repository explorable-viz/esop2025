module Graph.Utils where

import Algebra.Graph (Graph, connect, edgeCount, foldg, overlay, transpose, vertex, vertexCount, vertices)
import Algebra.Graph.AdjacencyMap as AM
import Algebra.Graph.Internal (fromArray)
import Control.Monad (pure)
import Control.Monad.State
import Data.Array (filter, fromFoldable, sortWith, take, zip, zipWith)
import Data.Functor (map)
import Data.Map (Map, intersectionWith, values)
import Data.Newtype (unwrap)
import Data.Ord ((>=), class Ord)
import Data.Set (size)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..), fst, snd)
import Data.Unfoldable (replicateA)
import Effect (Effect)
import Effect.Random (random, randomInt)
import Prelude (bind, (<<<), (<$>), (+), (*), discard)




-- -- Utility functions to compare lists for the addition of new vertices
compareArrays :: Array Int -> Array Int -> Array Boolean
compareArrays xs ys = zipWith (>=) xs ys

shuffle :: forall a. Array a -> Effect (Array a)
shuffle xs = map fst <<< sortWith snd <$> traverse (\x -> Tuple x <$> random) xs

-- compareNonEmptys :: NonEmptyArray Int -> NonEmptyArray Int -> NonEmptyArray Boolean
-- compareNonEmptys xs ys = zipWith (>=) xs ys

newNeighbours :: Int -> Int -> Array Int -> Int -> Effect (Array Int)
newNeighbours numNodes maxNum nodeDegrees m = do
  randoms <- replicateA numNodes (randomInt 1 maxNum)        -- imperative random numbers
  let
      flags          = compareArrays randoms nodeDegrees     :: Array Boolean
      selectionPairs = zip nodeDegrees flags                 :: Array (Tuple Int Boolean)
      selected       = map fst (filter snd selectionPairs)   :: Array Int
      shuffled       = shuffle selected                      :: Effect (Array Int) -- imperative because of randoms
  take m <$> shuffled

deltaGraph :: Int -> Graph Int -> Effect (Graph Int) -- State (Graph Int) (Graph Int)
deltaGraph m prev =
  do
    let
      normalizer      = 2 * (edgeCount prev)
      newId           = 1 + (vertexCount prev)
      degrees         = fromFoldable (values (totDegrees prev))
    neighbours :: Array Int <- newNeighbours (vertexCount prev) normalizer degrees m
    let
      diffGraph  = outStarG newId neighbours
    pure diffGraph

baNewNodeST :: Int -> StateT (Graph Int) Effect (Graph Int)
baNewNodeST m = do
  prev <- get
  diffNew <- lift (deltaGraph m prev)
  let
    newGraph = overlay prev diffNew
  put newGraph
  pure diffNew


-- Utilities Which Make deltaGraph and baNewNodeST work
-- Needed to reexport these for constructing degree functions
toAdjacencyMap :: forall a. Ord a => Graph a -> AM.AdjacencyMap a
toAdjacencyMap = foldg AM.empty AM.vertex AM.overlay AM.connect

outDegrees :: forall a. Ord a => Graph a -> Map a Int
outDegrees g = map size (unwrap (toAdjacencyMap g))

inDegrees :: forall a. Ord a => Graph a -> Map a Int
inDegrees g = outDegrees (transpose g)

totDegrees :: forall a. Ord a => Graph a -> Map a Int
totDegrees g = intersectionWith (+) (inDegrees g) (outDegrees g)

-- deltaGraph construction
outStarG :: Int -> Array Int -> Graph Int
outStarG newId neighbours = connect (vertex newId) (vertices (fromArray neighbours))
