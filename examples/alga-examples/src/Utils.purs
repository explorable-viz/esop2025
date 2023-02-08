module Graph.Utils
  ( addVertex
  , baNewNodeST
  , baRunT
  , cmpSnd
  , compareArrays
  , deltaGraph
  , inDegrees
  , newNeighbours
  , outDegrees
  , outStarG
  , shuffle
  , toAdjacencyMap
  , totDegrees
  , printGraph
  )
  where

import Control.Monad.Reader (Reader, runReader)
import Control.Monad.Reader.Trans (ask)
import Control.Monad.State (StateT, get, put, lift, runStateT)
import Prelude
import Random.PseudoRandom (Seed, randomRs)
import Algebra.Graph (Graph, connect, edgeCount, foldg, overlay, transpose, vertex, vertexCount, vertices)
import Algebra.Graph.AdjacencyMap as AM
import Algebra.Graph.Internal (fromArray)
import Data.Array (filter, fromFoldable, sortBy, take, zip, zipWith, length)
import Data.List (List)
import Data.Map (Map, intersectionWith, values)
import Data.Map.Internal (showTree)
import Data.Newtype (unwrap)
import Data.Set (size)
import Data.Tuple (Tuple(..), fst, snd)
import Data.Unfoldable (replicateA)
import Effect (Effect)
import Effect.Console (log)





-- -- Utility functions to compare lists for the addition of new vertices
compareArrays :: Array Int -> Array Int -> Array Boolean
compareArrays xs ys = zipWith (>=) xs ys

cmpSnd :: forall a. Tuple a Number -> Tuple a Number -> Ordering
cmpSnd left right = compare (snd left) (snd right)

shuffle :: forall a. Array a -> Reader Seed (Array a)
shuffle xs = do
    seed <- ask
    let
      randomDraws = randomRs 0.0 1.0 (length xs) seed :: Array Number
      zipped = zip xs randomDraws :: Array (Tuple a Number)
    pure (map fst (sortBy cmpSnd zipped))



-- compareNonEmptys :: NonEmptyArray Int -> NonEmptyArray Int -> NonEmptyArray Boolean
-- compareNonEmptys xs ys = zipWith (>=) xs ys

newNeighbours :: Int -> Int -> Array Int -> Int -> Reader Seed (Array Int)
newNeighbours numNodes maxNum nodeDegrees m = do
  seed <- ask
  let
    randomDraws    = randomRs 1 maxNum numNodes seed         -- imperative random numbers
    flags          = compareArrays randomDraws nodeDegrees     :: Array Boolean
    selectionPairs = zip nodeDegrees flags                 :: Array (Tuple Int Boolean)
    selected       = map fst (filter snd selectionPairs)   :: Array Int
    shuffled       = shuffle selected
  take m <$> shuffled

deltaGraph :: Int -> Graph Int -> Reader Seed (Graph Int) -- State (Graph Int) (Graph Int)
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

baNewNodeST :: Int -> StateT (Graph Int) (Reader Seed ) (Graph Int)
baNewNodeST m = do
  prev <- get
  diffNew <- lift (deltaGraph m prev)
  let
    newGraph = overlay prev diffNew
  put newGraph
  pure diffNew

baRunT ∷ Int → Int → Graph Int -> Seed → Tuple (List (Graph Int)) (Graph Int)
baRunT m numSteps initG seed =
  runReader (runStateT (replicateA numSteps (baNewNodeST m)) initG) seed


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