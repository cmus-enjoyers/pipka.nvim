(local {: notify : buf-keymap} (require :pipka.utils))

(fn buf-set-lines [buffer start end strict-indexing replacement]
  (vim.api.nvim_buf_set_lines buffer start end strict-indexing replacement))

(fn put-lsps [bufnr]
  (let [lsps (require :pipka.lsps)]
    (buf-set-lines bufnr 0 (length lsps) false lsps)))

(fn set-buffer-name [bufnr name]
  (vim.api.nvim_buf_set_name bufnr name))

(local pipka-keymaps {:+ {:mode [:n :i] :rhs (fn []
                                              (notify "+ was pressed"))}
                      :q {:mode :n :rhs :<cmd>close<cr>}})

(fn open [options]
  (let [bufnr (vim.api.nvim_create_buf false true)
        total-width (math.floor (/ vim.o.columns 2.5))]
    (set-buffer-name bufnr "pipka")
    (vim.api.nvim_open_win bufnr true {:width total-width
                                        :height 12
                                        :split (or options.split :below)})
    (each [key options (pairs pipka-keymaps)]
      (buf-keymap bufnr options.mode key options.rhs options.options))
    (put-lsps bufnr)
    (let [augroup (vim.api.nvim_create_augroup :Pipka {})]
      (vim.api.nvim_create_autocmd :BufWriteCmd {:buffer bufnr
                                   : augroup
                                   :callback (fn []
                                               (notify :BufWriteCmd))}))))

open
