return {
  "lean.nvim",
  ft = { "lean" },
  after = function()
    require("lz.n").trigger_load {
      "nvim-lspconfig",
      "plenary.nvim",
      "switch-vim",
      "satellite.nvim",
      "telescope.nvim",
    }
    require('lean').setup { mappings = true }
  end
}
