local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("keymap").apply(config)
require("ssh").apply(config)
require("appearance").apply(config)

config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, 1, {
    regex = [[sbr:\/\/(\d+)]],
    format = "https://sandbox.yandex-team.ru/resource/$1",
})
table.insert(config.hyperlink_rules, {
    regex = [[REVIEW: (\d+)]],
    format = "https://a.yandex-team.ru/review/$1",
})
table.insert(config.hyperlink_rules, {
    regex = [[([A-Z]+-\d+)]],
    format = "https://st.yandex-team.ru/$1",
})
table.insert(config.hyperlink_rules, {
    regex = [[(\/\/home\/[a-zA-Z0-9/_.:-]+)]],
    format = "https://yt.yandex-team.ru/kolmogorov/navigation?path=$1",
})

return config
