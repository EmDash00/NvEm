local Rule = require('nvim-autopairs.rule')
local nvim_autopairs = require('nvim-autopairs')

nvim_autopairs.setup {
  break_undo = false,
  map_cr = false,
  check_ts = true,
  ts_config = {
    lua = {'string'},
    python = {'string'},
    rust = {'string'},
  },
}

nvim_autopairs.add_rules {
  Rule("\\(", "\\)", "tex"),
  Rule("\\[", "\\]", "tex"),
}

