(local {: notify : buf-keymap} (require :pipka.utils))

(local buf-title :Pipka)

(fn buf-set-lines [buffer start end strict-indexing replacement]
  (vim.api.nvim_buf_set_lines buffer start end strict-indexing replacement))

(fn put-lsps [bufnr]
  (let [lsps (require :pipka.lsps)]
    (buf-set-lines bufnr 0 (length lsps) false lsps)))

(fn set-buffer-name [bufnr name]
  (vim.api.nvim_buf_set_name bufnr name))

(fn function? [thing]
  (= (type thing) "function"))

(fn get-current-line []
  (notify (vim.fn.getpos ".")))

(fn add-lsp [bufnr options]
  (fn []
    (get-current-line)))

(local pipka-keymaps {:+ {:mode [:n :i] :rhs add-lsp}
                      :q {:mode :n :rhs :<cmd>close<cr>}})

(fn set-keymaps [bufnr keymaps options] 
  (each [key options (pairs keymaps)]
    (when (function? options.rhs)
      (buf-keymap bufnr options.mode key (options.rhs bufnr options) options.options))
    (buf-keymap bufnr options.mode key options.rhs options.options)))

(fn create-buffer [name listed scratch]
  (let [bufnr (vim.api.nvim_create_buf
                (or listed true)
                (or scratch false))]
    (set-buffer-name bufnr name)
    bufnr))

(fn get-buf-or-create [name]
  (let [bufnr (vim.fn.bufnr name false)]
    (if (= bufnr -1) (create-buffer name)
                     bufnr)))

(fn open [options]
  (let [bufnr (get-buf-or-create buf-title)
        total-width (math.floor (/ vim.o.columns 2.5))]
    (set-buffer-name bufnr buf-title)
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
