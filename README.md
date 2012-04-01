# linux_conf
## 概要

Linuxでの自分用環境設定ファイルのインストールスクリプト．
新しい環境にzsh, screen, emacsなどを一発設定することを目的としています．
利用にはruby(1.8以上)が必要です．

## 使い方

    $ git clone https://github.com/masa21kik/linux_conf.git
    $ cd linux_conf.git
    $ ./install.rb

上記コマンドで~/ 以下に .zshrc .zshenv .screenrc .emacs .irbrc  と ~/local/bin にlintツールをインストールします．
これらはlinux_conf以下のファイルへのシンボリックリンクとしてインストールされます．
そのため同名ファイルがある場合はあらかじめ削除しておく必要があります．
