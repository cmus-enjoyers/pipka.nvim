-- [nfnl] Compiled from fnl/pipka/pipka.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("pipka.utils")
local notify = _local_1_["notify"]
local buf_keymap = _local_1_["buf-keymap"]
local function buf_set_lines(buffer, start, _end, strict_indexing, replacement)
  return vim.api.nvim_buf_set_lines(buffer, start, _end, strict_indexing, replacement)
end
local function put_lsps(bufnr)
  local lsps = require("pipka.lsps")
  return buf_set_lines(bufnr, 0, #lsps, false, lsps)
end
local function set_buffer_name(bufnr, name)
  return vim.api.nvim_buf_set_name(bufnr, name)
end
local function function_3f(thing)
  return (type(thing) == "function")
end
local function get_pos(bufnr)
  return vim.fn.getpos(bufnr)
end
local pipka_keymaps
local function _2_(bufnr)
  notify("+ was pressed")
  return notify(get_pos(bufnr))
end
pipka_keymaps = {["+"] = {mode = {"n", "i"}, rhs = _2_}, q = {mode = "n", rhs = "<cmd>close<cr>"}}
local function set_keymaps(bufnr, keymaps, options)
  for key, options0 in pairs(keymaps) do
    buf_keymap(bufnr, options0.mode, key, options0.rhs, options0.options)
  end
  return nil
end
local function open(options)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local total_width = math.floor((vim.o.columns / 2.5))
  set_buffer_name(bufnr, "Pipka")
  vim.api.nvim_open_win(bufnr, true, {width = total_width, height = 12, split = (options.split or "below")})
  set_keymaps(bufnr, pipka_keymaps, options)
  put_lsps(bufnr)
  local augroup = vim.api.nvim_create_augroup("Pipka", {})
  local function _3_()
    return notify("BufWriteCmd")
  end
  return vim.api.nvim_create_autocmd("BufWriteCmd", {buffer = bufnr, group = augroup, callback = _3_})
end
return open
