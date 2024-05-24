(local {: notify : buf-keymap} (require :pipka.utils))

(fn put-lsps [bufnr]
  (print :a))

(fn set-buffer-name [bufnr name]
  (vim.api.nvim_buf_set_name bufnr name))

(fn open [options]
  (let [bufnr (vim.api.nvim_create_buf false true)
        total-width (math.floor (/ vim.o.columns 2.5))]
    (set-buffer-name bufnr "pipka")
    (vim.api.nvim_open_win bufnr true {:width total-width
                                        :height 12
                                        :split :below})
    (buf-keymap bufnr [:n :i] "+" (fn [] (notify "+ was pressed")))))

open
