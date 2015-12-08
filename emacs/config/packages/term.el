(setq multi-term-program "/bin/zsh")

;; (defun antho/term-mode-keybindings ()
;;   ;; (define-key term-mode-map (kbd "C-j") nil)
;;   ;; (define-key term-mode-map (kbd "C-k") nil)
;;   (define-key term-raw-map [C-j] 'term-send-down)
;;   (define-key term-raw-map [C-k] 'term-send-up))
;;   ;; (define-key term-mode-map (kbd "C-j") 'term-send-down)
;;   ;; (define-key term-mode-map (kbd "C-k") 'term-send-up))
   
;; (add-hook 'term-mode-hook 'antho/term-mode-keybindings)

(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("C-j" . term-send-down))
            (add-to-list 'term-bind-key-alist '("C-k" . term-send-up))))
