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

(local default-keymap-options {:noremap true
                               :silent true})

(fn set-keymap-options [opts]
  (vim.tbl_deep_extend "force" default-keymap-options (or opts {})))

(fn keymap [mode lhs rhs opts]
    (vim.keymap.set mode lhs rhs (set-keymap-options opts)))

(fn buf-keymap [buffer mode lhs rhs opts]
  (let [options (or opts {})]
    (set options.buffer buffer)
    (keymap mode lhs rhs options)))

(fn get-user-defined-options [options]
  (or (getmetatable options) options))

(fn get-buffer-by-name [name]
  (let [bufnr (vim.fn.bufnr name false)]
    (when (~= bufnr -1)
      bufnr)))

{: notify
 : create-user-command
 : keymap
 : buf-keymap
 : get-user-defined-options
 : get-buffer-by-name}
