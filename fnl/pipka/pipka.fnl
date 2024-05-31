(local {: notify : buf-keymap : get-buffer-by-name} (require :pipka.utils))

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

(fn add-lsp [bufnr options]
  (fn []
    (notify (.. "Igor " (tostring bufnr)))))

(local pipka-keymaps {:+ {:mode [:n :i] :rhs add-lsp}
                      :q {:mode :n :rhs :<cmd>close<cr>}})

(fn set-keymaps [bufnr keymaps options] 
  (each [key options (pairs keymaps)]
    (buf-keymap bufnr options.mode key 
                (if (function? options.rhs) 
                    (options.rhs bufnr options)
                    options.rhs) 
                options.options)))

(fn create-buffer [name listed scratch]
  (let [bufnr (vim.api.nvim_create_buf
                (or listed false)
                (or scratch true))]
    (set-buffer-name bufnr name)
    bufnr))

(fn get-buf-or-create [name]
  (let [bufnr (get-buffer-by-name name)]
    (if (not bufnr) (create-buffer name)
        bufnr)))

(local pipka-namespace (vim.api.nvim_create_namespace :pipka))

(fn highlight-non-installed-entry [bufnr line col col-end]
  (vim.api.nvim_buf_set_extmark bufnr pipka-namespace line col {:end_col col-end
                                                                :hl_group "@comment"}))

(fn open [options]
  (let [bufnr (get-buf-or-create buf-title)
        total-width (math.floor (/ vim.o.columns 2.5))]
    (set-buffer-name bufnr buf-title)
    (vim.api.nvim_open_win bufnr true {:width total-width
                                       :height 12
                                       :split (or options.split :below)})
    (set-keymaps bufnr pipka-keymaps options)
    (put-lsps bufnr)
    (highlight-non-installed-entry bufnr 0 1 22)
    (let [augroup (vim.api.nvim_create_augroup :Pipka {})]
      (vim.api.nvim_create_autocmd :BufWriteCmd {:buffer bufnr
                                   :group augroup
                                   :callback (fn []
                                               (notify :BufWriteCmd))}))))

open
