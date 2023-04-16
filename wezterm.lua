-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

local arch = os.getenv("OS")
if (arch == "Windows_NT") then
  config.default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" }
  config.font = wezterm.font { family = 'IosevkaTerm NF' }
  config.font_size = 11.0
  config.initial_cols = 200
  config.initial_rows = 70
else
  config.default_prog = { "/bin/sh" }
  config.font = wezterm.font("Iosevka")
  config.font_size = 14.0
end

config.window_background_opacity = 0.95

-- Initial colorscheme is based on current system time.
local hour = os.date("*t").hour;
if (hour > 6 and hour < 22) then
  config.color_scheme = "dayfox"
else
  config.color_scheme = "carbonfox"
end

-- dpi = 192.0,
--config.font_antialias = "Subpixel" -- None, Greyscale, Subpixel
--config.font_hinting = "Full"  -- None, Vertical, VerticalSubpixel, Full
config.leader = { key = "a", mods = "CTRL" }
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
  { key = "a",  mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
  { key = "-",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "\\", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "s",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "v",  mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "o",  mods = "LEADER",       action = "TogglePaneZoomState" },
  { key = "z",  mods = "LEADER",       action = "TogglePaneZoomState" },
  { key = "c",  mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
  { key = "h",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "j",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
  { key = "k",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "l",  mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "H",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
  { key = "J",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
  { key = "K",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
  { key = "L",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
  { key = "1",  mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
  { key = "2",  mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
  { key = "3",  mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
  { key = "4",  mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
  { key = "5",  mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
  { key = "6",  mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
  { key = "7",  mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
  { key = "8",  mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
  { key = "9",  mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
  { key = "&",  mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
  { key = "d",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
  { key = "x",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
}

-- and finally, return the configuration to wezterm
return config
