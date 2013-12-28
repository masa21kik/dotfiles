;; -*- coding: utf-8 -*-
;;;=====================================
;; el-get事前設定
;;;=====================================
(setq el-get-dir "~/.emacs.d/elisp/el-get/")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;
;; recipe
;;
(setq el-get-sources
      '(
        (:name init-loader
               :type github
               :pkgname "emacs-jp/init-loader")
        (:name package
               :type http
               ;; http://bit.ly/pkg-el23
               :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el")
        ))

;;
;; install base packages
;;
(defvar installing-base-el-get-package-list
  '(init-loader)
  "A list of base packages to install from el-get at launch.")
(el-get 'sync installing-base-el-get-package-list)

;;
;; package.elがない場合は追加インストール
;;
(when (not (locate-library "package"))
  (defvar el-get-package-el '(package) "package.el")
  (el-get 'sync el-get-package-el))
