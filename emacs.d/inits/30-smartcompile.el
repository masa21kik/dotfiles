;; -*- coding: utf-8 -*-
;;;=====================================
;; smart-compile
;;;=====================================
;; ファイルの種類に応じてコンパイル
(require 'smart-compile)
(define-key esc-map "m" 'smart-compile)
(define-key esc-map "n" 'next-error)
(define-key esc-map "p" 'previous-error)
(setq compilation-window-height 10)
