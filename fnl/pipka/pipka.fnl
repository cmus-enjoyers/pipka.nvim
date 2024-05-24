(local {: notify} (require :pipka.utils))

(fn open []
  (notify "Hello From Pipka.nvim!")
  (let [bufnr (vim.api.nvim_create_buf false true)
        total-width (math.floor (/ vim.o.columns 2.5))]
    (vim.api.nvim_open_win bufnr false {:width total-width
                                        :height 12
                                        :split :below})))

open
