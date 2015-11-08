(global-evil-leader-mode)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "d" 'dired
  "f" 'find-file
  "n" 'linum-relative-toggle
  "U" 'universal-argument
  "o" 'mode-line-other-buffer
  "x" 'execute-extended-command
  "z" 'repeat
  ":" 'helm-emmet

  "T" 'multi-term
  "tt" 'multi-term
  "tn" 'multi-next
  "tp" 'multi-prev
  "tk" 'term-kill-subjob
  "tc" 'term-interrupt-subjob
  "td" 'term-send-eof
  
  "be" 'eval-buffer
  "bk" 'kill-buffer
  
  "ls" 'sort-lines
  "ll" 'evil-lookup
  
  "ss" 'antho/search-keybinding-empty
  "sr" 'antho/search-keybinding

  
  "cj" 'cider-jack-in
  
  "E" 'eshell
  "en" 'eshell ;;TODO make new eshell command
  "ek" 'eshell-kill-process
  "ec" 'eshell-interrupt-process
  "ed" 'eshell-send-eof-to-process
  "eh" 'helm-eshell-history
  
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
  )


