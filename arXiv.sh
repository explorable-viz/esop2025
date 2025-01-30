#!/bin/bash
set -xe

NAME=arXiv.zip
TARGET=arXiv
FOLDER=esop2025

pdflatex $TARGET
biber $TARGET
rm -f $TARGET.aux $TARGET.dvi $TARGET.log $TARGET.blg $TARGET.out $TARGET.pag $TARGET.cb $TARGET.cb2 $TARGET.toc $TARGET.bcf $TARGET.run.xml

pushd ..

zip -r - $NAME $FOLDER > $NAME

zip -d $NAME \*.zip
zip -d $NAME \*.pdf
zip -d $NAME \*.DS_Store
zip -d $NAME \*.gitignore
zip -d $NAME \*.gitmodules
zip -d $NAME \*.purs-repl
zip -d $NAME $FOLDER/appendix.tex
zip -d $NAME $FOLDER/main-full.tex
# zip -d $NAME $FOLDER/main.tex
# zip -d $NAME $FOLDER/paper.tex
zip -d $NAME $FOLDER/inductive-graphs.tex
zip -d $NAME $FOLDER/author-response/\*
zip -d $NAME $FOLDER/Benchmarks/\*
# zip -d $NAME $FOLDER/tex-common/bib.bib
zip -d $NAME $FOLDER/.git/\*
zip -d $NAME $FOLDER/venv/\*
zip -d $NAME $FOLDER/mechanisation/\*
zip -d $NAME $FOLDER/obsolete/\*
zip -d $NAME $FOLDER/Talk/\*
zip -d $NAME $FOLDER/.vscode/\*

ls -al $NAME
unzip -l $NAME

popd
