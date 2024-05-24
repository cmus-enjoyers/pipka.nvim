-- [nfnl] Compiled from fnl/pipka/pipka.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("pipka.utils")
local notify = _local_1_["notify"]
local buf_keymap = _local_1_["buf-keymap"]
local function put_lsps(bufnr)
  return print("a")
end
local function set_buffer_name(bufnr, name)
  return vim.api.nvim_buf_set_name(bufnr, name)
end
local function open(options)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local total_width = math.floor((vim.o.columns / 2.5))
  set_buffer_name(bufnr, "pipka")
  vim.api.nvim_open_win(bufnr, true, {width = total_width, height = 12, split = "below"})
  local function _2_()
    return notify("+ was pressed")
  end
  return buf_keymap(bufnr, {"n", "i"}, "+", _2_)
end
return open
