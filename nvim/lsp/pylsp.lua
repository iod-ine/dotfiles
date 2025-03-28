local capabilities = require("blink.cmp").get_lsp_capabilities()

local config = {
    cmd = { "pylsp" },
    filetypes = { "python" },
    capabilities = capabilities,
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
