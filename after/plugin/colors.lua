function ApplyColorScheme(color)
  vim.opt.termguicolors = true
  if (color == "light") then
    color = "dayfox";
  elseif (color == "dark") then
    color = "gruvbox-material";
  else
    color = color or "gruvbox-material"
  end

  if (color == "gruvbox-material") then
    vim.opt.background = "dark"
    vim.api.nvim_set_var("gruvbox_material_background", "hard")
    vim.api.nvim_set_var("gruvbox_material_transparent_background", 1)

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
      flavour = "mocha",
      transparent_background = true,
    })

    require("lualine").setup({
      options = {
        theme = "modus-vivendi" --"modus-vivendi",
      }
    })

    vim.opt.background = "dark"
  end

  vim.cmd.colorscheme(color)

  vim.cmd [[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent guifg=#2c3238 gui=nocombine]]

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

ApplyColorScheme("dark")
