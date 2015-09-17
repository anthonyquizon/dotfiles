(global-set-key (kbd "C-x C-d") 'dired)

;;(evil-set-initial-state 'dired-mode 'normal)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(add-hook 'dired-mode-hook 'auto-revert-mode)

(defun antho/dired-mode-keybindings ()
  ;; TODO add file
  ;; TODO add folder
  (define-key dired-mode-map (kbd "v") 'evil-visual-char)
  (define-key dired-mode-map (kbd "g") nil)
  (define-key dired-mode-map (kbd "G") nil)
  (define-key dired-mode-map (kbd "r") 'revert-buffer))
   
(add-hook 'dired-mode-hook 'antho/dired-mode-keybindings)
