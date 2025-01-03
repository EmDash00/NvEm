return {
  "onedark",
  colorscheme = "onedark",
  after = function()
    require('onedark').setup {
      ending_tildes = false,
    }
  end
}
