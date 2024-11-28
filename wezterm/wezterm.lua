local wezterm = require "wezterm"
local config = {}

config.color_scheme = "Catppuccin Macchiato"

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
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
    {
        key = "z",
        mods = "LEADER",
        action = wezterm.action.TogglePaneZoomState,
    },
    {
        key = "w",
        mods = "LEADER",
        action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },
    {
        key = "d",
        mods = "LEADER",
        action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|DOMAINS" }),
    },
    {
        key = "O",
        mods = "CTRL",
        action = wezterm.action.QuickSelectArgs({
            patterns = {
                "https?://\\S+",
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info('opening: ' .. url)
                wezterm.open_with(url)
            end)
        }),
    },
}

config.window_padding = {
    left = 10,
    right = 10,
    top = 0,
    bottom = 0,
}

wezterm.on("update-right-status", function(window, pane)
    local date = wezterm.strftime("%A, %B %d, %H:%M")
    local workspace = window:active_workspace()
    local domain = pane:get_domain_name()

    window:set_left_status(
        wezterm.format({
            { Text = string.format("[%s] ", workspace) },
        })
    )

    window:set_right_status(
        wezterm.format({
            { Attribute = { Intensity = "Bold" } },
            { Text = string.format("[%s] ", domain) },
            "ResetAttributes",
            { Attribute = { Italic = true } },
            { Text = date },
        })
    )
end)

config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, {
    regex = [[REVIEW: (\d+)]],
    format = "https://a.yandex-team.ru/review/$1",
})

return config
