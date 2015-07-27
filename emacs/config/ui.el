
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

(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

(setq-default indent-tabs-mode nil)
(show-paren-mode t)

;; Keys
(setq mac-command-modifier 'super)
(global-set-key (kbd "s-<right>") 'move-end-of-line)
(global-set-key (kbd "s-<left>") 'move-beginning-of-line)

(define-key input-decode-map "\e[1;5A" [C-up])
(define-key input-decode-map "\e[1;5B" [C-down])

;; Theme
(load-theme 'colorsarenice-dark t)

;; Open finder
(defun open-finder()
  (interactive)
  (shell-command-on-buffer 'open .'))
