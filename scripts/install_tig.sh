#!/bin/bash

TMP_DIR=/tmp/install_tig
PREFIX=$HOME/local
PWD=`pwd`

# install libncursesw5-dev

mkdir -p $TMP_DIR
cd $TMP_DIR
git clone https://github.com/jonas/tig.git
cd tig
LDLIBS=-lncursesw make prefix=$PREFIX
make install prefix=$PREFIX
cd $PWD
