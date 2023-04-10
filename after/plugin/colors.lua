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
        theme = "gruvbox-material", --"modus-vivendi"
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'diff', 'diagnostics' },
          lualine_c = {
            {
              'buffers',
              show_filename_only = true,       -- Shows shortened relative path when set to false.
              hide_filename_extension = false, -- Hide filename extension when set to true.
              show_modified_status = true,     -- Shows indicator when the buffer is modified.
              mode = 0,                        -- 0: Shows buffer name
              -- 1: Shows buffer index
              -- 2: Shows buffer name + buffer index
              -- 3: Shows buffer number
              -- 4: Shows buffer name + buffer number

              max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
              -- it can also be a function that returns
              -- the value of `max_length` dynamically.
              filetype_names = {
                TelescopePrompt = 'Telescope',
                dashboard = 'Dashboard',
                packer = 'Packer',
                fzf = 'FZF',
                alpha = 'Alpha'
              }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
              -- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
              use_mode_colors = false,
              buffers_color = {
                -- Same values as the general color option can be used here.
                active = 'lualine_{section}_normal',     -- Color for active buffer.
                inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
              },
              symbols = {
                modified = ' ●',    -- Text to show when the buffer is modified
                alternate_file = '#', -- Text to show to identify the alternate file
                directory = '',    -- Text to show when the buffer is a directory
              },
            }
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
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

vim.keymap.set("n", "<leader>lt", function() ApplyColorScheme("catppuccin") end);
vim.keymap.set("n", "<leader>dt", function() ApplyColorScheme("gruvbox-material") end);

-- Initial colorscheme is based on current system time.
local hour = os.date("*t").hour;
if (hour > 6 and hour < 22) then
  ApplyColorScheme("light")
else
  ApplyColorScheme("dark")
end
