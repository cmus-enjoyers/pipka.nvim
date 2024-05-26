(local create-user-command (. (require :pipka.utils) :create-user-command))

(var options {:split :below})

(create-user-command :Pipka (fn []
   ((require :pipka.pipka) options)) {})

(local next next)

(fn empty? [table]
  (= (next table) nil))

(fn setup [config]
  (when (not (empty? config))
    (set options config)))

{: setup}
