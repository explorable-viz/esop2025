#!/bin/bash
set -xe

NAME=arXiv.zip
TARGET=arXiv

pdflatex $TARGET
biber $TARGET
rm -f $TARGET.aux $TARGET.dvi $TARGET.log $TARGET.blg $TARGET.out $TARGET.pag $TARGET.cb $TARGET.cb2 $TARGET.toc $TARGET.bcf $TARGET.run.xml

pushd ..

zip -r - $NAME graphical-slicing > $NAME

zip -d $NAME \*.zip
zip -d $NAME \*.pdf
zip -d $NAME \*.DS_Store
zip -d $NAME \*.gitignore
zip -d $NAME \*.gitmodules
zip -d $NAME \*.purs-repl
zip -d $NAME graphical-slicing/appendix.tex
zip -d $NAME graphical-slicing/main-full.tex
zip -d $NAME graphical-slicing/main.tex
zip -d $NAME graphical-slicing/paper.tex
zip -d $NAME graphical-slicing/inductive-graphs.tex
zip -d $NAME graphical-slicing/author-response/\*
zip -d $NAME graphical-slicing/Benchmarks/\*
zip -d $NAME graphical-slicing/tex-common/bib.bib
zip -d $NAME graphical-slicing/.git/\*
zip -d $NAME graphical-slicing/venv/\*
zip -d $NAME graphical-slicing/mechanisation/\*
zip -d $NAME graphical-slicing/obsolete/\*
zip -d $NAME graphical-slicing/Talk/\*
zip -d $NAME graphical-slicing/.vscode/\*

ls -al $NAME
unzip -l $NAME

popd
