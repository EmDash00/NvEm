local vimp = require('vimp')
local nnoremap = vimp.nnoremap
local opts = { 'silent' }

nnoremap(opts, '<leader>1', ':BufferLineGoToBuffer 1<CR>')
nnoremap(opts, '<leader>2', ':BufferLineGoToBuffer 2<CR>')
nnoremap(opts, '<leader>3', ':BufferLineGoToBuffer 3<CR>')
nnoremap(opts, '<leader>4', ':BufferLineGoToBuffer 4<CR>')
nnoremap(opts, '<leader>5', ':BufferLineGoToBuffer 5<CR>')
nnoremap(opts, '<leader>6', ':BufferLineGoToBuffer 6<CR>')
nnoremap(opts, '<leader>7', ':BufferLineGoToBuffer 7<CR>')
nnoremap(opts, '<leader>8', ':BufferLineGoToBuffer 8<CR>')
nnoremap(opts, '<leader>9', ':BufferLineGoToBuffer 9<CR>')
nnoremap(opts, '<leader>0', ':BufferLineGoToBuffer 10<CR>')

nnoremap(opts, '<leader>bp', ':BufferLinePick<CR>')
nnoremap(opts, '<leader>bq', ':BufferLinePickClose<CR>')
--nnoremap(opts, '<leader>bhq', ':BufferLineCloseLeft<CR>')
--nnoremap(opts, '<leader>blq', ':BufferLineCloseRight<CR>')
nnoremap(opts, '<leader>bh', ':BufferLineMovePrev<CR>')
nnoremap(opts, '<leader>bl', ':BufferLineMoveNext<CR>')

require('bufferline').setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = "none",
    indicator = {
      style = 'icon',
      icon = '▎'
    },
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",

    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = ""
      local first = true

      if (diagnostics_dict['error'] ~= nil) then
        s = s .. " " .. diagnostics_dict['error']
        first = false
      end

      if (diagnostics_dict['warning'] ~= nil) then
        if not first then
          s = s .. " "
        end

        s = s .. " " .. diagnostics_dict['warning']
      end

      if (diagnostics_dict['info'] ~= nil) then
        if not first then
          s = s .. " "
        end

        s = s .. "󰋽 " .. diagnostics_dict['info']
      end

      return s
    end,
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      -- filter out by buffer name

      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.bo[buf_number].filetype ~= "qf" then
        return true
      end
    end,
    offsets = {
      --{ filetype = "NvimTree", text = "File Explorer" },
      { filetype = "Outline", text = "Symbols Outline" },
      {
        text = "Neotree",
        filetype = "neo-tree",
        text_align = "center",
        separator = true
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    get_element_icon = function(element)
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false} )
      return icon, hl
    end,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = 'extension'
  },
  highlights = {
    indicator_selected = {
      fg = '#61afef'
    },
    indicator_visible = {
      fg = '#24282f'
    },
    tab = {
      fg = '#5c6370'
    },
    tab_selected = {
      fg = '#61afef'
    },
    buffer_selected = {
      italic = false
    },
    numbers_selected = {
      bold = false,
      italic = false,
    },
    diagnostic_selected = {
      italic = false
    },
    hint_selected = {
      italic = false
    },
    info_selected = {
      italic = false
    },
    warning_selected = {
      italic = false
    },
    error_selected = {
      italic = false
    },
    hint_diagnostic_selected = {
      bold = false,
      italic = false
    },
    info_diagnostic_selected = {
      bold = false,
      italic = false
    },
    warning_diagnostic_selected = {
      bold = false,
      italic = false
    },
    error_diagnostic_selected = {
      bold = false,
      italic = false
    }
  },
}
