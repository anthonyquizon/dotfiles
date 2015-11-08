(defun antho/cider-repl-mode-keybindings()
    (define-key cider-repl-mode-map (kbd "C-j") 'cider-repl-next-input)
    (define-key cider-repl-mode-map (kbd "C-k") 'cider-repl-previous-input))
    
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'antho/cider-repl-mode-keybindings)
;; (setq 'cider-show-error-buffer 'only-in-repl)
;; (setq 'cider-show-error-buffer nil)

(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;;TODO user evil-leader
(defun cider-figwheel-repl ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/cljs-repl)")
    (cider-repl-return)))

(defun figwheel-repl ()
  (interactive)
  (run-clojure "lein figwheel"))

;; (add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)
