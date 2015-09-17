(require 'smartparens-config)

(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)

(add-hook 'clojure-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook       #'smartparens-strict-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'smartparens-strict-mode)
(add-hook 'ielm-mode-hook             #'smartparens-strict-mode)
(add-hook 'lisp-mode-hook             #'smartparens-strict-mode)
(add-hook 'lisp-interaction-mode-hook #'smartparens-strict-mode)
(add-hook 'scheme-mode-hook           #'smartparens-strict-mode)

;;sp-unwrap-sexp
;; "pu" 'sp-unwrap-sexp
;; "pk" 'sp-add-to-previous-sexp
;; "pj" 'sp-unwrap-sexp


(define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-unwrap-sexp)
;; (define-key smartparens-mode-map (kbd "C-<backspace>") 'sp-down-sexp)

(define-key smartparens-mode-map (kbd "C-j") 'sp-down-sexp)
(define-key smartparens-mode-map (kbd "C-k") 'sp-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-J") 'sp-add-to-next-sexp)
(define-key smartparens-mode-map (kbd "C-M-K") 'sp-add-to-previous-sexp)
