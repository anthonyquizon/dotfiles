(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
    package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
    package-archives)

(package-initialize)

(require 'cl)

(defvar antho/packages
  '(ac-cider
    ac-helm
    ac-nrepl
    cider
    clojure-mode
    evil
    evil-escape
    evil-leader
    evil-tabs
    helm
    helm-ag
    helm-projectile
    key-chord
    org
    colorsarenice-theme
    emmet-mode
    helm-emmet
    exec-path-from-shell
    flycheck
    magit
    yaml-mode
    evil-surround
    json-mode
    json-reformat
    haskell-mode
    less-css-mode
    evil-easymotion
    powerline
    linum-relative
    auto-complete)
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


(load "~/.emacs.d/config/packages/autocomplete.el")
(load "~/.emacs.d/config/packages/cider.el")
(load "~/.emacs.d/config/packages/dired-mode.el")
(load "~/.emacs.d/config/packages/emmet-mode.el")
(load "~/.emacs.d/config/packages/eshell-mode.el")
(load "~/.emacs.d/config/packages/evil-leader-mode.el")
(load "~/.emacs.d/config/packages/evil-mode.el")
(load "~/.emacs.d/config/packages/evil-surround-mode.el")
(load "~/.emacs.d/config/packages/exec-path-from-shell.el")
(load "~/.emacs.d/config/packages/flymake-mode.el")
(load "~/.emacs.d/config/packages/haskell-mode.el")
(load "~/.emacs.d/config/packages/helm.el")
(load "~/.emacs.d/config/packages/magit.el")
(load "~/.emacs.d/config/packages/powerline.el")
(load "~/.emacs.d/config/packages/projectile.el")
;;(load "~/.emacs.d/config/packages/linum.el")
