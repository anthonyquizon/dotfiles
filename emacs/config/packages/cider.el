(defun antho/cider-repl-mode-keybindings()
    (define-key cider-repl-mode-map (kbd "C-j") 'cider-repl-next-input)
    (define-key cider-repl-mode-map (kbd "C-k") 'cider-repl-previous-input))
    
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'antho/cider-repl-mode-keybindings)
;; (setq cider-show-error-buffer 'only-in-repl)
(setq cider-show-error-buffer nil)

(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(defun antho/search-keybinding()
  (interactive)
  ;;TODO check if visual mode
  (evil-ex (concat "%s/" (thing-at-point 'word) "/")))

(defun antho/search-keybinding-empty()
  (interactive)
  ;;TODO check if visual mode
  (evil-ex (concat "%s/")))
