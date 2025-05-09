local conform = require("conform")

conform.setup({
  formatters = {
    ruff_organize_imports = {
      command = require("conform.util").find_executable({".venv/bin/ruff"}, "ruff"),
    },
    ruff_format = {
      command = require("conform.util").find_executable({".venv/bin/ruff"}, "ruff"),
    },
    clangformat = {
      command = require("conform.util").find_executable({"/usr/bin/clang-format"}, "clangformat"),
    }
  },
  formatters_by_ft = {
    python = { "ruff_organize_imports", "ruff_format" },
    lua = { "stylua" },

    c = { "clangformat" },
    d = { "dfmt" },
    rust = { "rustfmt" },

    html = { "prettierd" },
    shtml = { "superhtml" },

    javascript = { "prettierd" },
    typescript = { "prettierd" },

    css = { "prettierd" },
    scss = { "prettierd" },
    sass = { "prettierd" },

    xml = { "prettierd" },
    yaml = { "prettierd" },
    toml = { "prettierd" },
    json = { "prettierd" },

    rst = { "rstfmt" },
    markdown = { "markdownfmt" },
    tex = { "llf" },
  },
})

vim.keymap.set("", "<leader>f", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format code" })
