local vimp = require("vimp")
local nnoremap = vimp.nnoremap
local ts_utils = require'nvim-treesitter.ts_utils'

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "html",
    "javascript",
    "typescript",
    "c",
    "cpp",
    "json",
    "lua",
    "python",
    "markdown",
    "latex",
    "markdown_inline"
  },
  auto_install = true,
  ignore_install = {},
  sync_install = false,
  modules = {},
  highlight = {
    disable = { "latex" },
    enable = true,
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- you can change this if you want.
      goto_next_start = {
        --- ... other keymaps
        ["]B"] = { query = "@code_cell.inner", desc = "next code block" },
        ["}"] = { query = "@block.outer", desc = "next scope"},
        ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
        ["]F"] = { query = "@function.inner", desc = "Next method/function inner" },
        ["]l"] = { query = "@loop.outer", desc = "Next method/function def start" },
        ["]c"] = { query = "@class.inner", desc = "Prev class start" },
      },
      goto_previous_start = {
        --- ... other keymaps
        ["[B"] = { query = "@code_cell.inner", desc = "previous code block" },
        ["{"] = { query = "@block.outer", desc = "previous scope"},
        ["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
        ["[F"] = { query = "@function.inner", desc = "Prev method/function inner" },
        ["[c"] = { query = "@class.inner", desc = "Prev class start" },
        --["[k"] = { query = "@function", desc = "Prev method/function def start" }
      },
    },
    select = {
      enable = true,
      lookahead = true, -- you can change this if you want
      keymaps = {
        --- ... other keymaps
        ["ib"] = { query = "@code_cell.inner", desc = "in block" },
        ["ab"] = { query = "@code_cell.outer", desc = "around block" },
      },
    },
    swap = { -- Swap only works with code blocks that are under the same
      -- markdown header
      enable = true,
      swap_next = {
        --- ... other keymap
        ["<leader>wc"] = "@code_cell.outer",
        ["<leader>wf"] = "@function.outer",
        ["<leader>wp"] = "@property.outer", -- swap object property with next
        ["<leader>wb"] = "@block.outer",
        ["<leader>wa"] = "@parameter.inner",
      },
      swap_previous = {
        --- ... other keymap
        ["<leader>wC"] = "@code_cell.outer",
        ["<leader>wF"] = "@function.outer",
        ["<leader>wP"] = "@property.outer", -- swap object property with next
        ["<leader>wB"] = "@block.outer",
        ["<leader>wA"] = "@parameter.inner",
      },
    },
  },
})

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

--nnoremap({'silent'}, '[', '[m')
--nnoremap({'silent'}, ']', ']m')

-- nmap({'silent'}, '<space>', 'za')
