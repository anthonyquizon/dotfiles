
(global-set-key (kbd "C-x C-d") 'dired)

(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(add-hook 'dired-mode-hook 'auto-revert-mode)

(defun antho/dired-mode-keybindings ()
  (define-key dired-mode-map (kbd "C-j") 'evil-next-line)
  (define-key dired-mode-map (kbd "C-k") 'evil-previous-line)
  (define-key dired-mode-map (kbd "C-h") 'evil-backward-char)
  (define-key dired-mode-map (kbd "C-l") 'evil-forward-char)
  (define-key dired-mode-map (kbd "g") nil)
  (define-key dired-mode-map (kbd "G") nil)
  (define-key dired-mode-map (kbd "r") 'revert-buffer))
   
(add-hook 'dired-mode-hook 'antho/dired-mode-keybindings)
