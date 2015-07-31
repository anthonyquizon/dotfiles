(global-evil-leader-mode)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "S" 'antho/search-keybinding-empty
  "b" 'eval-buffer
  "d" 'dired
  "e" 'eshell
  "f" 'find-file
  "b" 'switch-to-buffer
  "g" 'magit-status
  "l" 'evil-lookup
  "n" 'linum-relative-toggle
  "o" 'mode-line-other-buffer
  "r" 'open-finder
  "s" 'antho/search-keybinding
  "x" 'execute-extended-command
  "z" 'repeat
  
  "cj" 'cider-jack-in
  
  "<SPC>f" 'helm-projectile-find-file
  "<SPC>s" 'helm-projectile-ag
  "<SPC>d" 'helm-projectile-find-dir
  "<SPC>r" 'helm-projectile-recentf
  "<SPC>p" 'helm-projectile-switch-project
  "<SPC>x" 'execute-extended-command
  )
