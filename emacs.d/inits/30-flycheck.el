;; -*- coding: utf-8 -*-
;;;=====================================
;; flycheck
;;;=====================================
(require 'flycheck)
(setq flycheck-highlighting-mode 'lines)

;; hook
(add-hook 'after-init-hook #'global-flycheck-mode)
