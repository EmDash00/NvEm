return {
  "lean.nvim",
  ft = { "lean" },
  after = function()
    local lsp_defaults = require("lsp_defaults")
    require("lz.n").trigger_load {
      "nvim-lspconfig",
      "plenary.nvim",
      "switch.vim",
      "satellite.nvim",
      "telescope.nvim",
    }
    require('lean').setup {
      lsp = {
        on_attach = lsp_defaults.on_attach,
        capabilities = lsp_defaults.capabilities,
        flags = lsp_defaults.flags
      },
      mappings = true
    }
  end
}
