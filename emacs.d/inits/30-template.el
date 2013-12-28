;; -*- coding: utf-8 -*-
;;=========================================
;; テンプレート
;;=========================================
;; テンプレートの保存先
(setq auto-insert-directory "~/.emacs.d/template/")
(auto-insert-mode 1)
;; テンプレート挿入時に尋ねない
(setq auto-insert-query nil)

(setq auto-insert-alist
	  (append '(
				(ruby-mode  . "rb")
				("\\.h$"    . ["h" my-c-template])
				(c++-mode   . ["c" my-c-template])
				(text-mode  . "txt")
				(web-mode  . "html")
				(makefile-mode . "makefile")
				) auto-insert-alist))

(defvar template-replacements-alists
  '(("%file%" . (lambda () (file-name-nondirectory (buffer-file-name))))
	("%auther%" . (lambda () (user-login-name)))
	("%year%" . (lambda () (substring (current-time-string) -4)))
	("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
	("%namespace%" . (lambda () (upcase (car (split-string (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) "_")))))
    ("%include-guard%"    . (lambda () (format "_%s_H" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

(defun my-c-template ()
  (time-stamp)
  (setq copy-replacements-alists (copy-alist template-replacements-alists))
  (nconc copy-replacements-alists
		 '(("%commentout%" . (lambda () #("//")))))
  (if (file-readable-p "~/local/template/copyright.txt")
	  (insert-file-contents "~/local/template/copyright.txt"))
  (mapc #'(lambda(c)
			(progn
			  (goto-char (point-min))
			  (replace-string (car c) (funcall (cdr c)) nil)))
		copy-replacements-alists)
  (goto-char (point-max))
  (message "done."))
