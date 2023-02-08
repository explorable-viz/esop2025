module Main where


import Prelude

import Algebra.Graph (clique)
import Algebra.Graph.Internal (fromArray)
import Data.Tuple (snd)
import Effect (Effect)
import Effect.Class.Console (logShow)
import Effect.Console (log)
import Graph.Utils (baRunT, totDegrees)
import Node.ReadLine (createConsoleInterface, noCompletion, prompt, setLineHandler, setPrompt, close)
import Random.PseudoRandom (mkSeed)

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
      -- log "T = 0"
      -- logShow (totDegrees initGraph)
      let
        m = 3 :: Int
        initSeed = mkSeed 1234598134
        graphOne = baRunT m 20 initGraph initSeed
        graphTwo = baRunT m 20 initGraph initSeed
      log "T = 20"
      logShow (totDegrees $ snd graphOne)
      logShow (graphTwo == graphOne)
      --printGraph (snd graphOne)
      log "logged and loaded"
