(require 'helm-config)

(helm-mode 1)

(global-set-key (kbd "C-x f") 'helm-recentf)

(define-key helm-map (kbd "<tab>") nil)
(define-key helm-map (kbd "C-l") nil)
(define-key helm-map (kbd "C-h") nil) 
(define-key helm-map (kbd "C-z") nil)
(define-key helm-map (kbd "C-j") nil)
(define-key helm-map (kbd "C-k") nil)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-map (kbd "C-z") 'helm-select-action)
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)
    
(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-find-files-map (kbd "C-z") 'helm-select-action)
(define-key helm-find-files-map (kbd "C-j") 'helm-next-line)
(define-key helm-find-files-map (kbd "C-k") 'helm-previous-line)

(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-l") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-h") 'helm-find-files-up-one-level) 
(define-key helm-read-file-map (kbd "C-z") 'helm-select-action)
(define-key helm-read-file-map (kbd "C-j") 'helm-next-line)
(define-key helm-read-file-map (kbd "C-k") 'helm-previous-line)
