module Graph.Utils.Run
  ( baRunTest
  )
  where

import Prelude

import Algebra.Graph (Graph, connect, foldg, overlay, transpose, vertex, vertexCount, vertices, clique)
import Algebra.Graph.AdjacencyMap as AM
import Algebra.Graph.Internal (fromArray)
import Data.Array (filter, fromFoldable, sortBy, take, zip, zipWith, length)
import Data.Foldable (foldl)
import Data.List (List)
import Data.Map (Map, intersectionWith, values)
import Data.Newtype (unwrap)
import Data.Set (size)
import Data.Tuple (Tuple, fst, snd)
import Data.Unfoldable (replicateA)
import Random.PseudoRandom (Seed, mkSeed, randomRs)
import Run (Run)
import Run as Run
import Run.Reader (READER, ask, runReader)
import Run.State (STATE, get, put, runState)
import Type.Row (type (+))

-- -- Utility functions to compare lists for the addition of new vertices
compareArrays :: Array Int -> Array Int -> Array Boolean
compareArrays xs ys = zipWith (>=) xs ys

cmpSnd :: forall a. Tuple a Number -> Tuple a Number -> Ordering
cmpSnd left right = compare (snd left) (snd right)

shuffleRun :: forall a r. Array a -> Run (READER Seed + r) (Array a)
shuffleRun xs = do
    seed <- ask
    let
        randomDraws = randomRs 0.0 1.0 (length xs) seed :: Array Number
        zipped = zip xs randomDraws :: Array (Tuple a Number)
    pure (map fst (sortBy cmpSnd zipped))
-- compareNonEmptys :: NonEmptyArray Int -> NonEmptyArray Int -> NonEmptyArray Boolean
-- compareNonEmptys xs ys = zipWith (>=) xs ys

newNeighboursRun :: forall r. Array Int -> Int -> Run (READER Seed + r) (Array Int)
newNeighboursRun nodeDegrees m = do
   seed <- ask
   let
      numNodes = length nodeDegrees
      maxNum = foldl (+) 0 nodeDegrees
      randomDraws = randomRs 1 maxNum numNodes seed -- imperative random numbers
      flags = compareArrays randomDraws nodeDegrees :: Array Boolean
      selectionPairs = zip nodeDegrees flags :: Array (Tuple Int Boolean)
      selected = map fst (filter snd selectionPairs) :: Array Int
      shuffled = shuffleRun selected
   take m <$> shuffled

deltaGraphRun :: forall r. Int -> Graph Int -> Run (READER Seed + r) (Graph Int)
deltaGraphRun m prev =
    do
      let
         newId = 1 + (vertexCount prev)
         degrees = fromFoldable (values (totDegrees prev)) -- Array Integers
      neighbours :: Array Int <- newNeighboursRun degrees m
      let
         diffGraph = outStarG newId neighbours
      pure diffGraph

baNewNodeRun :: forall r. Int -> Run (STATE (Graph Int) + READER Seed + r) (Graph Int)
baNewNodeRun m = do
    prev <- get
    diffNew <- deltaGraphRun m prev -- Likely to be the error
    let newGraph = overlay prev diffNew
    put newGraph
    pure diffNew

baRunT :: Int -> Int -> Graph Int -> Seed -> Tuple (Graph Int) (List (Graph Int))
baRunT m numSteps initG seed = do
   Run.extract $ runState initG (runReader seed (replicateA numSteps (baNewNodeRun m)))

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

baRunTest :: Int -> Int -> Int -> Map Int Int
baRunTest m t seedI =
   let
      seed = mkSeed seedI
      initGraph = clique (fromArray [ 1, 2, 3, 4 ])
      outGraph = baRunT m t initGraph seed
   in
      totDegrees $ fst outGraph