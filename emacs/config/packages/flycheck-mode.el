(defvar flycheck-display-errors-function)

(add-hook 'after-init-hook #'global-flycheck-mode)

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(eval-after-load 'flycheck '(flycheck-clojure-setup))
(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))


