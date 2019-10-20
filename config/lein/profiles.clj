{:user {:dependencies [[org.clojure/tools.trace "0.7.10"]
                       [cljfmt "0.6.4"]
                       [midje "1.9.9"]
                       [slamhound "1.5.5"]
                       [com.bhauman/rebel-readline "0.1.4"]]

        :plugins [;[venantius/ultra "0.6.0"]
                  [lein-cljfmt "0.6.4"]     ; Format code on the fly
                  [lein-midje "3.2.1"]      ; Testing framework plugin
                  [lein-jupyter "0.1.16"]   ; Use clojupyter from leiningen
                  [venantius/pyro "0.1.2"]] ; Booster pack for stack-traces

        :aliases {"slamhound" ["run" "-m" "slam.hound"]
                  "rebl" ["trampoline" "run" "-m" "rebel-readline.main"]}

        :repl-options {:init (require 'cljfmt.core)
                       :prompt (fn [ns] (str "[" ns "](\u001b[36mλ\u001b[0m)> "))}}}
