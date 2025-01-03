local opt = vim.opt

vim.cmd([[au BufRead,BufNewFile *.jq setfiletype jq]])
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
vim.g.python3_host_prog=vim.fn.expand("$XDG_DATA_HOME/nvim/venv/bin/python3")
opt.termguicolors = true

require('colors')
require('autofuncs')
--require('plugins')
--require('surround')
require('keymaps')


vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "set formatoptions+=t"
})
opt.expandtab = true
opt.showmode = false
opt.hidden = true

opt.cursorline = true
opt.number = true
opt.signcolumn = 'number'

opt.backspace = { 'indent', 'eol', 'start' }
opt.laststatus = 2

opt.enc = 'utf-8'
opt.fenc = 'utf-8'
-- opt.termencoding = 'utf-8'

opt.tabstop = 2
opt.shiftwidth = 2

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 10

opt.signcolumn = 'auto'

opt.clipboard = 'unnamedplus'

opt.guicursor =
  'a:blinkwait500-blinkon300-blinkoff200,' ..
  'i-ci:ver30-blinkwait500-blinkon300-blinkoff200'

vim.cmd("colorscheme onedark")
