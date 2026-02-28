local wezterm = require("wezterm")
local module = {}

local function get_system_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return "Dark"
end

function module.apply(config)
    config.font_size = 13

    config.enable_tab_bar = true
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = true
    config.show_new_tab_button_in_tab_bar = false
    config.window_decorations = "RESIZE"
    config.window_background_opacity = 0.95
    config.macos_window_background_blur = 10

    config.window_padding = {
        left = 10,
        right = 10,
        top = 0,
        bottom = 0,
    }

    config.color_scheme = get_system_appearance() == "Dark" and "rose-pine" or "rose-pine-dawn"

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
end

return module
