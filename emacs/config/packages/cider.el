(defvar cider-show-error-buffer)
(defvar cider-repl-mode-map)
(defvar cider-repl-tab-command)
(defvar cider-repl-pop-to-buffer-on-connect)

(defun antho/cider-repl-mode-keybindings()
    (define-key cider-repl-mode-map (kbd "C-j") 'cider-repl-next-input)
    (define-key cider-repl-mode-map (kbd "C-k") 'cider-repl-previous-input))
    
(add-hook 'cider-repl-mode-hook 'antho/cider-repl-mode-keybindings)
(setq cider-repl-tab-command #'indent-for-tab-command)
(setq cider-repl-pop-to-buffer-on-connect nil)

(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
;; (add-hook 'cider-repl-mode-hook #'smartparens-strict-mode)

(setq cider-show-error-buffer nil)

;;TODO user evil-leader
;;TODO newline in nrepl with smartparens

(defun antho/cider-figwheel-repl ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/cljs-repl)")
    (cider-repl-return)))

