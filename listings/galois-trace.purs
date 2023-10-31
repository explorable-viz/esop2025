traceGC $\gamma$ e = do
   t $\times$ v <- eval $\gamma$ e bot
   let
      bwd v' = evalBwd $\gamma$ e v' t
      fwd ($\gamma$' $\times$ e' $\times$ $\alpha$) = snd $\$$ successful $\$$ eval $\gamma$' e' $\alpha$
   pure $\$$ { gc: GC { fwd, bwd }, v }
