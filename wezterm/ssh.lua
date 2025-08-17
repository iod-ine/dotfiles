local wezterm = require("wezterm")
local module = {}

function module.apply(config)
    config.ssh_domains = wezterm.default_ssh_domains()
    table.insert(config.ssh_domains, {
        name = "vla5",
        remote_address = "sg-sadr-perception-005.sas.yp-c.yandex.net",
        username = "ivandubrovin",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
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
end

return module
