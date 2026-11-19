local module = {}

function module.apply(config)
    config.ssh_domains = {
        {
            name = "freddy",
            remote_address = "freddy",
            remote_wezterm_path = "/home/ivandubrovin/.local/bin/wezterm",
        },
    }
end

return module
