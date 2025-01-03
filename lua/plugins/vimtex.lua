return {
  "vimtex",
  ft = "tex",
  before = function()
    vim.g.tex_flavor = 'latex'
    vim.g.Tex_DefaultTargetFormat = 'pdf'
    vim.g.vimtex_compiler_progname = 'nvr'

    vim.g.vimtex_view_enabled = 1
    vim.g.vimtex_view_automatic = 1
    vim.g.vimtex_view_general_viewer = 'zathura'
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_quickfix_enabled = false

    --vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
    --vim.g.vimtex_view_general_options_latexmk = '--unique'

    vim.g.tex_conceal = 'abdmg'
  end
}
