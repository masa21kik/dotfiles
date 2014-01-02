;; -*- coding: utf-8 -*-
;;;=====================================
;; キーの割り付け
;;;=====================================
;; ESC-"key"
(global-set-key (kbd "M-g") 'goto-line)                    ;カーソルの移動
(global-set-key (kbd "M-l") 'what-line)                    ;カーソルの位置
;; Ctrl-x "key"
(global-set-key (kbd "C-x c") 'comment-region)             ;コメントアウト
(global-set-key (kbd "C-x v") 'uncomment-region)           ;コメントイン
;; \CはCtrl
(global-set-key (kbd "C-o") 'scroll-down)                   ;スクロールダウン
(global-set-key (kbd "C-h") 'backward-delete-char)          ;C-h を BS にする
(global-set-key (kbd "C-m") 'newline-and-indent)            ;改行キー(C-m)でオートインデント
;; home end キーでの移動
(global-set-key (kbd "<end>") 'end-of-buffer)
(global-set-key (kbd "<home>") 'beginning-of-buffer)
;; compile set-up (make)
;; (global-set-key (kbd "M-m") 'compile)
(global-set-key (kbd "M-k") 'kill-compilation)
(setq compile-command "make ")
;; カーソル行の単語をコピー，grep
(ffap-bindings)
(global-set-key (kbd "M-c") 'ffap-copy-string-as-kill)
;; indent
(global-set-key (kbd "M-_") 'indent-region)

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
(global-set-key (kbd "C-c G") 'grep-find-current-word)

