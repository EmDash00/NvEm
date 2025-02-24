local lsp_defaults = require("lsp_defaults")

require('lean').setup {
  lsp = {
    on_attach = lsp_defaults.on_attach,
    capabilities = lsp_defaults.capabilities,
    flags = lsp_defaults.flags
  },
  mappings = true
}
