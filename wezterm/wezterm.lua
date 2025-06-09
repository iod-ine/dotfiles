local wezterm = require("wezterm")
local keymap = require("keymap")

local config = {}

local function get_system_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return "Dark"
end

config.color_scheme = get_system_appearance() == "Dark" and "Catppuccin Macchiato" or "Catppuccin Latte"
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

keymap.apply(config)

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
table.insert(config.hyperlink_rules, {
    regex = [[([A-Z]+-\d+)]],
    format = "https://st.yandex-team.ru/$1",
})

config.ssh_domains = wezterm.default_ssh_domains()

table.insert(config.ssh_domains, {
    name = "dev",
    remote_address = "sg-sadr-perception-006.vla.yp-c.yandex.net",
    username = "ivandubrovin",
    remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
})
table.insert(config.ssh_domains, {
    name = "sas-dev",
    remote_address = "mg-sadr-perception-001.sas.yp-c.yandex.net",
    username = "ivandubrovin",
    remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
})

return config
