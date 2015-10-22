(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
    package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
    package-archives)

(package-initialize)

(require 'cl)

(defvar antho/packages
  '(
    cider
    clojure-mode
    colorsarenice-theme
    company
    emmet-mode
    evil
    evil-easymotion
    evil-escape
    evil-leader
    evil-smartparens
    evil-surround
    evil-tabs
    exec-path-from-shell
    flycheck
    haskell-mode
    helm
    helm-ag
    helm-emmet
    helm-projectile
    idris-mode
    js2-mode
    json-mode
    json-reformat
    key-chord
    less-css-mode
    linum-relative
    magit
    multi-term
    org
    powerline
    purescript-mode
    rainbow-delimiters
    sass-mode
    smartparens
    web-mode
    yaml-mode
    ;; yasexpand
    )
  "List of packages to ensure are installed at launch")

(defun antho/packages-installed-p ()
  (loop for p in antho/packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(unless (antho/packages-installed-p)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")

  (dolist (p antho/packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'antho/packages)


(load "~/.emacs.d/config/packages/cider.el")
(load "~/.emacs.d/config/packages/dired-mode.el")
(load "~/.emacs.d/config/packages/electric-indent-mode.el")
(load "~/.emacs.d/config/packages/emmet-mode.el")
(load "~/.emacs.d/config/packages/eshell-mode.el")
(load "~/.emacs.d/config/packages/evil-leader-mode.el")
(load "~/.emacs.d/config/packages/evil-mode.el")
(load "~/.emacs.d/config/packages/evil-surround-mode.el")
(load "~/.emacs.d/config/packages/exec-path-from-shell.el")
(load "~/.emacs.d/config/packages/flymake-mode.el")
(load "~/.emacs.d/config/packages/haskell-mode.el")
(load "~/.emacs.d/config/packages/helm.el")
(load "~/.emacs.d/config/packages/js2-mode.el")
(load "~/.emacs.d/config/packages/magit.el")
(load "~/.emacs.d/config/packages/powerline.el")
(load "~/.emacs.d/config/packages/projectile.el")
(load "~/.emacs.d/config/packages/rainbow-delimiters.el")
(load "~/.emacs.d/config/packages/web-mode.el")
(load "~/.emacs.d/config/packages/company-mode.el")
(load "~/.emacs.d/config/packages/term.el")
(load "~/.emacs.d/config/packages/evil-smartparens.el")
(load "~/.emacs.d/config/packages/purescript-mode.el")
;; (load "~/.emacs.d/config/packages/yasexpand-mode.el")
(load "~/Development/env/dotfiles/emacs/config/packages/agda-mode/agda2.el")
;;(load "~/.emacs.d/config/packages/linum.el")
