return {
  "nvim-lightbulb",
  event = "BufEnter",
  after = function ()
    require("nvim-lightbulb").setup {
      link_highlights = false,
      autocmd = { enabled = true },
      sign = {
        enabled = false
      },
      virtual_text = {
        enabled = true,
        text = "",
        lens_text = "󰍉"
      }
    }
  end
}
