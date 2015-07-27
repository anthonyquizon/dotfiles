(global-evil-leader-mode)

(evil-leader/set-key
  "l" 'evil-lookup
  "n" 'linum-relative-toggle
  "e" 'eshell
  "b" 'eval-buffer
  "s" 'antho/search-keybinding
  "S" 'antho/search-keybinding-empty
  "f" 'open-finder
  "p" 'mode-line-other-buffer)
