local lint = require("lint")

local diagnostic = vim.diagnostic

vim.o.updatetime = 250

-- Diagnostics
diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  float = {
    border = "rounded",
  },
  update_in_insert = true,
  severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Diagnostic hold
vim.api.nvim_create_autocmd("CursorHold", {
  --buffer = bufnr,
  callback = function()
    diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      source = "always",
      prefix = " ",
      suffix = "",
      scope = "cursor",
    })
  end,
})


lint.linters_by_ft = {
  python = { "codespell", "editorconfig-checker" },
  java = { "codespell", "editorconfig-checker" },
  c = { "codespell", "editorconfig-checker" },
  cpp = { "codespell", "editorconfig-checker" },
  lua = { "codespell", "editorconfig-checker" },

  --html = { "tidy", "codespell", "editorconfig-checker" },
  html = { "codespell", "editorconfig-checker" },
  xml = { "codespell", "editorconfig-checker" },
  typescript = { "codespell", "editorconfig-checker" },
  javascript = { "codespell", "editorconfig-checker" },
  css = { "codespell", "editorconfig-checker", "stylelint" },
  less = { "codespell", "editorconfig-checker", "stylelint" },
  sugarss = { "codespell", "editorconfig-checker", "stylelint" },
  scss = { "codespell", "editorconfig-checker", "stylelint" },
  sass = { "codespell", "editorconfig-checker", "stylelint" },

  sh = { "editorconfig-checker", "codespell", "shellcheck" },
  bash = { "editorconfig-checker", "codespell", "bash", "shellcheck" },
  zsh = { "editorconfig-checker", "codespell", "zsh", "shellcheck" },
  json = { "editorconfig-checker", "codespell" },
  markdown = { "codespell", "markdownlint", "vale" },
  rst = { "codespell", "vale" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})


