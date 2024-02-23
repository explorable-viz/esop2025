import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

cases = [
    "slicing/dtw/compute-dtw",
    "slicing/convolution/edgeDetect",
    "slicing/convolution/emboss",
    "slicing/convolution/gaussian",
    "slicing/linked-outputs/bar-chart-line-chart",
    "slicing/linked-outputs/stacked-bar-chart-scatter-plot",
    "graphics/grouped-bar-chart",
    "graphics/line-chart",
    "graphics/stacked-bar-chart"
]

def map_ind(index_str):
    return index_str.split("/")[-1]

def decompose_benchmarks():
    benchmarks = pd.read_csv('../fluid/Benchmarks/benchmarks.csv', skipinitialspace=True, delimiter=',', index_col='Test-Name')
    all_summaries = benchmarks.loc[cases]
    # means = all_summaries.mean().to_frame().T
    # means.index = ['Average']
    all_summaries.index = map(map_ind, all_summaries.index)
    # all_summaries = pd.concat([all_summaries, means])
    evals = eval_speedup(all_summaries)
    demands = demands_speedup(all_summaries)
    equivs = equiv_implementations(all_summaries)
    print(evals)


def eval_speedup(df):
    df['Eval-Speedup'] = df['T-Eval'] / df['G-Eval']
    out = df[['T-Eval', 'G-Eval', 'Eval-Speedup']]
    tex_file = open('fig/performance/eval-speedup.tex', 'w')
    tex_file.write(out.to_latex(float_format="%.2f", caption = "Evaluation Time of Traces Versus Graphs (ms)", label='table:eval-speedups', longtable=True))
    tex_file.close()
    return out

def equiv_implementations(df):
    df['DemBy-Dir-Speedup'] = df['T-DemBy'] / df['G-DemBy-Dir']
    df['DemBy-Suff-Speedup'] = df['T-DemBy'] / df['G-DemBy-Suff']
    out = df[['T-DemBy','G-DemBy-Dir', 'DemBy-Dir-Speedup', 'G-DemBy-Suff', 'DemBy-Suff-Speedup']]

    tex_file = open('fig/performance/equivalent-impls.tex', 'w')
    tex_file.write(out.to_latex(float_format="%.2f", caption = "Equivalent implementations of Demanded By", label='table:equivalent-impls', longtable=True))
    tex_file.close()
    return out

def demands_speedup(df):
    df['Bwd-Speedup'] = df['T-Demands'] / df['G-Demands']
    out = df[['T-Demands','G-Demands','Bwd-Speedup']]
    tex_file = open('fig/performance/demands-speedup.tex', 'w')
    tex_file.write(out.to_latex(float_format="%.2f", caption="Demands Times Traces Versus Graphs", label='table:demands-speedups', longtable=True))
    tex_file.close()
    return out

def speedups(df):
    df['Eval-Speedup'] = df['T-Eval'] / df['G-Eval']
    df['Bwd-Speedup'] = df['T-Demands'] / df['G-Demands']
    df['Fwd-Speedup'] = df['T-Suffices'] / df['G-Suffices']
    out = df.replace([np.inf], np.nan, inplace=False)
    return out
decompose_benchmarks()