;; (add-to-list 'load-path "~/Development/vendor/emacs/purescript-mode/")
;; (require 'purescript-mode-autoloads)
;; (add-to-list 'Info-default-directory-list "~/Development/vendor/emacs/purescript-mode/")

(add-hook 'purescript-mode-hook 'turn-on-purescript-indentation)
