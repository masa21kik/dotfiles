;; -*- coding: utf-8 -*-
;;;=====================================
;; popwin
;;;=====================================
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(push '("\*helm-mode.*" :regexp t :height 0.5) popwin:special-display-config)
