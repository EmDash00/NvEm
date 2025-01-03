require("lspkind").setup{
  mode = "symbol_text",
  preset = "codicons",
  -- default: {}
  symbol_map = {
    Text = "", -- nf-fa-font
    Method = "󰡱", -- nf-md-function-variant
    Function = "󰊕", -- nf-md-function
    Constructor = "󰲽", -- nf-md-progress_wrench
    Field = "󰊾", -- nf-md-order_bool_ascending
    Variable = "󱄑", -- nf-md-cube
    Class = "", -- nf-md-webpack
    Interface = "󰋺", -- nf-md-import
    Module = "󰃖", -- nf-md-briefcase
    Property = "󰠱", -- nf-md-shape
    Unit = "󰑭", -- nf-md-ruler
    Value = "󰎠", -- nf-md-numeric
    Enum = "", -- nf-fa-sort_alpha_asc
    Keyword = "󰪛", -- nf-md-key
    Snippet = "󰐒", -- nf-playlist_plus
    Color = "", -- nf-cod-paintcan
    File = "", -- nf-fa-file-text
    Reference = "", -- nf-cod-go_to_file
    Folder = "", -- nf-fa-folder
    EnumMember = "󰀬", -- nf-md-alphabetical
    Constant = "●", -- nf-fa-circle
    Struct = "", -- nf-cod-symbol_structure
    Event = "", -- nf-oct-clock
    Operator = "", -- nf-cod-symbol_operator
    TypeParameter = "", -- nf-code-symbol-paramter
  },
}
