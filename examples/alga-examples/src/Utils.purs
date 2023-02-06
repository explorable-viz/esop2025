module Graph.Utils where

import Algebra.Graph (Graph(..), connect, edge, edgeCount, foldg, overlay, transpose, vertex, vertexCount, vertices)
import Algebra.Graph.AdjacencyMap as AM
import Algebra.Graph.Internal (fromArray)
import Control.Monad (pure)
import Control.Monad.State (State)
import Control.Monad.State.Class (state)
import Control.Monad.State.Trans (StateT(..))
import Data.Array (filter, fromFoldable, sortWith, take, zip, zipWith)
import Data.Function (($))
import Data.Functor (map)
import Data.Map (Map, intersectionWith, values)
import Data.Newtype (unwrap)
import Data.Ord ((>=), class Ord)
import Data.Set (size)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..), fst, snd)
import Data.Unfoldable (replicateA)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Random (random, randomInt)
import Prelude (bind, (<<<), (<$>), (+), (*))




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
      flags          = compareArrays randoms nodeDegrees     -- Array Boolean
      selectionPairs = zip nodeDegrees flags                 -- Array (Tuple Int Boolean)
      selected       = map fst (filter snd selectionPairs)   -- Array Int
      shuffled       = shuffle selected                      -- Effect (Array Int) imperative because of randoms
  take m <$> shuffled

-- Next 2 functions are versions of the code which should work to simulate the barabasi albert model
baNewnode'' :: Int -> (Graph Int -> Effect (Tuple (Graph Int) (Graph Int))) -- State (Graph Int) (Graph Int)
baNewnode'' m = (\prev ->
  do
    let
      normalizer      = 2 * (edgeCount prev)
      newId           = 1 + (vertexCount prev)
      degrees         = fromFoldable (values (totDegrees prev))
    neighbours :: Array Int <- newNeighbours (vertexCount prev) normalizer degrees m
    let
      diffGraph  = addVertex' newId neighbours
      newGraph  = overlay diffGraph prev
    pure (Tuple (diffGraph) (newGraph)))

baNewNodeST :: Int -> StateT (Graph Int) Effect (Graph Int)
baNewNodeST m = StateT (baNewnode'' m)


-- Utilities Which Make baNewNode'' and baNewNodeST work 
-- Needed to reexport these for constructing degree functions
toAdjacencyMap :: forall a. Ord a => Graph a -> AM.AdjacencyMap a
toAdjacencyMap = foldg AM.empty AM.vertex AM.overlay AM.connect

outDegrees :: forall a. Ord a => Graph a -> Map a Int
outDegrees g = map size (unwrap (toAdjacencyMap g))

inDegrees :: forall a. Ord a => Graph a -> Map a Int
inDegrees g = outDegrees (transpose g)

totDegrees :: forall a. Ord a => Graph a -> Map a Int
totDegrees g = intersectionWith (+) (inDegrees g) (outDegrees g)


addVertex' :: Int -> Array Int -> Graph Int
addVertex' newId neighbours = connect (vertex newId) (vertices (fromArray neighbours))


-- Unused functions from prior versions of the code
-- Add edge within state
addEdge :: forall a. a -> a -> State (Graph a) (Graph a)
addEdge s t = state (\g -> let e = edge s t in Tuple e (overlay g e))

addNode :: forall a. a -> State (Graph a) (Graph a)
addNode n = state (\g -> let newV = Vertex n in Tuple newV (overlay g newV))

addVertex :: Graph Int -> Int -> Array Int -> Tuple (Graph Int) (Graph Int)
addVertex prevGraph newNodeId neighbours = Tuple diffGraph newGraph
  where
    diffGraph = connect (vertex newNodeId) (vertices (fromArray neighbours))
    newGraph  = overlay prevGraph diffGraph

-- Initial attempt at wrapping addvertex in StateT, pointless
addVertexST :: Graph Int -> Int -> Array Int -> StateT (Graph Int) Effect (Graph Int)
addVertexST prev newId neighbours = state (\_ -> Tuple newEdges newGraph)
  where
    newEdges = (connect (vertex newId) (vertices (fromArray neighbours)))
    newGraph = overlay prev newEdges

-- 2 versions which don't work but pass typechecker
baNewnode :: Graph Int -> Int -> StateT (Graph Int) Effect (Graph Int)
baNewnode prev m =
  let
    normalizer      = edgeCount prev
    newId           = 1 + (vertexCount prev)
    degrees         = fromFoldable (values (outDegrees prev))
  in do
    neighbours <- liftEffect $ newNeighbours (vertexCount prev) normalizer degrees m
    addVertexST prev newId neighbours

baNewnode' :: Int -> Graph Int -> StateT (Graph Int) Effect (Graph Int)
baNewnode' m prev =
  let
    normalizer      = edgeCount prev
    newId           = 1 + (vertexCount prev)
    degrees         = fromFoldable (values (outDegrees prev))
  in do
    neighbours <- liftEffect $ newNeighbours (vertexCount prev) normalizer degrees m
    let
      diffGraph = addVertex' newId neighbours
      newGraph  = overlay diffGraph
    state (\s -> Tuple diffGraph (newGraph s))

-- typechecking the newNeighbours function, as I was getting errors in the monad stack
neighboursTT :: Int -> Graph Int ->  Effect (Array Int)
neighboursTT m prev = 
  let
    normalizer      = edgeCount prev
    -- newId           = 1 + (vertexCount prev)
    degrees         = fromFoldable (values (outDegrees prev))
  in do
    neighbours <- newNeighbours (vertexCount prev) normalizer degrees m 
    pure neighbours