local module = {}

function module.apply(config)
    config.ssh_domains = {}
    table.insert(config.ssh_domains, {
        name = "sas4",
        remote_address = "sas4",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
    table.insert(config.ssh_domains, {
        name = "sas5",
        remote_address = "sas5",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
    table.insert(config.ssh_domains, {
        name = "vla6",
        remote_address = "vla6",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
    table.insert(config.ssh_domains, {
        name = "yandex-cloud-vm",
        remote_address = "yc",
        remote_wezterm_path = "/home/ivan/.local/bin/wezterm",
    })
end

return module
