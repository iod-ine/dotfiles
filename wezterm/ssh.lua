local module = {}

function module.apply(config)
    config.ssh_domains = {}
    table.insert(config.ssh_domains, {
        name = "sas",
        remote_address = "sas",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
    table.insert(config.ssh_domains, {
        name = "vla",
        remote_address = "vla",
        remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
    })
    table.insert(config.ssh_domains, {
        name = "yandex-cloud-vm",
        remote_address = "yc",
        remote_wezterm_path = "/home/ivan/.local/bin/wezterm",
    })
end

return module
