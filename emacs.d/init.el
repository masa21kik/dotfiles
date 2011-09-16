;; -*- coding: utf-8 -*-
;;==============================================================
;;
;; .emacs by kikuchi
;;
;; Time-stamp: <2011-09-16 15:25:07 kikuchi>
;;
;;==============================================================

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

;; ~/.emacs.d/elisp を load-path の先頭に加える
(setq load-path
      (append
       (list
		(expand-file-name "~/.emacs.d/elisp/")
		)
       load-path))

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
(setq-default tab-width 4)

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

;;;=====================================
;; キーの割り付け
;;;=====================================
;; ESC-"key"
(define-key esc-map "g" 'goto-line)                    ;カーソルの移動
(define-key esc-map "l" 'what-line)                    ;カーソルの位置
;; Ctrl-x "key"
(define-key ctl-x-map "c" 'comment-region)             ;コメントアウト
(define-key ctl-x-map "v" 'uncomment-region)           ;コメントイン
;; \CはCtrl
(global-set-key "\C-o" 'scroll-down)                   ;スクロールダウン
(global-set-key "\C-h" 'backward-delete-char)          ;C-h を BS にする
(global-set-key "\C-m" 'newline-and-indent)            ;改行キー(C-m)でオートインデント
;; home end キーでの移動
(global-set-key [end]  'end-of-buffer )
(global-set-key [home] 'beginning-of-buffer )
;; compile set-up (make)
(define-key esc-map "m" 'compile)
(define-key esc-map "k" 'kill-compilation)
(setq compile-command "make ")
;; カーソル行の単語をコピー，grep
(ffap-bindings)
(global-set-key "\M-c" 'ffap-copy-string-as-kill)

(defun grep-find-current-word ()
  (interactive)
  (let ((command "find . -type f -print0 | xargs -0 -e grep -n -e "))
    (ffap-copy-string-as-kill)
    (grep-find (format "%s %s"
                       command (car kill-ring)))))
(define-key global-map "\C-cG" 'grep-find-current-word)

;;;=====================================
;;; auto-mode
;;;=====================================
(setq auto-mode-alist
      (append '(("makefile$"  . makefile-mode)
                ("Makefile$" . makefile-mode)
                ("\\.mk$" . makefile-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.c$" . c++-mode)
                ("\\.h$" . c++-mode)
                ("\\.rb$" . ruby-mode)
                ("\\.html$" . html-mode)
                ("\\.yaml$" . yaml-mode)
                ("\\.js$" . javascript-mode)
                ("\\.py$" . python-mode)
                ("scons" . python-mode)
				(".emacs" . emacs-lisp-mode)
				(".mule" . emacs-lisp-mode)
				) auto-mode-alist))

;;;====================================
;; C-mode
;;;====================================
(defun my-c-mode-common-hook ()
  (c-set-style "linux")					;linux 式がいいとき
  ;; (c-set-style "k&r")                ;k&r式がいいときはこれを有効にする
  ;; (c-set-style "gnu")                ;デフォルトの設定
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  ;(c-toggle-auto-state t)
  )
(add-hook 'c++-mode-hook 'my-c-mode-common-hook)

;;=========================================
;; ruby-mode
;;=========================================
(add-hook 'ruby-mode-hook
          '(lambda ()
			 (setq tab-width 2)
			 (setq indent-tabs-mode 'nil)
			 (setq ruby-indent-level tab-width)
			 )
		  )

;;=========================================
;; yaml-mode
;;=========================================
(require 'yaml-mode)
(add-hook 'yaml-mode-hook
		  '(lambda ()
			 (define-key yaml-mode-map "\C-m" 'newline-and-indent))
		  '(lambda ()
			 (setq tab-width 4)))

;;=========================================
;; changelog-mode
;;=========================================
;; メモファイルを自動的に開いて日付入力
(defun memo ()
  (interactive)
  (add-change-log-entry
   nil
   (expand-file-name "~/memo/diary.txt")))
(define-key ctl-x-map "M" 'memo)

;;=========================================
;; テンプレート
;;=========================================
;; テンプレートの保存先
(setq auto-insert-directory "~/.emacs.d/template/")
(auto-insert-mode 1)
;; テンプレート挿入時に尋ねない
(setq auto-insert-query nil)

(setq auto-insert-alist
	  (append '(
				(ruby-mode  . "rb")
				(c++-mode   . "c")
				(text-mode  . "txt")
				(html-mode  . "html")
				(makefile-mode . "makefile")
				) auto-insert-alist))

;; GNU global
(when (locate-library "gtags") (require 'gtags))
(global-set-key "\M-." 'gtags-find-tag)     ;関数の定義元へ
(global-set-key "\M-r" 'gtags-find-rtag)    ;関数の参照先へ
(global-set-key "\M-s" 'gtags-find-symbol)  ;変数の定義元/参照先へ
(global-set-key "\M-f" 'gtags-find-file)    ;ファイルにジャンプ
(global-set-key "\M-*" 'gtags-pop-stack)   ;前のバッファに戻る
(add-hook 'c-mode-common-hook
		  '(lambda ()
			 (gtags-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; meadowの場合は設定を切替
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (featurep 'meadow)
	(load "~/.emacs.d/emacs.meadow.el")
  (load "~/.emacs.d/emacs.linux.el")
  )
;;;
;;; end of file
;;;
