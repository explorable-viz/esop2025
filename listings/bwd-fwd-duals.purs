bwdDualAsFwdOp :: forall g. Graph g => Set Vertex -> g -> g
bwdDualAsFwdOp $\alpha$s0 g0 = fwdSlice $\alpha$s0 (op g0)

fwdDualAsBwdOp :: forall g. Graph g => Set Vertex -> g -> g
fwdDualAsBwdOp $\alpha$s0 g0 = bwdSlice $\alpha$s0 (op g0)
