local config = {
    cmd = { "pylsp" },
    filetypes = { "python" },
}

if string.find(vim.fn.getcwd(), "arcadia") then
    config.settings = {
        pylsp = {
            plugins = {
                jedi = {
                    extra_paths = {
                        "/Users/ivandubrovin/arcadia/",
                        "/Users/ivandubrovin/arcadia/nirvana/vh3/src/",
                    }
                },
            },
        },
    }
end

return config
