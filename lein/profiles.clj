{:user {:plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"]]
        :dependencies [[com.cemerick/piggieback "0.2.1"]
                       [org.clojure/tools.nrepl "0.2.12"]]
        :repl-options {:nrepl-middleware [cemerick.piggieback/wrap-cljs-repl]}}} 
