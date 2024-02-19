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
    print(matrices)
    print(graphics)


def eval_speedup(df):
    df['Eval-Speedup'] = df['T-Eval'] / df['G-Eval']
    out = df[['T-Eval', 'G-Eval', 'Eval-Speedup']]
    #tex_file = open('fig/performance/eval-speedup.tex', 'w')
    #tex_file.write(out.to_latex(float_format="%.2f", caption = "Slicing test-case evaluation times and average speedup", label='table:eval-speedups', longtable=True))
    #tex_file.close()
    return out

def equiv_implementations(df):
    out = df[['G-Fwd', 'Naive-Fwd','G-BwdDlCmp', 'G-BwdDlFwdOp', 'G-FwdDlCmp', 'G-FwdDlBwdOp']]
    tex_file = open('fig/performance/equivalent-impls.tex', 'w')
    #tex_file.write(out.to_latex(float_format="%.2f", caption = "Equivalent implementations of the De Morgan dual", label='table:equivalent-impls', longtable=True))
    #tex_file.close()

def slicing_times(df):
    df['Bwd-Speedup'] = df['T-Bwd'] / df['G-Bwd']
    df['Fwd-Speedup'] = df['T-Fwd'] / df['G-Fwd']
    out = df[['T-Fwd','G-Fwd','Fwd-Speedup','T-Bwd','G-Bwd','Bwd-Speedup']]
    #tex_file = open('fig/performance/slicing-speedup.tex', 'w')
    #tex_file.write(out.to_latex(float_format="%.2f", caption="Slicing times and average speedups", label='table:slicing-speedups', longtable=True))
    return out

def speedups(df):
    df['Eval-Speedup'] = df['T-Eval'] / df['G-Eval']
    df['Bwd-Speedup'] = df['T-Bwd'] / df['G-Bwd']
    df['Fwd-Speedup'] = df['T-Fwd'] / df['G-Fwd']
    out = df.replace([np.inf], np.nan, inplace=False)
    return out
decompose_benchmarks()