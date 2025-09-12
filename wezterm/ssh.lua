local module = {}

function module.apply(config)
    config.ssh_domains = {}
    table.insert(config.ssh_domains, {
        name = "sas4",
        remote_address = "sg-sadr-perception-004.sas.yp-c.yandex.net",
        username = "ivandubrovin",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
    table.insert(config.ssh_domains, {
        name = "sas5",
        remote_address = "sg-sadr-perception-005.sas.yp-c.yandex.net",
        username = "ivandubrovin",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
    table.insert(config.ssh_domains, {
        name = "vla6",
        remote_address = "sg-sadr-perception-006.vla.yp-c.yandex.net",
        username = "ivandubrovin",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
end

return module
