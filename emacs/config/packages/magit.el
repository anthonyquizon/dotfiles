
(global-set-key (kbd "C-c g") 'magit-status)

;; TODO evil mode bindings

;; Start to insert mode when editing commit messages
(evil-set-initial-state 'magit-log-edit-mode 'insert)
(evil-set-initial-state 'git-commit-mode 'insert)


(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
(evil-add-hjkl-bindings occur-mode 'emacs)

(eval-after-load "magit"
  '(progn
     (define-key evil-normal-state-map (kbd "C-w h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-w j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-w k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-w l") 'evil-window-right)))

;; This should already exist in your custom.el file.
(custom-set-variables
 ;; This should also already exist, you'll want to append onto the
 ;; long list of modes.
 '(evil-emacs-state-modes (quote (magit-commit-mode magit-log-mode magit-stash-mode magit-status-mode))))
