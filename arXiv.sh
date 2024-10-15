#!/bin/bash
set -xe

NAME=arXiv.zip
# . build.sh

pushd ..

zip -r - $NAME graphical-slicing > $NAME

# zip -d $NAME *.zip
zip -d $NAME *.pdf
zip -d $NAME *.DS_Store
zip -d $NAME *.git
zip -d $NAME *.gitignore
zip -d $NAME graphical-slicing/Talk/\*

ls -al $NAME
unzip -l $NAME

popd
