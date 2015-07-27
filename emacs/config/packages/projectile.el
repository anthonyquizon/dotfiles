(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; keybindings
(define-key projectile-mode-map (kbd "C-x x h") 'projectile-persp-switch-project)
