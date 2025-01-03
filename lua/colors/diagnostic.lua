local highlights = {
  --DiagnosticError = { ctermfg = 1, fg = 'Red' },
  DiagnosticWarn = { ctermfg = 3, fg = 'Orange' },
  DiagnosticInfo = { ctermfg = 4, fg = 'LightBlue' },
  DiagnosticHint = { ctermfg = 7, fg = 'LightGrey' },

  --DiagnosticUnderlineError = { cterm = { underline = true }, undercurl = true, sp = 'Red' },
  DiagnosticUnderlineWarn = { cterm = { underline = true }, undercurl = true, sp = 'Orange' },
  DiagnosticUnderlineInfo = { cterm = { underline = true }, undercurl = true, sp = 'LightBlue' },
  DiagnosticUnderlineHint = { cterm = { underline = true }, undercurl = true, sp = 'LightGrey' },
}

require('colors').set_hls(highlights)
