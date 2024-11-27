local wezterm = require "wezterm"
local config = {}

config.color_scheme = "Catppuccin Macchiato"

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
    {
        key = "a",
        mods = "LEADER|CTRL",
        action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
    },
    {
        key = "|",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal,
    },
    {
        key = "-",
        mods = "LEADER",
        action = wezterm.action.SplitVertical,
    },
}

return config
