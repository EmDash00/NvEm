local optl = vim.opt_local

optl.tabstop = 2
optl.shiftwidth = 2

optl.cindent = true

optl.textwidth = 80
optl.colorcolumn = '81'
optl.comments = 'sl:/*,mb: *,elx: */'
vim.treesitter.start()
