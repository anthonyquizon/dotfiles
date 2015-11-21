#!/usr/bin/env hy

(import shutil)
(import os)

;; TODO remove all files from HOME dir that matches the files in the dotfile folder
;; TODO syslink everything in dotfiles folder to HOME dir

(defn clean []
  ;; remove for each folder/file in 
  (if (or (os.path.isdir dest-dir) (os.path.lexists dest-dir))
    (do (print "removing " dest-dir)
        (os.remove dest-dir))))
