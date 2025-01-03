local cmd = vim.cmd
local api = vim.api

api.nvim_create_autocmd(
  "BufWritePre",
  {
    callback = function()
      local pos = api.nvim_win_get_cursor(0)
      cmd '%s/\\s\\+$//e'
      api.nvim_win_set_cursor(0, pos)
    end
  }
)
