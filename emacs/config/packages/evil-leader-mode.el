(global-evil-leader-mode)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "d" 'dired
  "f" 'find-file
  "o" 'mode-line-other-buffer
  "x" 'execute-extended-command
  "m" 'helm-recentf
  
  
  "T" 'multi-term
  "tt" 'multi-term
  "tn" 'multi-next
  "tp" 'multi-prev
  "tk" 'term-kill-subjob
  "tc" 'term-interrupt-subjob
  "td" 'term-send-eof
  
  "E" 'eshell
  "en" 'eshell ;;TODO make new eshell command
  "ek" 'eshell-kill-process
  "ec" 'eshell-interrupt-process
  "ed" 'eshell-send-eof-to-process
  "eh" 'helm-eshell-history
  
  "bl" 'helm-buffers-list
  "be" 'eval-buffer
  "bk" 'kill-buffer
  
  "ls" 'sort-lines
  "ll" 'evil-lookup
  
  "ss" 'antho/search-keybinding-empty
  "sr" 'antho/search-keybinding

  "gg" 'magit-status
  
  "wc" 'evil-window-delete
  "ws" 'evil-window-split
  "wv" 'evil-window-vsplit
  "wl" 'evil-window-right
  "wh" 'evil-window-left
  "wk" 'evil-window-up
  "wj" 'evil-window-down
  "wL" 'evil-window-move-far-right
  "wH" 'evil-window-move-far-left
  "wK" 'evil-window-move-very-top
  "wJ" 'evil-window-move-very-bottom

  "<SPC>j" 'open-finder
  "<SPC>r" 'projectile-replace
  "<SPC>m" 'helm-projectile-recentf
  "<SPC>f" 'helm-projectile-find-file
  "<SPC>p" 'helm-projectile-switch-project
  "<SPC>b" 'helm-buffers-list
  "<SPC>s" 'helm-projectile-ag
  "<SPC>d" 'helm-projectile-find-dir
  "<SPC>g" 'magit-status
  
  "<RET>" 'helm-descbinds
  )

;;TODO remove duplication with modes

;;emacs-lisp-mode
(evil-leader/set-key-for-mode 'emacs-lisp-mode
  "," 'eval-last-sexp
  "." 'eval-defun
  "b," 'eval-buffer
  "b." 'eval-buffer
  )

;;lisp-mode
(evil-leader/set-key-for-mode 'lisp-mode
  "," 'eval-last-sexp
  "." 'eval-defun
  "b," 'eval-buffer
  "b." 'eval-buffer
  )

;; clojure
(evil-leader/set-key-for-mode 'clojure-mode
  "," 'cider-eval-last-sexp
  "." 'cider-eval-defun-at-point
  "b." 'cider-eval-file
  "b," 'cider-eval-file
  "cq" 'cider-quit
  "cr" 'cider-refresh
  "cR" 'cider-restart
  "cj" 'cider-switch-to-relevant-repl-buffer
  "cJ" 'cider-jack-in-clojurescript
  "ct" 'cider-test-run-test
  "cf" 'antho/cider-figwheel-repl
 )

(evil-leader/set-key-for-mode 'clojurescript-mode
  "," 'cider-eval-last-sexp
  "." 'cider-eval-defun-at-point
  "b." 'cider-eval-file
  "b," 'cider-eval-file
  "cq" 'cider-quit
  "cr" 'cider-refresh
  "cR" 'cider-restart
  "cj" 'cider-switch-to-relevant-repl-buffer
  "cJ" 'cider-jack-in-clojurescript
  "ct" 'cider-test-run-test
  "cf" 'antho/cider-figwheel-repl
 )

;; cider
(evil-leader/set-key-for-mode 'cider-repl-mode
  "cj" 'cider-switch-to-last-clojure-buffer
  "cq" 'cider-quit
  "cr" 'cider-refresh
  "cR" 'cider-restart
  )

;;hy mode -- TODO consolidate with lisp mode
(evil-leader/set-key-for-mode 'hy-mode
  "," 'lisp-eval-last-sexp
  "." 'lisp-eval-defun
  "cj" 'switch-to-lisp
  "cJ" 'inferior-lisp
  )

