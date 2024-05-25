(local {: notify : buf-keymap} (require :pipka.utils))

(fn buf-set-lines [buffer start end strict-indexing replacement]
  (vim.api.nvim_buf_set_lines buffer start end strict-indexing replacement))

(fn put-lsps [bufnr]
  (let [lsps (require :pipka.lsps)]
    (buf-set-lines bufnr 0 (length lsps) false lsps)))

(fn set-buffer-name [bufnr name]
  (vim.api.nvim_buf_set_name bufnr name))

(fn function? [thing]
  (= (type thing) "function"))

(fn get-pos [bufnr]
  (vim.fn.getpos bufnr))

(local pipka-keymaps {:+ {:mode [:n :i] :rhs (fn [bufnr]
                                              (notify "+ was pressed")
                                              (notify (get-pos bufnr)))}
                      :q {:mode :n :rhs :<cmd>close<cr>}})

(fn set-keymaps [bufnr keymaps options] 
  (each [key options (pairs keymaps)]
    (buf-keymap bufnr options.mode key options.rhs options.options)))

(fn open [options]
  (let [bufnr (vim.api.nvim_create_buf false true)
        total-width (math.floor (/ vim.o.columns 2.5))]
    (set-buffer-name bufnr "Pipka")
    (vim.api.nvim_open_win bufnr true {:width total-width
                                       :height 12
                                       :split (or options.split :below)})
    (set-keymaps bufnr pipka-keymaps options)
    (put-lsps bufnr)
    (let [augroup (vim.api.nvim_create_augroup :Pipka {})]
      (vim.api.nvim_create_autocmd :BufWriteCmd {:buffer bufnr
                                   :group augroup
                                   :callback (fn []
                                               (notify :BufWriteCmd))}))))

open
