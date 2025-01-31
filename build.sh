#!/bin/bash
set -e

PLOTTER="../fluid/script/python/plot_bench.py"
PDFLATEX="pdflatex -file-line-error -halt-on-error"
TARGET=${1:-main}
PYENV=venv

echo Building target \"$TARGET\".

python3 -m venv $PYENV
source $PYENV/bin/activate
   echo "Setting up Python environment."
   # pip install -q --disable-pip-version-check -r requirements.txt

   echo "Generating benchmark figures."
   rm -rf benchmark
   mkdir benchmark
   # cp "../fluid/benchmark/benchmarks.csv" "benchmark/benchmarks.csv"

   # python3 $PLOTTER -t expensive -b bwd -d fig/performance/expensive-bwd > /dev/null
   # python3 $PLOTTER -t expensive -b fwd -d fig/performance/expensive-fwd > /dev/null
deactivate

$PDFLATEX $TARGET
bibtex $TARGET
$PDFLATEX $TARGET
$PDFLATEX $TARGET
rm -f $TARGET.aux $TARGET.dvi $TARGET.log $TARGET.bbl $TARGET.blg $TARGET.out $TARGET.pag $TARGET.cb $TARGET.cb2 $TARGET.toc $TARGET.bcf $TARGET.run.xml
