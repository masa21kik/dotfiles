;; -*- coding: utf-8 -*-
;;;=====================================
;; multiple-cursors
;; http://shibayu36.hatenablog.com/entry/2013/12/30/190354
;;;=====================================
(require 'expand-region)
(require 'multiple-cursors)
(require 'smartrep)

(global-set-key (kbd "M-i") 'er/expand-region)
(global-set-key (kbd "C-M-i") 'er/contract-region)

(global-set-key (kbd "M-RET") 'mc/edit-lines)
(smartrep-define-key
 global-map "M-o"
 '(("C-n" . 'mc/mark-next-like-this)
   ("C-p" . 'mc/mark-previous-like-this)
   ("m"   . 'mc/mark-more-like-this-extended)
   ("u"   . 'mc/unmark-next-like-this)
   ("U"   . 'mc/unmark-previous-like-this)
   ("s"   . 'mc/skip-to-next-like-this)
   ("S"   . 'mc/skip-to-previous-like-this)
   ("*"   . 'mc/mark-all-like-this)
   ("d"   . 'mc/mark-all-like-this-dwim)
   ("i"   . 'mc/insert-numbers)
   ("o"   . 'mc/sort-regions)
   ("O"   . 'mc/reverse-regions)))
