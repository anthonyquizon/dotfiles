
;;TODO unit test to source file quick switching -> if in unit test, quickly open up source file and vice versa
;;get current file

;; SMART SPARROW workflow

;; (message (concat (split-string (buffer-file-name) "/")))

;; generate files with functions
;; * spec
;; * source in folder
;; * functions for spec and source
;; * add to components

;; Emmet
;; scene config
;;  * components
;;  * entities

;; lib/[path][file].js
;; test/[path][file].spec.js

;; (defun antho/source-spec-switch ()
;;   (let (filepath buffer-file-name))
;;   ;;
;;     ()
;;     ))
  

;;TODO rename:
;; lib/**/component.js
;; test/**/component.spec.js
;; componentName in components.js
;; componentName in test/test.js


(defun antho/search-keybinding()
  (interactive)
  ;;TODO check if visual mode
  (evil-ex (concat "%s/" (thing-at-point 'word) "/")))

(defun antho/search-keybinding-empty()
  (interactive)
  ;;TODO check if visual mode
  (evil-ex (concat "%s/")))
