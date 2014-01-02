;; -*- coding: utf-8 -*-
;;;=====================================
;; anzu
;; http://qiita.com/syohex/items/56cf3b7f7d9943f7a7ba
;;;=====================================
(global-anzu-mode +1)

(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000))

(defun my/anzu-update-func (here total)
  (propertize (format "<%d/%d>" here total)
              'face '((:foreground "yellow" :weight bold))))
(setq anzu-mode-line-update-function 'my/anzu-update-func)

(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "M-&") 'anzu-query-replace-regexp)
(global-set-key (kbd "M-'") 'anzu-query-replace-at-cursor-thing)
