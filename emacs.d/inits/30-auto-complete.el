;; -*- coding: utf-8 -*-
;;;=====================================
;; auto-complete
;;;=====================================
(require 'auto-complete-config)

(ac-config-default)
(setq ac-auto-start 1)
(setq ac-use-menu-map t)  ;; C-n/C-pで候補選択可能
;; (setq ac-auto-show-menu nil)  ポップアップを自動表示しない

(define-key ac-mode-map (kbd "M-\\") 'auto-complete)

;; ユーザ辞書設定
;; (add-to-list 'ac-user-dictionary-files "~/.emacs.d/ac-dict/dict")
