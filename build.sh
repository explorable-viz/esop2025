#!/bin/bash
set -e

PYTHONSCRIPT="../fluid/plot_bench.py"

PDFLATEX="pdflatex -file-line-error -halt-on-error"
TARGET=${1:-main}
echo Building target \"$TARGET\".

cp "../fluid/Benchmarks/benchmarks.csv" "Benchmarks/benchmarks.csv"

python3 $PYTHONSCRIPT -t expensive -b bwd -d fig/performance/expensive-bwd
python3 $PYTHONSCRIPT -t expensive -b fwd -d fig/performance/expensive-fwd
$PDFLATEX $TARGET
bibtex $TARGET
$PDFLATEX $TARGET
$PDFLATEX $TARGET
rm -f $TARGET.aux $TARGET.dvi $TARGET.log $TARGET.bbl $TARGET.blg $TARGET.out $TARGET.pag $TARGET.cb $TARGET.cb2 $TARGET.toc
