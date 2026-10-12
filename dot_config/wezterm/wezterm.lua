-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

local is_windows = function()
  return wezterm.target_triple:find("windows") ~= nil
end

if is_windows() then
  config.default_prog = { 'wsl', '-d', '--cd', '~' }
end

config.launch_menu = {}

if is_windows() then
  table.insert(config.launch_menu, {
    label = 'PowerShell',
    domain = { DomainName = "local" },
    args = { 'powershell.exe', '-NoLogo' },
  })
end

-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function(cmd)
--     local tab, pane, window = mux.spawn_window(cmd or {})
--     window:gui_window():maximize()
-- end)

-- This is where you actually apply your config choices
config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("FiraCode Nerd Font Mono")

config.font_size = 12

config.enable_tab_bar = false

config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

config.keys = {
  { key = 'l', mods = 'CTRL|ALT', action = wezterm.action.ShowLauncher },
}

-- and finally, return the configuration to wezterm
return config
