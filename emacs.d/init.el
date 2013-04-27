;; -*- coding: utf-8 -*-
;;==============================================================
;;
;; .emacs by kikuchi
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

;; ELPA設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

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

;; 大文字化[C-x C-u]，小文字化[C-x C-l]の時，問い合わせなしで実行
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

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
(global-set-key [end]  'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)
;; compile set-up (make)
;; (define-key esc-map "m" 'compile)
(define-key esc-map "k" 'kill-compilation)
(setq compile-command "make ")
;; カーソル行の単語をコピー，grep
(ffap-bindings)
(global-set-key "\M-c" 'ffap-copy-string-as-kill)
;; indent
(global-set-key "\M-_" 'indent-region)

(defun grep-find-current-word ()
  (interactive)
  (let ((command "find . -type f -print0 | xargs -0 -e grep -n -e "))
    (ffap-copy-string-as-kill)
    (grep-find (format "%s %s"
                       command (car kill-ring)))))
(define-key global-map "\C-cG" 'grep-find-current-word)

;; ファイルの種類に応じてコンパイル
(require 'smart-compile)
(define-key esc-map "m" 'smart-compile)
(define-key esc-map "n" 'next-error)
(define-key esc-map "p" 'previous-error)
(setq compilation-window-height 10)

;;;=====================================
;;; auto-mode
;;;=====================================
(setq auto-mode-alist
      (append '(("\\(m\\|M\\)akefile$"  . makefile-mode)
                ("\\.mk$" . makefile-mode)
                ("\\.\\(cpp\\|hpp\\|c\\|h\\)$" . c++-mode)
                ("\\.\\(rb\\|ru\\)$" . ruby-mode)
                ("\\(Rakefile\\|Gemfile\\|Capfile\\)" . ruby-mode)
                ("\\.erb$" . rhtml-mode)
                ("\\.html$" . web-mode)
                ("\\.yaml$" . yaml-mode)
                ("\\.\\(js\\|json\\)$" . js2-mode)
                ("\\.py$" . python-mode)
                ("scons" . python-mode)
                ("SConstruct" . python-mode)
                ("\\.\\(emacs\\|mule\\)" . emacs-lisp-mode)
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
;; (add-hook 'c++-mode-hook 'my-c-mode-common-hook)

;; google-c-style
(require 'google-c-style)
(add-hook 'c++-mode-hook
		  '(lambda ()
			 ;; (setq indent-tabs-mode t)
			 (setq tab-width 4)
			 (setq c-basic-offset tab-width)
			 (c-set-offset 'inextern-lang 0)
			 (c-set-offset 'label '-)
			 (c-set-offset 'case-label 0)
			 (c-set-offset 'access-label '-)))
(add-hook 'c++-mode-hook 'google-set-c-style)
(add-hook 'c++-mode-hook 'google-make-newline-indent)


;;=========================================
;; ruby-mode
;;=========================================
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq indent-tabs-mode 'nil)
             (setq ruby-indent-level tab-width)
             (setq ruby-deep-indent-paren nil)
             (setq ruby-deep-indent-paren-style nil)
             (setq ruby-deep-arglist nil)
             )
          )

;; 閉じ括弧のインデントを修正する設定
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; rinari.el for Rails
(require 'rinari)

;;=========================================
;; rhtml-mode
;;=========================================
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
		  (lambda () (rinari-launch)))

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
;; js2-mode
;;=========================================
(require 'js2-mode)

;;=========================================
;; web-mode
;;=========================================
(require 'web-mode)

;;; emacs 23以下の互換
(when (< emacs-major-version 24)
  (defalias 'prog-mode 'fundamental-mode))

;;; インデント数
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset   2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2))
(add-hook 'web-mode-hook 'web-mode-hook)

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

;;;====================================
;; yasnippet
;;;====================================
(require 'yasnippet-bundle)
;; (yas/initialize)
;; (yas/load-directory "~/.emacs.d/yasnippet/snippets")
;; (yas/load-directory "~/.emacs.d/yasnippet/yasnippets-rails/rails-snippets")
(setq yas/global-mode t)

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
				("\\.h$"    . ["h" my-c-template])
				(c++-mode   . ["c" my-c-template])
				(text-mode  . "txt")
				(web-mode  . "html")
				(makefile-mode . "makefile")
				) auto-insert-alist))

(defvar template-replacements-alists
  '(("%file%" . (lambda () (file-name-nondirectory (buffer-file-name))))
	("%auther%" . (lambda () (user-login-name)))
	("%year%" . (lambda () (substring (current-time-string) -4)))
	("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
	("%namespace%" . (lambda () (upcase (car (split-string (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) "_")))))
    ("%include-guard%"    . (lambda () (format "_%s_H" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

(defun my-c-template ()
  (time-stamp)
  (setq copy-replacements-alists (copy-alist template-replacements-alists))
  (nconc copy-replacements-alists
		 '(("%commentout%" . (lambda () #("//")))))
  (if (file-readable-p "~/local/template/copyright.txt")
	  (insert-file-contents "~/local/template/copyright.txt"))
  (mapc #'(lambda(c)
			(progn
			  (goto-char (point-min))
			  (replace-string (car c) (funcall (cdr c)) nil)))
		copy-replacements-alists)
  (goto-char (point-max))
  (message "done."))

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
