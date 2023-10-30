bwdSliceDual :: forall g. Graph g => Set Vertex -> g -> g
bwdSliceDual αs0 g0 = fwdSlice αs0 (op g0)

fwdDualAsBwdOp :: forall g. Graph g => Set Vertex -> g -> g
fwdDualAsBwdOp αs0 g0 = bwdSlice αs0 (op g0)
