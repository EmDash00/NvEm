return {
  "emmet-vim",
  ft = { "html", "htmlx", "shtml" },
  before = function()
    --vim.g.user_emet_settings = vim.cmd(
    --[[ webapi#json#decode(join(readfile(expand('~/.snippets_custom.json')), "\n")) ]]
    --)

    vim.g.user_emmet_install_global = false;
  end
}
