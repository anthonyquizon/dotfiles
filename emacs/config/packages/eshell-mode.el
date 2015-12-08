(eval-after-load 'esh-opt
  '(progn
    (defun antho/eshell-mode-hook()
      (setq eshell-path-env (concat "/usr/local/bin:" eshell-path-env))
      
      (define-key eshell-mode-map (kbd "C-j") 'eshell-next-input)
      (define-key eshell-mode-map (kbd "C-k") 'eshell-previous-input)
      (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH"))))

    (add-hook 'eshell-mode-hook 'antho/eshell-mode-hook)))
