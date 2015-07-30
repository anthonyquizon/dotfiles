(global-evil-leader-mode)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "l" 'evil-lookup
  "n" 'linum-relative-toggle
  "e" 'eshell
  "b" 'eval-buffer
  "s" 'antho/search-keybinding
  "S" 'antho/search-keybinding-empty
  "r" 'open-finder
  "g" 'magit-status
  "o" 'mode-line-other-buffer
  
  "xf" 'find-file
  "xd" 'dired
  
  "wx" 'evil-window-delete
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
  )
