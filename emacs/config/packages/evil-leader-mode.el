(global-evil-leader-mode)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "S" 'antho/search-keybinding-empty
  "b" 'eval-buffer
  "d" 'dired
  "f" 'find-file
  "b" 'switch-to-buffer
  "g" 'magit-status
  "n" 'linum-relative-toggle
  "u" 'universal-argument
  "o" 'mode-line-other-buffer
  "r" 'open-finder
  "s" 'antho/search-keybinding
  "x" 'execute-extended-command
  "z" 'repeat
  ":" 'helm-emmet
  "k" 'kill-buffer
  
  "ls" 'sort-lines
  "ll" 'evil-lookup
  
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
  
  "<SPC>f" 'helm-projectile-find-file
  "<SPC>s" 'helm-projectile-ag
  "<SPC>d" 'helm-projectile-find-dir
  "<SPC>r" 'helm-projectile-recentf
  "<SPC>p" 'helm-projectile-switch-project
  "<SPC>b" 'helm-buffers-list
  "<SPC>x" 'execute-extended-command
  )
