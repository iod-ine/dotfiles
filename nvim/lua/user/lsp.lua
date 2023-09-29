local lspconfig = require("lspconfig")

-- Python LSP Server
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            configurationSources = {"flake8"},  -- Load the default configuration
            plugins = {
                pycodestyle = { enabled = false },
                flake8 = { enabled = true },
            },
        },
    },
})
