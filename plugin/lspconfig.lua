local vimp = require("vimp")
local nnoremap = vimp.nnoremap

local lspconfig = require("lspconfig")

local api = vim.api
local diagnostic, lsp = vim.diagnostic, vim.lsp

vim.o.updatetime = 250

-- Patch the floating preview to have a rounded border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.max_height = 30
  opts.max_width = 80
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local lsp_defaults = require("lsp_defaults")

--- Set up LSP servers
--- @param server_specs table<string, vim.lsp.ClientSetupConfig>: A table where keys are server names and values are their configurations
local function setup(server_specs)
  for server_name, config in pairs(server_specs) do
    if config.flags == false then
      config.flags = nil
    else
      config.flags = vim.tbl_extend('keep', config.flags or {}, lsp_defaults.flags)
    end

    if config.capabilities == false then
      config.capabilities = nil
    else
      config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_defaults.capabilities)
    end

    config.on_attach = config.on_attach or lsp_defaults.on_attach

    lspconfig[server_name].setup(config)
  end
end

setup {
  -- python
  basedpyright = {
    cmd = { "uv", "run", "basedpyright-langserver", "--stdio" },
    settings = {
      basedpyright = {
        disableOrganizeImports = true
      }
    }
  },
  ruff = {
    cmd = { "uv", "run", "ruff", "server" },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {},
    },
  },
  serve_d = {},
  clangd = {},
  jdtls = {},
  lua_ls = {},
  leanls = {},
  vimls = {},
  texlab = {},
  jsonls = {
    on_attach = function() end
  },
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        },
      },
    },
  },
  --denols = {},
  ts_ls = {},
  cssls = {},
  cssmodules_ls = {
    cmd = { "npx", "cssmodules-language-server" },
    on_attach = function (client)
        -- avoid accepting `definitionProvider` responses from this LSP
        client.server_capabilities.definitionProvider = false
        lsp_defaults.on_attach(client)
    end,
  },
  html = {},
  superhtml = {}

}
