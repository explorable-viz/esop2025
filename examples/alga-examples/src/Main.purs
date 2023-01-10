module Main where


import Algebra.Graph (Graph(..), edge, overlay)
import Algebra.Graph.AdjacencyMap (vertices, clique)
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
import Data.Ord ((>=))
import Data.Tuple (Tuple(..))
import Data.Unfoldable (replicateA)
import Effect (Effect)
import Effect.Console (log)
import Effect.Random (randomInt)
import Node.ReadLine (createConsoleInterface, noCompletion, prompt, setLineHandler, setPrompt, close)
import Prelude (class Applicative, Unit, bind, discard)

-- Add edge within state
addEdge :: forall a. a -> a -> State (Graph a) (Graph a)
addEdge s t = state (\g -> let e = edge s t in Tuple e (overlay g e))

addNode :: forall a. a -> State (Graph a) (Graph a)
addNode n = state (\g -> let newV = Vertex n in Tuple newV (overlay g newV))

compareLists :: List Int -> List Int -> List Boolean
compareLists (x:xs) (y:ys) = 
  Cons (x >= y) (compareLists xs ys)
compareLists _ (Cons _ _) = Nil
compareLists _ _ = Nil

boolList :: Int -> Int -> List Int -> Effect (List Boolean)
boolList numNodes maxNum edgeCounts = do
  randoms :: List Int <- replicateA numNodes (randomInt 1 maxNum)
  pure (compareLists randoms edgeCounts)
  
main :: Effect Unit
main = do
  inputInterface <- createConsoleInterface noCompletion
  setPrompt "> " inputInterface
  prompt inputInterface
  inputInterface # setLineHandler \s ->
    if s == "quit"
    then 
      close inputInterface
    else do
      let list = fromArray [1,2,3,4,5] -- range    :: Int -> Int -> List Int
      let initGraph = clique list       -- vertices :: List a -> Graph a
      log s
      log "logged and loaded"
