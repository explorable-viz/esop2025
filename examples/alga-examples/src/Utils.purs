module Graph.Utils where


import Algebra.Graph (Graph(..), clique, connect, edge, edgeCount, foldg, overlay, transpose, vertex, vertexCount, vertices)
import Algebra.Graph.AdjacencyMap (gmap)
import Algebra.Graph.AdjacencyMap as AM
import Algebra.Graph.Internal (fromArray)
import Control.Apply (class Apply)
import Control.Bind (class Bind)
import Control.Monad (pure)
import Control.Monad.State (State, runState)
import Control.Monad.State.Class (state)
import Control.Monad.State.Trans (StateT(..))
import Data.Array (filter, fromFoldable, sortWith, take, zip, zipWith)
import Data.Eq ((==))
import Data.Function ((#), ($))
import Data.Functor (class Functor, map)
import Data.List.Types (List(..), (:))
import Data.Map (Map, values)
import Data.Newtype (unwrap)
import Data.NonEmpty (NonEmpty)
import Data.Ord ((>=), class Ord)
import Data.Set (Set, size, insert, empty)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..), fst, snd)
import Data.Unfoldable (replicateA)
import Effect (Effect)
import Effect.Random (random, randomInt)
import Prelude (bind, (<<<), (<$>), (+))



-- Add edge within state
addEdge :: forall a. a -> a -> State (Graph a) (Graph a)
addEdge s t = state (\g -> let e = edge s t in Tuple e (overlay g e))

addNode :: forall a. a -> State (Graph a) (Graph a)
addNode n = state (\g -> let newV = Vertex n in Tuple newV (overlay g newV))

-- -- Utility functions to compare lists for the addition of new vertices
compareArrays :: Array Int -> Array Int -> Array Boolean
compareArrays xs ys = zipWith (>=) xs ys

shuffle :: forall a. Array a -> Effect (Array a)
shuffle xs = map fst <<< sortWith snd <$> traverse (\x -> Tuple x <$> random) xs

-- compareNonEmptys :: NonEmptyArray Int -> NonEmptyArray Int -> NonEmptyArray Boolean
-- compareNonEmptys xs ys = zipWith (>=) xs ys

newNeighbours :: Int -> Int -> Array Int -> Int -> Effect (Array Int)
newNeighbours numNodes maxNum edgeCounts m = do
  randoms <- replicateA numNodes (randomInt 1 maxNum) 
  let 
      indices        = compareArrays randoms edgeCounts               -- Array Boolean
      selectionPairs = zip edgeCounts indices                         -- Array (Tuple Int Boolean)
      selected       = map fst (filter (\x -> snd x) selectionPairs)  -- Array Int
      shuffled       = shuffle selected                               -- Effect (Array Int)
  out <- pure $ ((take m) <$> shuffled)
  out

baNewnode :: Graph Int -> Int -> (State (Graph Int) (Graph Int))
baNewnode prev m =
  let
    normalizer      = edgeCount prev
    newId           = 1 + (vertexCount prev)
    degrees         = fromFoldable (values (outDegrees prev))
  in do
    neighbours <- newNeighbours (vertexCount prev) normalizer degrees m
    addVertexST prev newId neighbours



-- Needed to reexport these for constructing degree functions

toAdjacencyMap :: forall a. Ord a => Graph a -> AM.AdjacencyMap a
toAdjacencyMap = foldg AM.empty AM.vertex AM.overlay AM.connect

outDegrees :: forall a. Ord a => Graph a -> Map a Int
outDegrees g = map size (unwrap (toAdjacencyMap g))

inDegrees :: forall a. Ord a => Graph a -> Map a Int
inDegrees g = outDegrees (transpose g)

addVertex :: Graph Int -> Int -> Array Int -> Graph Int
addVertex prevGraph newNodeId newNeighbours = overlay prevGraph (connect (vertex newNodeId) (vertices (fromArray newNeighbours)))

addVertexST :: Graph Int -> Int -> Array Int -> State (Graph Int) (Graph Int)
addVertexST prev newId neighbours = state (\s -> Tuple newEdges newGraph)
  where
    newEdges = (connect (vertex newId) (vertices (fromArray neighbours)))
    newGraph = overlay prev newEdges 