#!/bin/bash

VERSION=24.3
TMP_DIR=/tmp/install_emacs
PREFIX=~/local/emacs-$VERSION
PWD=`pwd`

mkdir -p $TMP_DIR
cd $TMP_DIR
wget http://ftp.jaist.ac.jp/pub/GNU/emacs/emacs-$VERSION.tar.gz
tar xzf emacs-$VERSION.tar.gz
cd emacs-$VERSION
./configure --without-all --prefix=$PREFIX
make
make install
cd $PWD

echo 'export PATH='$PREFIX'/bin:$PATH' >> $HOME/.zsh_local

