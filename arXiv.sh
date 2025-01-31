#!/bin/bash
set -xe

NAME=arXiv.zip
TARGET=arXiv
FOLDER=esop2025
ARCHIVE="../$NAME"

pdflatex $TARGET
biber $TARGET
rm -f $TARGET.aux $TARGET.dvi $TARGET.log $TARGET.blg $TARGET.out $TARGET.pag $TARGET.cb $TARGET.cb2 $TARGET.toc $TARGET.bcf $TARGET.run.xml

# pushd ..

# zip -r - $NAME $FOLDER > $NAME
zip -r - . > $ARCHIVE

# zip -d $ARCHIVE \*.zip
zip -d $ARCHIVE \*.pdf
zip -d $ARCHIVE \*.DS_Store
zip -d $ARCHIVE \*.gitignore
zip -d $ARCHIVE \*.gitmodules
zip -d $ARCHIVE \*.purs-repl
zip -d $ARCHIVE appendix.tex
zip -d $ARCHIVE main-full.tex
# zip -d $ARCHIVE $main.tex
# zip -d $ARCHIVE $paper.tex
zip -d $ARCHIVE inductive-graphs.tex
zip -d $ARCHIVE author-response/\*
zip -d $ARCHIVE Benchmarks/\*
# zip -d $ARCHIVE $tex-common/bib.bib
zip -d $ARCHIVE .git/\*
zip -d $ARCHIVE venv/\*
zip -d $ARCHIVE mechanisation/\*
zip -d $ARCHIVE obsolete/\*
zip -d $ARCHIVE Talk/\*
zip -d $ARCHIVE .vscode/\*

ls -al $ARCHIVE
unzip -l $ARCHIVE

# popd
