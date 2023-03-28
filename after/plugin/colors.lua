--require("catppuccin").setup({
--  flavour = "latte",
--})
--

function ApplyColorScheme(color)
  vim.opt.termguicolors = true
  color = color or "gruvbox-baby"
  vim.cmd.colorscheme(color)

  --vim.api.nvim_set_hl(0, "Normal", { bg = "#181b1d" })
  --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181b1d" })
  --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ApplyColorScheme()
