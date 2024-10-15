#!/bin/bash
set -xe

NAME=arXiv.zip
TARGET=main-full

# pdflatex $TARGET
# biber $TARGET
# rm -f $TARGET.aux $TARGET.dvi $TARGET.log $TARGET.blg $TARGET.out $TARGET.pag $TARGET.cb $TARGET.cb2 $TARGET.toc

pushd ..

zip -r - $NAME graphical-slicing > $NAME

zip -d $NAME \*.zip
zip -d $NAME \*.pdf
zip -d $NAME \*.DS_Store
zip -d $NAME \*.gitignore
zip -d $NAME graphical-slicing/.git/\*
zip -d $NAME graphical-slicing/venv/\*
zip -d $NAME graphical-slicing/mechanisation/\*
zip -d $NAME graphical-slicing/obsolete/\*
zip -d $NAME graphical-slicing/Talk/\*

ls -al $NAME
unzip -l $NAME

popd
