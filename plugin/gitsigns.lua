local vimp = require('vimp')

local nnoremap = vimp.nnoremap
local vnoremap = vimp.vnoremap

require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    nnoremap('g]', function()
      if vim.wo.diff then return 'g]' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end)

    nnoremap('g[', function()
      if vim.wo.diff then return 'g[' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end)

    nnoremap('<leader>gs', gs.stage_hunk)
    nnoremap('<leader>gr', gs.reset_hunk)
    vnoremap('<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    vnoremap('<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    nnoremap('<leader>gS', gs.stage_buffer)
    nnoremap('<leader>gu', gs.undo_stage_hunk)
    nnoremap('<leader>gR', gs.reset_buffer)
    nnoremap('<leader>gp', gs.preview_hunk)
    nnoremap('<leader>gb', function() gs.blame_line{full=true} end)
    nnoremap('<leader>gb', gs.toggle_current_line_blame)
    nnoremap('<leader>gd', gs.diffthis)
    nnoremap('<leader>gD', function() gs.diffthis('~') end)
    nnoremap('<leader>gd', gs.toggle_deleted)
  end
}
