;; PATHS
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setenv "PATH" (concat (getenv "PATH") ":/Users/anthonyquizon/.npm-packages/bin"))
(setq exec-path (append exec-path '("/Users/anthonyquizon/.npm-packages/bin")))
(add-to-list 'exec-path "/usr/local/bin")

;;=== Registers ===
(set-register ?e (cons 'file "~/.emacs"))

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
