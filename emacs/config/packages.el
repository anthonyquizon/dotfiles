(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
    package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
    package-archives)

(package-initialize)

(require 'cl)

(defvar antho/packages
  '(
    ;; evil-smartparens
    ;; smartparens
    company
    cider
    clojure-mode
    colorsarenice-theme
    emmet-mode
    evil
    evil-easymotion
    evil-escape
    evil-leader
    evil-surround
    evil-tabs
    exec-path-from-shell
    flycheck
    haskell-mode
    helm
    helm-ag
    helm-emmet
    helm-projectile
    js2-mode
    json-mode
    json-reformat
    key-chord
    less-css-mode
    linum-relative
    magit
    org
    powerline
    rainbow-delimiters
    web-mode
    yaml-mode
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
;;(load "~/.emacs.d/config/packages/linum.el")

