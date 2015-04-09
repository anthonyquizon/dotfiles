

; ==== packages =====
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
    package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
    package-archives)

(package-initialize)

(require 'cl)

(defvar antho/packages
  '(ac-cider ac-helm ac-nrepl cider clojure-mode evil evil-easymotion
    evil-escape evil-leader evil-tabs helm helm-projectile key-chord
    neotree org colorsarenice-theme flymake flymake-css flymake-jshint 
    flymake-json flymake-less flymake-sass)
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

(setq-default indent-tabs-mode nil)
		   
;=============

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq column-number-mode t)
(setq inhibit-startup-message t)

(global-linum-mode t)

(set-face-attribute 'default (selected-frame) :font "Monaco-14")
(add-to-list 'initial-frame-alist '(font . "Monaco-14"))
(add-to-list 'default-frame-alist '(font . "Monaco-14"))


(setq ring-bell-function 'ignore)
(setq bell-volume 0)

(add-to-list 'exec-path "/usr/local/bin")

(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

(defun eshell-mode-hook-func ()
  (setq eshell-path-env (concat "/usr/local/bin:" eshell-path-env))
  (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH"))))

(add-hook 'eshell-mode-hook 'eshell-mode-hook-func)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(define-key input-decode-map "\e[1;5A" [C-up])

;;override list buffer with dired mode
(global-set-key (kbd "C-x C-d") 'dired) 

(define-key input-decode-map "\e[1;5A" [C-up])
(define-key input-decode-map "\e[1;5B" [C-down])


(defun antho/dired-mode-keybindings () 
    (define-key dired-mode-map (kbd "g") nil)
    (define-key dired-mode-map (kbd "G") nil)
    (define-key dired-mode-map (kbd "r") 'revert-buffer))
   
(add-hook 'dired-mode-hook 'antho/dired-mode-keybindings)

;==== Theme =====
(load-theme 'colorsarenice-dark t)

;===== Evil Mode ======
(evil-mode 1)

(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)

(setq evil-emacs-state-cursor '(box))
(setq evil-normal-state-cursor '(box))
(setq evil-visual-state-cursor '(box))
(setq evil-insert-state-cursor '(bar))
(setq evil-replace-state-cursor '(hollow))


;===== Helm ======
(require 'helm-config)

(helm-mode 1)

;===== NeoTree ====
(setq neo-theme 'ascii)
(custom-set-faces
 '(neo-banner-face ((t . (:inherit shadow))) t)
 '(neo-header-face ((t . (:inherit shadow))) t)
 '(neo-root-dir-face ((t . (:inherit link-visited :underline nil))) t)
 '(neo-dir-link-face ((t . (:inherit dired-directory :underline nil))) t)
 '(neo-file-link-face ((t . (:inherit default :underline nil))) t)
 '(neo-button-face ((t . (:inherit dired-directory))) t)
 '(neo-expand-btn-face ((t . (:inherit button :underline nil))) t))

(defun antho/neotree-expand-or-open ()
  "Collapse a neotree node."
  (interactive)
  (let ((node (neo-buffer--get-filename-current-line)))
    (when node
      (if (file-directory-p node)
	  (progn
	    (neo-buffer--set-expand node t)
	    (neo-buffer--refresh t)
	    (when neo-auto-indent-point
	      (next-line)
	      (neo-point-auto-indent)))
	(call-interactively 'neotree-enter)))))

(defun antho/neotree-collapse ()
  "Collapse a neotree node."
  (interactive)
  (let ((node (neo-buffer--get-filename-current-line)))
    (when node
      (when (file-directory-p node)
	(neo-buffer--set-expand node nil)
	(neo-buffer--refresh t))
      (when neo-auto-indent-point
	(neo-point-auto-indent)))))

(defun antho/neotree-collapse-or-up ()
  "Collapse an expanded directory node or go to the parent node."
  (interactive)
  (let ((node (neo-buffer--get-filename-current-line)))
    (when node
      (if (file-directory-p node)
	  (if (neo-buffer--expanded-node-p node)
	      (antho/neotree-collapse)
	    (neotree-select-up-node))
	(neotree-select-up-node)))))

(defun antho/neotree-enter ()
  (interactive)
  (back-to-indentation)
  (neotree-enter))

(defun antho/neotree-key-bindings ()
  "Set the key bindings for a neotree buffer."
  (define-key evil-motion-state-local-map (kbd "v") 'neotree-enter-vertical-split)
  (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-horizontal-split)
  (define-key evil-motion-state-local-map (kbd "TAB") 'neotree-stretch-toggle)
  (define-key evil-motion-state-local-map (kbd "h") 'antho/neotree-collapse-or-up)
  (define-key evil-motion-state-local-map (kbd "l") 'antho/neotree-expand-or-open)
  (define-key evil-motion-state-local-map (kbd "RET") 'antho/neotree-enter)
  (define-key evil-motion-state-local-map (kbd "+") 'neotree-create-node)
  (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
  (define-key evil-normal-state-local-map (kbd "R") 'neotree-rename-node)
  (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
  (define-key evil-normal-state-local-map (kbd "i") 'neotree-hidden-file-toggle)
  (key-chord-define evil-motion-state-local-map "CD" 'neotree-dir)
  (key-chord-define evil-motion-state-local-map "cd" 'neotree-change-root))

(add-hook 'neotree-mode-hook 'antho/neotree-key-bindings)

; ==== Evil Leader ====
(global-evil-leader-mode)

;===== Cider ====
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(evil-leader/set-key
  "z" 'neotree-toggle
  "e" 'eshell
  "f"  'helm-recentf
  "p" 'mode-line-other-buffer)

(define-key evil-normal-state-map (kbd "C-w q") 'delete-window)

;=== Projectile ====
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

