{:user {:dependencies [[org.clojure/tools.trace "RELEASE"]
                       [cljfmt "RELEASE"]
                       [midje "RELEASE"]
                       [slamhound "RELEASE"]]

        :plugins [;[venantius/ultra "0.5.2"]
                  [lein-cljfmt "0.5.7"]
                  [lein-midje "3.2.1"]]

        :aliases {"slamhound" ["run" "-m" "slam.hound"]}

        :repl-options {:init (require 'cljfmt.core)
                       :prompt (fn [ns] (str "[" ns "](\u001b[36mλ\u001b[0m)> "))}}}
