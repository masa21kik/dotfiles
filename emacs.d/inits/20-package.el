;; -*- coding: utf-8 -*-
;;;=====================================
;; ELPA設定
;;;=====================================
(require 'cl)
(require 'package)
(setq package-user-dir "~/.emacs.d/elisp/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defvar installing-package-list
  '(
    markdown-mode
    rhtml-mode
    rspec-mode
    yaml-mode
    web-mode
    slim-mode

    google-c-style

    rinari
    git-gutter
    smart-compile

    popwin
    helm
    auto-complete
    yasnippet
    flycheck
    magit

    expand-region
    smartrep
    multiple-cursors
    highlight-symbol
    anzu
    )
  "A list of packages to install from MELPA at launch.")

(let ((not-installed (loop for x in installing-package-list
                           when (not (package-installed-p x))
                           collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

