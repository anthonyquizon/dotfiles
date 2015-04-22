

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
    org colorsarenice-theme emmet-mode helm-emmet exec-path-from-shell
    flycheck magit perspective persp-projectile)
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

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq-default indent-tabs-mode nil)
(show-paren-mode t)
		   
(setenv "PATH" (concat (getenv "PATH") ":/Users/anthonyquizon/.npm-packages/bin"))
(setq exec-path (append exec-path '("/Users/anthonyquizon/.npm-packages/bin")))

;;;=== Registers ===
;;http://www.gnu.org/software/emacs/manual/html_node/emacs/Registers.html
(set-register ?e (cons 'file "~/.emacs"))

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

(global-set-key "\C-x\ \C-r" 'helm-recentf)

(define-key helm-map (kbd "<tab>") nil)
(define-key helm-map (kbd "C-l") nil)
(define-key helm-map (kbd "C-h") nil) 
(define-key helm-map (kbd "C-z") nil)
(define-key helm-map (kbd "C-j") nil)
(define-key helm-map (kbd "C-k") nil)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-map (kbd "C-z") 'helm-select-action)
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)
    
(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-find-files-map (kbd "C-z") 'helm-select-action)
(define-key helm-find-files-map (kbd "C-j") 'helm-next-line)
(define-key helm-find-files-map (kbd "C-k") 'helm-previous-line)

(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-read-file-map (kbd "C-z") 'helm-select-action)
(define-key helm-read-file-map (kbd "C-j") 'helm-next-line)
(define-key helm-read-file-map (kbd "C-k") 'helm-previous-line)

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
  "e" 'eshell
  "p" 'mode-line-other-buffer)

;;=== Projectile ====
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;==== Emmet ====
;;(define-key emmet-mode (kbd "C-l") 'emmet-expand-line)


;;==== Flymake ===
(add-hook 'after-init-hook #'global-flycheck-mode)

;;==== Projectile ===
(projectile-global-mode)
(helm-projectile-on)

;;=== Perspective ====
(persp-mode)

(define-key projectile-mode-map (kbd "C-x x h") 'projectile-persp-switch-project)
