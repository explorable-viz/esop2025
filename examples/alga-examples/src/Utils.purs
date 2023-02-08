module Graph.Utils where

import Control.Monad.State
import Prelude
import Random.PseudoRandom

import Algebra.Graph (Graph, connect, edgeCount, foldg, overlay, transpose, vertex, vertexCount, vertices)
import Algebra.Graph.AdjacencyMap as AM
import Algebra.Graph.Internal (fromArray)
import Control.Monad (pure)
import Data.Array (filter, fromFoldable, sortBy, take, zip, zipWith, length)
import Data.Functor (map)
import Data.List (List)
import Data.Map (Map, intersectionWith, values)
import Data.Map.Internal (showTree)
import Data.Newtype (unwrap)
import Data.Ord ((>=), class Ord)
import Data.Set (size)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..), fst, snd)
import Data.Unfoldable (replicateA)
import Data.Unfoldable (replicateA)
import Effect (Effect)
import Effect.Console (log)
import Effect.Random (random, randomInt)
import Random.LCG (mkSeed)




-- -- Utility functions to compare lists for the addition of new vertices
compareArrays :: Array Int -> Array Int -> Array Boolean
compareArrays xs ys = zipWith (>=) xs ys

cmpSnd :: forall a. Tuple a Number -> Tuple a Number -> Ordering
cmpSnd left right = compare (snd left) (snd right)

shuffle :: forall a. Array a -> Effect (Array a)
shuffle xs =
  pure (map fst (sortBy cmpSnd zipped))
  where
    seed = mkSeed 1263236177
    randomDraws = randomRs 0.0 1.0 (length xs) seed :: Array Number
    zipped = zip xs randomDraws :: Array (Tuple a Number)

-- compareNonEmptys :: NonEmptyArray Int -> NonEmptyArray Int -> NonEmptyArray Boolean
-- compareNonEmptys xs ys = zipWith (>=) xs ys

newNeighbours :: Int -> Int -> Array Int -> Int -> Effect (Array Int)
newNeighbours numNodes maxNum nodeDegrees m =
  let
    seed           = mkSeed 1386124136
    randomDraws    = randomRs 1 maxNum numNodes seed         -- imperative random numbers
    flags          = compareArrays randomDraws nodeDegrees     :: Array Boolean
    selectionPairs = zip nodeDegrees flags                 :: Array (Tuple Int Boolean)
    selected       = map fst (filter snd selectionPairs)   :: Array Int
    shuffled       = shuffle selected                      :: Effect (Array Int) -- imperative because of randoms
  in
    take m <$> shuffled

deltaGraph :: Int -> Graph Int -> Effect (Graph Int) -- State (Graph Int) (Graph Int)
deltaGraph m prev =
  do
    let
      normalizer      = 2 * (edgeCount prev)
      newId           = 1 + (vertexCount prev)
      degrees         = fromFoldable (values (totDegrees prev)) -- Array Integers
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

baRunT ∷ Int → Int → Graph Int → Effect (Tuple (List (Graph Int)) (Graph Int))
baRunT m numSteps initG =
  runStateT (replicateA numSteps (baNewNodeST m)) initG


printGraph :: Graph Int -> Effect Unit
printGraph g = log (showTree (unwrap $ toAdjacencyMap g))
-- test m initial = runStateT (baNewNodeST m) initial

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

-- version required for test case in test/Main.purs
addVertex :: Graph Int -> Int -> Array Int -> Tuple (Graph Int) (Graph Int)
addVertex prevGraph newNodeId neighbours = Tuple diffGraph newGraph
  where
    diffGraph = connect (vertex newNodeId) (vertices (fromArray neighbours))
    newGraph  = overlay prevGraph diffGraph