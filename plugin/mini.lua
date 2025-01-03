local bufremove = require("mini.bufremove")
bufremove.setup()
vim.keymap.set('n', '<leader>bd', bufremove.wipeout)
