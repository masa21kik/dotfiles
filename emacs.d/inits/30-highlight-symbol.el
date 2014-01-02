;; -*- coding: utf-8 -*-
;;;=====================================
;; highlight-symbol
;; http://shibayu36.hatenablog.com/entry/2013/12/30/190354
;;;=====================================
(require 'highlight-symbol)

;; 使いたい色を設定、repeatしてくれる
(setq highlight-symbol-colors '("DarkOrange" "DodgerBlue1" "DeepPink1"))

;; 適宜keybindの設定
(global-set-key (kbd "<f3>") 'highlight-symbol-at-point)
(global-set-key (kbd "<f4>") 'highlight-symbol-remove-all)
