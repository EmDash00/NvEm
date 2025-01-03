local vimp = require('vimp')
local nnoremap = vimp.nnoremap

local telescope = require('telescope')
local builtin = require('telescope.builtin')

local opts = {'silent'}

telescope.load_extension('projects')

telescope.setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    prompt_prefix = '❯ ',
    selection_caret = ' ',
  --   mappings = {
--       i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key"
      -- }
    -- }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {

  }
}

nnoremap(opts, '<leader>S', builtin.builtin)
-- nnoremap(opts, '<C-h>', builtin.help_tags)

nnoremap(opts, '<leader>sh', builtin.highlights)

nnoremap(opts, '<leader>sf', builtin.find_files)
nnoremap(opts, '<leader>sg', builtin.git_files)
nnoremap(opts, '<leader>ss', builtin.live_grep)
nnoremap(opts, '<leader>sk', builtin.current_buffer_fuzzy_find)

nnoremap(opts, '<leader>sb', builtin.buffers)
nnoremap(opts, '<leader>sc', builtin.commands)

-- LSP
nnoremap(opts, '<leader>sr', builtin.lsp_references)
nnoremap(opts, '<leader>si', builtin.lsp_implementations)
nnoremap(opts, '<leader>sd', builtin.lsp_definitions)
nnoremap(opts, '<leader>sD', builtin.lsp_type_definitions)

nnoremap(opts, '<leader>sy', builtin.lsp_document_symbols)
nnoremap(opts, '<leader>st', builtin.treesitter)
nnoremap(opts, '<leader>sY', builtin.lsp_dynamic_workspace_symbols)
