function ApplyColorScheme(color)
  vim.opt.termguicolors = true
  if (color == "light") then
    color = "catppuccin";
  elseif (color == "dark") then
    color = "gruvbox-material";
  else
    color = color or "gruvbox-material"
  end

  if (color == "gruvbox-material") then
    vim.opt.background = "dark"
    vim.api.nvim_set_var("gruvbox_material_background", "hard")
    vim.api.nvim_set_var("gruvbox_material_transparent_background", 2)

    require("lualine").setup({
      options = {
        theme = "gruvbox-material" --"modus-vivendi"
      }
    })
  end

  if (color == "catppuccin") then
    require("catppuccin").setup({
      flavour = "latte",
      transparent_background = true,
    })

    require("lualine").setup({
      options = {
        theme = "onelight" --"modus-vivendi"
      }
    })

    vim.opt.background = "light"
  end

  vim.cmd.colorscheme(color)

  --vim.api.nvim_set_hl(0, "Normal", { bg = "#181b1d" })
  --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181b1d" })
  --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.keymap.set("n", "<leader>lt", function() ApplyColorScheme("catppuccin") end);
vim.keymap.set("n", "<leader>dt", function() ApplyColorScheme("gruvbox-material") end);

-- Initial colorscheme is based on current system time.
local hour = os.date("*t").hour;
if (hour > 6 and hour < 22) then
  ApplyColorScheme("light")
else
  ApplyColorScheme("dark")
end
