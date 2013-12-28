;; -*- coding: utf-8 -*-
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
                ("\\.\\(md\\|markdown\\)$" . markdown-mode)
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
;; rspec-mode
;;=========================================
(require 'rspec-mode)
(custom-set-variables '(rspec-use-rake-flag nil))
(global-set-key [f10] 'rspec-verify-single)
(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))
(ad-activate 'rspec-compile)

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
;; (require 'yasnippet-bundle)
;; (setq yas/global-mode t)

;;;====================================
;; git-gutter
;;;====================================
(global-git-gutter-mode t)

