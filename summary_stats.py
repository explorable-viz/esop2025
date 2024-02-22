import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

matrix_cases = [
    "slicing/dtw/compute-dtw",
    "slicing/convolution/edgeDetect",
    "slicing/convolution/emboss",
    "slicing/convolution/gaussian"
]

graphics_cases = [
    "graphics/background",
    "graphics/grouped-bar-chart",
    "graphics/line-chart",
    "graphics/stacked-bar-chart"
]

def decompose_benchmarks():
    benchmarks = pd.read_csv('../fluid/Benchmarks/benchmarks.csv', skipinitialspace=True, delimiter=',', index_col='Test-Name')
    matrices = benchmarks.loc[matrix_cases]
    matrix_means = matrices.mean().to_frame().T
    matrix_means.index = ['Matrix-Avg']
    matrices = pd.concat([matrices, matrix_means])
    graphics = benchmarks.loc[graphics_cases]
    graphics_means = graphics.mean().to_frame().T
    graphics_means.index = ['Graphics-Avg']
    graphics = pd.concat([graphics, graphics_means])
    all_summaries = pd.concat([matrices, graphics])
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
    df['DemBy-Speedup'] = df['T-DemandedBy'] / df['G-DemandedBy-Dir']
    df['DemandedBy-Suff-Speedup'] = df['T-DemandedBy'] / df['G-DemandedBy-Suff']
    out = df[['G-DemandedBy-Dir', 'G-DemandedBy-Suff','T-DemandedBy', 'DemBy-Speedup', 'DemandedBy-Suff-Speedup']]

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