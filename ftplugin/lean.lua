local diagnostic = vim.diagnostic

local signs = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.HINT] = " ",
  [vim.diagnostic.severity.INFO] = " "
}

-- Diagnostics
diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = function(diagnostic_info, i, total)
      return signs[diagnostic_info.severity]
    end
  },
  signs = false,
  underline = true,
  float = {
    border = "rounded",
  },
  update_in_insert = true,
  severity_sort = true,
})
