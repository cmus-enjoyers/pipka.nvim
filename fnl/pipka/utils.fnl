(local default-notify-options {:title :pipka.nvim})

(fn set-notify-options [options]
  (when options
    (set options.title
         (or options.title default-notify-options.title)))
  (or options default-notify-options))

(fn notify [text level options]
  (vim.notify text (or level vim.log.levels.INFO) (set-notify-options options)))

(fn create-user-command [name action options]
  (vim.api.nvim_create_user_command name action options))

{: notify
 : create-user-command}
