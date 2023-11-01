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
    eval_ratios = eval_speedup(benchmarks)
    print(eval_ratios.to_string())
    print(eval_ratios.mean())
    #     print(spedup.mean())

def eval_speedup(df):
    df['Eval-Speedup'] = df['Trace-Eval'] / df['Graph-Eval']
    out = df[['Trace-Eval', 'Graph-Eval', 'Eval-Speedup']]
    tex_file = open('fig/performance/eval-speedup.tex', 'w')
    tex_file.write(out.to_latex(float_format="%.2f", caption = "Slicing test-case evaluation times and average speedup"))
    tex_file.close()
    return out

def speedups(df):
    df['Eval-Speedup'] = df['Trace-Eval'] / df['Graph-Eval']
    df['Bwd-Speedup'] = df['Trace-Bwd'] / df['Graph-Bwd']
    df['Fwd-Speedup'] = df['Trace-Fwd'] / df['Graph-Fwd']
    out = df.replace([np.inf], np.nan, inplace=False)
    return out
decompose_benchmarks()