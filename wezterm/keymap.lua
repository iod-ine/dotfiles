local wezterm = require("wezterm")
local module = {}

function module.apply(config)
    config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
    config.keys = {
        { key = "a", mods = "LEADER|CTRL", action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }) },
        { key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal },
        { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical },
        { key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
        { key = "w", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
        { key = "d", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|DOMAINS" }) },
        {
            key = "O",
            mods = "CTRL",
            action = wezterm.action.QuickSelectArgs({
                patterns = {
                    "https?://\\S+",
                },
                action = wezterm.action_callback(function(window, pane)
                    local url = window:get_selection_text_for_pane(pane)
                    wezterm.open_with(url)
                end)
            }),
        },
    }
end

return module
