local vimp = require('vimp')
local nnoremap = vimp.nnoremap

local opts = {'silent'}

vim.g.mkdp_auto_close = 1
vim.g.mkdp_theme = 'light'

nnoremap(opts, '<C-p>', '<Plug>MarkdownPreview')
