;; -*- coding: utf-8 -*-

;; 日本語環境設定
(set-language-environment "Japanese")

;; utf-8で開く
(set-default-coding-systems     'utf-8-unix)
(set-buffer-file-coding-system  'utf-8-unix)
(set-terminal-coding-system     'utf-8-unix)
(prefer-coding-system           'utf-8-unix)
(set-keyboard-coding-system     'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq file-name-coding-system   'utf-8)

;; 起動時の画面はいらない
(setq inhibit-startup-message t)

;; メニューバー
(menu-bar-mode nil)          ; メニューバーはいらない。コマンドで十分

;; font-lockの設定
(global-font-lock-mode t)

;; 行，列番号を表示
(line-number-mode t)
(column-number-mode t)

;; タブ幅を 4 に設定
(setq-default tab-width 4 indent-tabs-mode nil)

;; 同一名の file を開いた時に区別出来る様にする。
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; 最終行からカーソルの移動で新規行が作成されるのを禁止する。
(setq next-line-add-newlines nil)

;; file の最後は 必ず newline で終わる様にする。
(setq require-final-newline t)

;; mouse で paste する際、mouse の位置ではなく cursor の位置に paste する。
(setq mouse-yank-at-point t)

;; 行末の空白を表示
(setq-default show-trailing-whitespace t)

;; バックアップファイルを作らない
(setq backup-inhibited t)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; 先頭から8行以内の Time-stamp: <> にタイムスタンプを自動挿入
(add-hook 'write-file-hooks 'time-stamp)

;;; ガベージコレクションの頻度を下げて高速化(デフォルトは 400000)
;(setq gc-cons-threshold 5242880)

;;;=====================================
;; color
;;;=====================================
;; 白地に黒字は 目が疲れるので、黒地に白字。
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color     "white")
;; 領域指定の色指定
(set-face-background 'region "dark slate gray")
(set-face-foreground 'region "moccasin")
(set-face-bold-p 'modeline nil)
(transient-mark-mode t)
(show-paren-mode 1)
