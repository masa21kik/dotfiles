;; -*- coding: utf-8 -*-
;;;=====================================
;; yassnipet
;;;=====================================
(require 'yasnippet)

(yas-global-mode 1)
(custom-set-variables '(yas-trigger-key "TAB"))

;; プレフィックスキーを C-x ; に設定する
(custom-set-variables '(helm-command-prefix-key "C-x ;"))

;; helm interface
(eval-after-load "helm-config"
  '(progn
     (defun my-yas/prompt (prompt choices &optional display-fn)
       (let* ((names (loop for choice in choices
                           collect (or (and display-fn (funcall display-fn choice))
                                       choice)))
              (selected (helm-other-buffer
                         `(((name . ,(format "%s" prompt))
                            (candidates . names)
                            (action . (("Insert snippet" . (lambda (arg) arg))))))
                         "*helm yas/prompt*")))
         (if selected
             (let ((n (position selected names :test 'equal)))
               (nth n choices))
           (signal 'quit "user quit!"))))
     (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
     (define-key helm-command-map (kbd "y") 'yas/insert-snippet))
  )
