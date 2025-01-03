local vimp = require("vimp")
local nnoremap = vimp.nnoremap

require("colors").set_hls{
  --DiagnosticError = { ctermfg = 1, fg = 'Red' },
  DiagnosticWarn = { ctermfg = 3, fg = 'Orange' },
  DiagnosticInfo = { ctermfg = 4, fg = 'LightBlue' },
  DiagnosticHint = { ctermfg = 7, fg = 'LightGrey' },

  --DiagnosticUnderlineError = { cterm = { underline = true }, undercurl = true, sp = 'Red' },
  DiagnosticUnderlineWarn = { cterm = { underline = true }, undercurl = true, sp = 'Orange' },
  DiagnosticUnderlineInfo = { cterm = { underline = true }, undercurl = true, sp = 'LightBlue' },
  DiagnosticUnderlineHint = { cterm = { underline = true }, undercurl = true, sp = 'LightGrey' },
}

local trouble = require("trouble")
trouble.setup({
  auto_preview = false,
  follow = true,
  keys = {
    ["<leader>dq"] = "close",
    ["<esc>"] = "cancel",
    r = "refresh",
    R = "toggle_refresh",
    ["<cr>"] = "jump",
    ["_"] = "jump_split",
    ["|"] = "jump_vsplit",
    l = "fold_open",
    L = "fold_open_recursive",
    h = "fold_close",
    H = "fold_close_recursive",
    j = "next",
    k = "prev",
  },
  modes = {
    diagnostics = {
      height = 10,
      width = 50,
      --auto_open = true, -- automatically close the list when you have no diagnostics
      auto_close = true, -- automatically close the list when you have no diagnostics
    },
    symbols = {
      win = { position = "right" },
      filter = {
        --remove Package since luals uses it for control flow structures
        ["not"] = { ft = "lua", kind = "Package" },
        any = {
          --all symbol kinds for help / markdown files
          ft = { "help", "markdown" },
          --default set of symbol kinds
          kind = {
            "Class",
            "Constructor",
            "Enum",
            "Field",
            "Function",
            "Interface",
            "Method",
            "Module",
            "Namespace",
            "Package",
            "Property",
            "Struct",
            "Trait",
          },
        },
      },
    },
  },
  icons = {
    indent = {
      fold_open = "",
      fold_closed = "",
    },
    kinds = {
      Array = " ",
      Boolean = "󰄴 ", -- nf-md-checkbox_marked_circle_outline
      Namespace = " ", -- nf-cod-symbol_namespace
      Null = " ",
      Number = "󰎠 ",
      Object = "󰆦 ",
      Package = "󰃖 ", -- nf-md-briefcase
      String = " ",
      Text = " ", -- nf-fa-font
      Method = "󰡱 ", -- nf-md-function-variant
      Function = "󰡱 ",
      Constructor = " ", -- nf-fae-tools
      Field = "󰊾 ", -- nf-md-order_bool_ascending
      Variable = "󰫧 ", -- nf-md-cube
      Class = " ", -- nf-md-webpack
      Interface = "󰋺 ", -- nf-md-import
      Module = "󰃖 ", -- nf-md-briefcase
      Property = "󰠱 ", -- nf-md-shape
      Unit = "󰑭 ", -- nf-md-ruler
      Value = "󰎠 ", -- nf-md-numeric
      Enum = " ", -- nf-fa-sort_alpha_asc
      EnumMember = "󰀬 ", -- nf-md-alphabetical
      Keyword = "󰪛 ", -- nf-md-key
      Color = " ", -- nf-cod-paintcan
      File = " ", -- nf-fa-file-text
      Reference = " ", -- nf-cod-go_to_file
      Folder = " ", -- nf-fa-folder
      Constant = "● ", -- nf-fa-circle
      Struct = "󰆧 ", -- nf-md-cube_outline
      Event = " ", -- nf-oct-clock
      Operator = " ", -- nf-cod-symbol_operator
      TypeParameter = " ", -- nf-code-symbol-paramter
    },
  },
})

nnoremap({ "silent" }, "<C-d>", function()
  trouble.toggle("diagnostics")
end)
nnoremap({ "silent" }, "<C-s>", function()
  trouble.toggle("symbols")
end)

vim.api.nvim_create_autocmd({ "QuitPre" }, {
  callback = function()
    trouble.close("diagnostics")
    trouble.close("symbols")
  end,
})
