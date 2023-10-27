import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def decompose_benchmarks():
    benchmarks = pd.read_csv('../fluid/Benchmarks/benchmarks.csv', skipinitialspace=True, delimiter=',', index_col='Test-Name')
    slicing = benchmarks.filter(like='slicing', axis='index')
    graphics = benchmarks.filter(like='graphics', axis='index')
    desugar = benchmarks.filter(like='desugar', axis='index')
    misc = benchmarks.drop(pd.concat([slicing, graphics, desugar]).index, inplace=False)
    print("All Benchmarks: ")
    print (slicing[['Trace-Eval', 'Graph-Eval']].to_string())
    benchspeedup = speedups(slicing)[['Graph-Nodes','Eval-Speedup', 'Bwd-Speedup', 'Fwd-Speedup']]
    bigbenches = benchspeedup[benchspeedup['Graph-Nodes'] < 1000]
    print(benchspeedup.to_string())
    print(benchspeedup.mean())
    print(benchspeedup.std(ddof=0))
    print(benchspeedup.skew())

    bigbenches.plot(x='Graph-Nodes', y='Fwd-Speedup', logy=True,style='o')
    plt.show()
    # for test_set in [slicing, graphics, desugar, misc]:
    #     spedup = speedups(test_set)[['Eval-Speedup', 'Bwd-Speedup', 'Fwd-Speedup']]
    #     print(spedup)
    #     print(spedup.mean())



def speedups(df):
    df['Eval-Speedup'] = df['Trace-Eval'] / df['Graph-Eval']
    df['Bwd-Speedup'] = df['Trace-Bwd'] / df['Graph-Bwd']
    df['Fwd-Speedup'] = df['Trace-Fwd'] / df['Graph-Fwd']
    out = df.replace([np.inf], np.nan, inplace=False)
    return out
decompose_benchmarks()