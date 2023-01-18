module Graph.Utils where


import Algebra.Graph (Graph(..), edge, overlay, vertex, connect, vertices, clique)
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
import Effect (Effect)
import Effect.Random (randomInt)
import Prelude (bind)
-- Add edge within state
addEdge :: forall a. a -> a -> State (Graph a) (Graph a)
addEdge s t = state (\g -> let e = edge s t in Tuple e (overlay g e))

addNode :: forall a. a -> State (Graph a) (Graph a)
addNode n = state (\g -> let newV = Vertex n in Tuple newV (overlay g newV))

-- Utility functions to compare lists for the addition of new vertices
compareLists :: List Int -> List Int -> List Boolean
compareLists xs ys = zipWith (>=) xs ys

boolList :: Int -> Int -> List Int -> Effect (List Boolean)
boolList numNodes maxNum edgeCounts = do
  randoms :: List Int <- replicateA numNodes (randomInt 1 maxNum)
  pure (compareLists randoms edgeCounts)


addVertex :: Graph Int -> Int -> Array Int -> Graph Int
addVertex prevGraph newNodeId newNeighbours = overlay prevGraph (connect (vertex newNodeId) (vertices (fromArray newNeighbours)))