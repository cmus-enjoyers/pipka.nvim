local function open()
  local bufnr = vim.api.nvim_create_buf(false, true)
  local total_width = math.floor((vim.o.columns / 2.5))
  return vim.api.nvim_open_win(bufnr, false, {width = total_width, height = 12, split = "left"})
end
open()
return {open = open}
