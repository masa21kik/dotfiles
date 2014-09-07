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

# Patch for OSX
if [ `uname` == "Darwin" ]; then
  curl https://gist.github.com/anonymous/8553178/raw/c0ddb67b6e92da35a815d3465c633e036df1a105/emacs.memory.leak.aka.distnoted.patch.diff -o $TMP_DIR/emacs.patch.diff
  svn co http://svn.sourceforge.jp/svnroot/macemacsjp/inline_patch/trunk $TMP_DIR/inline_patch
  patch -p1 < $TMP_DIR/emacs.patch.diff
  patch -p0 < $TMP_DIR/inline_patch/emacs-inline.patch
fi

./configure --without-all --prefix=$PREFIX
make
make install
cd $PWD

echo 'export PATH='$PREFIX'/bin:$PATH' >> $HOME/.zsh_local

