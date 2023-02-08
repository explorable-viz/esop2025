module Main where


import Prelude

import Algebra.Graph (Graph(..), edge, overlay, clique)
import Algebra.Graph.AdjacencyMap (vertices)
import Algebra.Graph.Internal (fromArray)
import Control.Apply (class Apply)
import Control.Bind (class Bind)
import Control.Monad (pure)
import Control.Monad.State (State, runStateT)
import Control.Monad.State.Class (state)
import Control.Monad.State.Trans (StateT(..))
import Data.Eq ((==))
import Data.Function ((#))
import Data.Functor (class Functor)
import Data.List (zipWith)
import Data.List.Types (List(..), (:))
import Data.Map.Internal (showTree)
import Data.Newtype (unwrap)
import Data.Ord ((>=))
import Data.Tuple (Tuple(..), snd)
import Data.Unfoldable (replicateA)
import Effect (Effect)
import Effect.Class.Console (logShow)
import Effect.Console (log)
import Effect.Random (randomInt)
import Graph.Utils (baRunT, printGraph, toAdjacencyMap, totDegrees)
import Node.ReadLine (createConsoleInterface, noCompletion, prompt, setLineHandler, setPrompt, close)

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
      let list = fromArray [1,2,3,4]
      let initGraph = clique list
      log "T = 0"
      logShow (totDegrees initGraph)
      let m = 3 :: Int
      graphOne <- baRunT m 20 initGraph
      log "T = 20"
      logShow (totDegrees $ snd graphOne)
      --printGraph (snd graphOne)
      log "logged and loaded"
