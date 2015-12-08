#!/usr/bin/env hy

(import os)

(def HOME (get os.environ "HOME"))
(def items (os.listdir "./dotfiles"))

(defn clean [f]
  (let [path (+ HOME "/" f)] 
   (if (os.path.lexists dest-dir)
     (do
      (print "removing: " path)
      (os.remove path)))))

(defn syslink[]
  ;;clean
  ;;syslink
  )

(defn install[]
  (for )
  )

;; for each find if exists in HOME

