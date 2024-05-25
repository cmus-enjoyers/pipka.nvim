(local create-user-command (. (require :pipka.utils) :create-user-command))

(var options {})

(create-user-command :Pipka (fn []
   ((require :pipka.pipka) options)) {})

(fn setup [config]
  (set options config))

{: setup}
