local vimp = require("vimp")
local nnoremap = vimp.nnoremap

local lspconfig = require("lspconfig")

local api = vim.api
local diagnostic, lsp = vim.diagnostic, vim.lsp

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


-- Defaults

local lsp_keymap_opts = { "silent" }
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local default_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  --api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.lsp.omnifunc')
  api.nvim_set_option_value("omnifunc", "v:lua.lsp.omnifunc", { buf = bufnr })

  vimp.add_buffer_maps(bufnr, function()
    -- Mappings.
    -- See `:help lsp.*` for documentation on any of the below functions
    nnoremap(lsp_keymap_opts, "<leader>j", diagnostic.goto_next)
    nnoremap(lsp_keymap_opts, "<leader>k", diagnostic.goto_prev)
    nnoremap(lsp_keymap_opts, "<leader>J", function()
      diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN } })
    end)
    nnoremap(lsp_keymap_opts, "<leader>K", function()
      diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN } })
    end)

    nnoremap(lsp_keymap_opts, "gD", lsp.buf.declaration)
    nnoremap(lsp_keymap_opts, "gd", lsp.buf.definition)
    nnoremap(lsp_keymap_opts, "L", function()
      api.nvim_command("set eventignore=CursorHold")
      lsp.buf.hover()
      api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
    end)
    nnoremap(lsp_keymap_opts, "gi", lsp.buf.implementation)

    nnoremap(lsp_keymap_opts, "<leader>h", lsp.buf.signature_help)
    nnoremap(lsp_keymap_opts, "<leader>wa", lsp.buf.add_workspace_folder)
    nnoremap(lsp_keymap_opts, "<leader>wr", lsp.buf.remove_workspace_folder)
    nnoremap(lsp_keymap_opts, "<leader>wl", function()
      print(vim.inspect(lsp.buf.list_workspace_folders()))
    end)
    nnoremap(lsp_keymap_opts, "td", lsp.buf.type_definition)
    nnoremap(lsp_keymap_opts, "<leader>rn", lsp.buf.rename)
    nnoremap(lsp_keymap_opts, "<leader>c", lsp.buf.code_action)
    nnoremap(lsp_keymap_opts, "<leader>f", lsp.buf.format)
    nnoremap(lsp_keymap_opts, "<leader>r", lsp.buf.references)
  end)

  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
      hi link LspReferenceRead Visual
      hi link LspReferenceText Visual
      hi link LspReferenceWrite Visual
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd! CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end
end

---@type table<string, any>  Default LSP flags
local default_lsp_flags = {
  debounce_text_changes = 150,
}

--- Default LSP capabilities
local default_capabilities = require('blink.cmp').get_lsp_capabilities()

--- Set up LSP servers
--- @param server_specs table<string, vim.lsp.ClientSetupConfig>: A table where keys are server names and values are their configurations
local function setup(server_specs)
  for server_name, config in pairs(server_specs) do
    if config.flags == false then
      config.flags = nil
    else
      config.flags = vim.tbl_extend('keep', config.flags or {}, default_lsp_flags)
    end

    if config.capabilities == false then
      config.capabilities = nil
    else
      config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, default_capabilities)
    end

    config.on_attach = config.on_attach or default_on_attach

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
  cssmodules_ls = {},
  html = {},
  superhtml = {}

}
