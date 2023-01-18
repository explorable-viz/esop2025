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
import Data.List (zipWith)
import Data.Ord ((>=))
import Data.Tuple (Tuple(..))
import Data.Unfoldable (replicateA)
import Effect (Effect)
import Effect.Console (log)
import Effect.Random (randomInt)
import Node.ReadLine (createConsoleInterface, noCompletion, prompt, setLineHandler, setPrompt, close)
import Prelude (class Applicative, Unit, bind, discard)
  
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
