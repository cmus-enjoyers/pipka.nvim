-- [nfnl] Compiled from fnl/pipka/pipka.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("pipka.utils")
local notify = _local_1_["notify"]
local function open()
  notify("Hello From Pipka.nvim!")
  local bufnr = vim.api.nvim_create_buf(false, true)
  local total_width = math.floor((vim.o.columns / 2.5))
  return vim.api.nvim_open_win(bufnr, false, {width = total_width, height = 12, split = "below"})
end
return open
