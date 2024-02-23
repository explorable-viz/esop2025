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
    evals = eval_SpdUp(all_summaries)
    demands = demands_SpdUp(all_summaries)
    equivs = equiv_implementations(all_summaries)
    print(evals)


def eval_SpdUp(df):
    df['Eval-Slowdown'] = df['G-Eval'] / df['T-Eval']
    out = df[['T-Eval', 'G-Eval', 'Eval-Slowdown']]
    tex_file = open('fig/performance/eval-SpdUp.tex', 'w')
    tex_file.write(out.to_latex(float_format="%.2f", caption = "Evaluation Time of Traces Versus Graphs (ms)", label='table:eval-SpdUps', longtable=True))
    tex_file.close()
    return out

def equiv_implementations(df):
    df['Dir-SpdUp'] = df['T-DemBy'] / df['G-DemBy-Dir']
    df['Suff-SpdUp'] = df['T-DemBy'] / df['G-DemBy-Suff']
    out = df[['T-DemBy','G-DemBy-Dir', 'Dir-SpdUp', 'G-DemBy-Suff', 'Suff-SpdUp']]

    tex_file = open('fig/performance/equivalent-impls.tex', 'w')
    tex_file.write(out.to_latex(float_format="%.2f", caption = "Equivalent implementations of Demanded By", label='table:equivalent-impls', longtable=True))
    tex_file.close()
    return out

def demands_SpdUp(df):
    df['Bwd-SpdUp'] = df['T-Demands'] / df['G-Demands']
    out = df[['T-Demands','G-Demands','Bwd-SpdUp']]
    tex_file = open('fig/performance/demands-SpdUp.tex', 'w')
    tex_file.write(out.to_latex(float_format="%.2f", caption="Demands Times Traces Versus Graphs", label='table:demands-SpdUps', longtable=True))
    tex_file.close()
    return out

def SpdUps(df):
    df['Eval-SpdUp'] = df['T-Eval'] / df['G-Eval']
    df['Bwd-SpdUp'] = df['T-Demands'] / df['G-Demands']
    df['Fwd-SpdUp'] = df['T-Suffices'] / df['G-Suffices']
    out = df.replace([np.inf], np.nan, inplace=False)
    return out
decompose_benchmarks()