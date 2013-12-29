;; -*- coding: utf-8 -*-
;;;=====================================
;; helm
;;;=====================================
(require 'helm)
(require 'helm-config)

(helm-mode 1)
(setq helm-samewindow nil)

;; helm-modeを部分的に無効化
(setq helm-completing-read-handlers-alist
      (append '((find-file . nil)
                (find-file-at-point . nil)
                (write-file . nil)
                (basic-save-buffer . nil)
                )))

;; C-hで一文字削除になるように
(define-key helm-map (kbd "C-h") 'delete-backward-char)
