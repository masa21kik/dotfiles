;; -*- coding: utf-8 -*-
;;;=====================================
;; el-get設定
;;;=====================================

;; package.elで入らないものをインストール
(defvar installing-el-get-package-list
  '(
    js2-mode
    )
  "A list of packages to install from el-get at launch.")

(el-get 'sync installing-el-get-package-list)
