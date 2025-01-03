require("blink-cmp").setup {
  -- Enable function signature help
  signature = {
    enabled = true,
    window = { border = 'rounded' }
  },

  -- Disable completion in search
  completion = {
    menu = {
      border = 'none',
      auto_show = function(ctx)
        return ctx.mode ~= "cmdline" or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
      end,
    },

    -- Show documentation popup
    documentation = {
      window = { border = 'rounded' },
      auto_show = true,
      auto_show_delay_ms = 0
    },

    -- Enable ghost text to show completion
    ghost_text = {
      enabled = true
    },

    list = {
      selection = function(ctx)
        return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
      end
    }
  },

  -- Icons!
  appearance = {
    nerd_font_variant = 'mono',
    kind_icons = {
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
    }
  },
  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji' },
    providers = {
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 15, -- Tune by preference
      }
    },

  },
  keymap = {
    ['<s-tab>'] = { 'select_prev', 'fallback' },
    ['<tab>'] = { 'select_next', 'fallback' },
    ['<cr>'] = { 'accept', 'fallback' },
    ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<c-i>'] = { 'scroll_documentation_down', 'fallback' },
    ['<c-l>'] = { 'snippet_forward', 'fallback' },
    ['<c-h>'] = { 'snippet_backward', 'fallback' },

    -- disable a keymap from the preset
    ['<C-e>'] = {},
    -- show with a list of providers
    ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
  }
}
