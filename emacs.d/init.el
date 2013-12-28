;; -*- coding: utf-8 -*-
;;;=====================================
;; ロードパス追加設定
;;;=====================================
(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d/elisp/")
        (expand-file-name "~/.emacs.d/elisp/el-get/el-get/")
        )
       load-path))

;;;=====================================
;; el-get事前設定
;;;=====================================
(load "~/.emacs.d/prelude-get-el.el")

;;;=====================================
;; init loader
;;;=====================================
(require 'init-loader)
;; (setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
