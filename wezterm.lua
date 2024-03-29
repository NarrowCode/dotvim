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

config.window_background_opacity = 0.95
config.window_background_gradient = {
  colors = { '#1e1f20', '#1e1f20' },
  orientation = { Linear = { angle = -45.0 } },
}
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false


local arch = os.getenv("OS")
if (arch == "Windows_NT") then
  config.default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" }
  config.font = wezterm.font_with_fallback {
    { family = 'IosevkaTerm NF', weight = 'Medium' },
    'Hack NF',
    'CaskaydiaCove NF',
    'Consolas',
  }

  config.font_size = 12.0
  config.initial_cols = 200
  config.initial_rows = 70
  config.win32_system_backdrop = 'Acrylic'
else
  --config.default_prog = { "/bin/sh" }
  config.font = wezterm.font("Iosevka")

  config.font = wezterm.font_with_fallback {
    { family = 'IBM Plex Mono', weight = "Regular", harfbuzz_features = { 'liga=0' } },
    { family = 'IosevkaTerm Nerd Font', weight = "Medium" },
    { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
    'Hack Nerd Font',
    'San Francisco',
  }
  config.font_size = 15.0
  config.macos_window_background_blur = 10
  config.window_background_opacity = 1
  config.window_decorations = "TITLE | RESIZE"
  config.window_padding = {
    left = 20,
    right = 20,
    top = 10,
    bottom = 10,
  }
end

if (arch == "Windows_NT") then
  config.window_background_opacity = 0.97
  config.win32_system_backdrop = 'Disable'
end

-- Initialize based on system time
function scheme_for_time()
  local hour = os.date("*t").hour;
  if (hour > 7 and hour < 18) then
    return 'Light'
  else
    return 'Dark'
  end
end

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return scheme_for_time()
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Gruvbox dark, medium (base16)' -- 'nightfox'
  else
    return 'Gruvbox dark, medium (base16)'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

local act = wezterm.action
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
  { key = "x",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  { key = "1", mods = "CTRL|ALT", action = wezterm.action.MoveTab(0) },
  { key = "2", mods = "CTRL|ALT", action = wezterm.action.MoveTab(1) },
  { key = "3", mods = "CTRL|ALT", action = wezterm.action.MoveTab(2) },
  { key = "4", mods = "CTRL|ALT", action = wezterm.action.MoveTab(3) },
  { key = "5", mods = "CTRL|ALT", action = wezterm.action.MoveTab(4) },
  { key = "6", mods = "CTRL|ALT", action = wezterm.action.MoveTab(5) },
  { key = "7", mods = "CTRL|ALT", action = wezterm.action.MoveTab(6) },
  { key = "8", mods = "CTRL|ALT", action = wezterm.action.MoveTab(7) },
}

-- and finally, return the configuration to wezterm
return config
