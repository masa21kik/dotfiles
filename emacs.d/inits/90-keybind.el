;; -*- coding: utf-8 -*-
;;;=====================================
;; キーの割り付け
;;;=====================================
;; ESC-"key"
(define-key esc-map "g" 'goto-line)                    ;カーソルの移動
(define-key esc-map "l" 'what-line)                    ;カーソルの位置
;; Ctrl-x "key"
(define-key ctl-x-map "c" 'comment-region)             ;コメントアウト
(define-key ctl-x-map "v" 'uncomment-region)           ;コメントイン
;; \CはCtrl
(global-set-key "\C-o" 'scroll-down)                   ;スクロールダウン
(global-set-key "\C-h" 'backward-delete-char)          ;C-h を BS にする
(global-set-key "\C-m" 'newline-and-indent)            ;改行キー(C-m)でオートインデント
;; home end キーでの移動
(global-set-key [end]  'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)
;; compile set-up (make)
;; (define-key esc-map "m" 'compile)
(define-key esc-map "k" 'kill-compilation)
(setq compile-command "make ")
;; カーソル行の単語をコピー，grep
(ffap-bindings)
(global-set-key "\M-c" 'ffap-copy-string-as-kill)
;; indent
(global-set-key "\M-_" 'indent-region)

;; ESC 連打で無効化
(global-set-key (kbd "M-ESC ESC") 'keyboard-quit)

;; 大文字化[C-x C-u]，小文字化[C-x C-l]の時，問い合わせなしで実行
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(defun grep-find-current-word ()
  (interactive)
  (let ((command "find . -type f -print0 | xargs -0 -e grep -n -e "))
    (ffap-copy-string-as-kill)
    (grep-find (format "%s %s"
                       command (car kill-ring)))))
(define-key global-map "\C-cG" 'grep-find-current-word)

