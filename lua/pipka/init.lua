local M = {}

function M.open_float()
  local bufnr = vim.api.nvim_create_buf(false, true)

  local total_width = math.floor(vim.o.columns / 2.5)

  local winid = vim.api.nvim_open_win(
    bufnr,
    false,
    { width = total_width, height = 12, split = 'down' }
  )
end

M.open_float()
