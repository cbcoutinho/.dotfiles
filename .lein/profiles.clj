{:user {:plugins [[venantius/ultra "0.5.2"]
                  [cider/cider-nrepl "0.17.0"]
                  [lein-gorilla "0.4.0"]
                  [lein-cljfmt "0.5.7"]
                  [lein-midje "3.2.1"]]

        :dependencies [[cljfmt "RELEASE"]
                       [midje "RELEASE"]
                       [slamhound "RELEASE"]]

        :aliases {"slamhound" ["run" "-m" "slam.hound"]}

        :repl-options {:init (require 'cljfmt.core)
                       :prompt (fn [ns] (str "[" ns "](\u001b[36mλ\u001b[0m)> "))}}}
