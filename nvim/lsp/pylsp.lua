local config = {
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", ".git" },
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
