local vimp = require('vimp')
local nnoremap = vimp.nnoremap

local opts = {'silent'}

local project_nvim = require('project_nvim')

project_nvim.setup {
  -- Manual mode doesn't automatically change your root directory, so you have
  -- the option to manually do so using `:ProjectRoot` command.
  manual_mode = false,

  -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  -- order matters: if one is not detected, the other is used as fallback. You
  -- can also delete or rearangne the detection methods.
  detection_methods = { "pattern", "lsp" },

  -- All the patterns used to detect root dir, when **"pattern"** is in
  -- detection_methods
  patterns = {
    ".git",
    "Makefile",
    "Pipfile",
    ".nvimproj",
  },

  -- Table of lsp clients to ignore by name
  -- eg: { "efm", ... }
  ignore_lsp = {},

  -- Don't calculate root dir on specific directories
  -- Ex: { "~/.cargo/*", ... }
  exclude_dirs = {
    "/home/emdash00",
    "~/dotfiles"
  },

  -- Show hidden files in telescope
  show_hidden = false,

  -- When set to false, you will get a message when project.nvim changes your
  -- directory.
  silent_chdir = true,

  -- Path where project.nvim will store the project history for use in
  -- telescope
  datapath = vim.fn.stdpath("data"),
}

nnoremap(opts, '<leader>P', ':Telescope projects<CR>')
