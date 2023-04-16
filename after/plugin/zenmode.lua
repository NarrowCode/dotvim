vim.keymap.set("n", "<leader>zz", function()
  ApplyColorSchemeAuto()
  require("zen-mode").setup {
    window = {
      backdrop = 1,
      width = 120,
      options = {}
    },
  }
  require("zen-mode").toggle()
  vim.wo.wrap = false
  vim.wo.number = true
  vim.wo.rnu = true
end)
