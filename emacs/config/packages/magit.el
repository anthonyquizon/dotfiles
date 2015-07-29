

(evil-set-initial-state 'magit-log-edit-mode 'insert)
(evil-set-initial-state 'git-commit-mode 'insert)

(evil-set-initial-state 'magit-mode 'normal)
(evil-set-initial-state 'magit-status-mode 'normal)
(evil-set-initial-state 'magit-diff-mode 'normal)
(evil-set-initial-state 'magit-log-mode 'normal)

(evil-define-key 'normal magit-status-mode-map
  (kbd "C-m") 'magit-stage-item
  (kbd "s") 'magit-stage-item
  (kbd "r") 'magit-refresh
  (kbd "P") 'magit-push
  (kbd "p") 'magit-pull
  (kbd "u") 'magit-unstage-item
  (kbd "o") 'magit-visit-item
  (kbd "c") 'magit-key-mode-popup-committing)

