function ApplyColorScheme(color)
  vim.opt.termguicolors = true
  if (color == "light") then
    color = "dayfox";
  elseif (color == "dark") then
    color = "nordfox";
  else
    color = color or "gruvbox-material"
  end

  if (color == "gruvbox-material") then
    vim.opt.background = "dark"
    vim.api.nvim_set_var("gruvbox_material_background", "hard")
    vim.api.nvim_set_var("gruvbox_material_transparent_background", 2)

    require("lualine").setup({
      options = {
        theme = "gruvbox-material", --"modus-vivendi"
      }
    })
  end

  if (color == "nordfox") then
    require("nightfox").setup({
      options = {
        transparent = true,
      }
    })

    require("lualine").setup({
      options = {
        theme = "nordfox",
      }
    })
  end

  if (color == "dayfox") then
    require("nightfox").setup({
      options = {
        transparent = true,
      }
    })

    require("lualine").setup({
      options = {
        theme = "dayfox",
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
        theme = "onelight" --"modus-vivendi",
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

vim.keymap.set("n", "<leader>lt", function() ApplyColorScheme("light") end);
vim.keymap.set("n", "<leader>dt", function() ApplyColorScheme("dark") end);

function ApplyColorSchemeAuto()
  -- Initial colorscheme is based on current system time.
  local hour = os.date("*t").hour;
  if (hour > 7 and hour < 18) then
    ApplyColorScheme("light")
  else
    ApplyColorScheme("dark")
  end
end

ApplyColorSchemeAuto()
