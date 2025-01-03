local bgcolor = require('colors').bgcolor

require('colors').set_hls{
  MatchParen = { cterm = { bold = true }, ctermfg = 168, ctermbg = 16, fg = '#e06c75', bold = true },
  FloatBorder = { ctermfg = 16, ctermbg = 16, fg = '#5c6370', bg = bgcolor },
  NormalFloat = { ctermfg = 16, ctermbg = 16, bg = bgcolor },
  VertSplit = { ctermfg = 16, ctermbg = 16, fg = '#3b4048', bg = bgcolor },
  --SignColumn = { fg='#abb2bf', bg='#2b2f38' },
  --LineNr = { fg = '#5c6370', bg = '#2b2f38' },
  --CursorLineNr = { bold = true, fg = '#abb2bf', bg = '#2b2f38' }
}
