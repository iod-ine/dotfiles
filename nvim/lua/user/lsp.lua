local lspconfig = require("lspconfig")

-- Python LSP Server
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
-- https://github.com/python-lsp/python-lsp-ruff#configuration
-- https://docs.astral.sh/ruff/configuration/
lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                ruff = {
                    enabled = true,
                    formatEnabled = true,
                    config = "~/.dotfiles/ruff.toml",
                }
            },
        },
    },
})


-- Lua language server (brew install lua-language-server)
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        }
    },
})

lspconfig.ltex.setup({
    autostart = false,
    settings = {
        ltex = {
            enabled = true,
            checkFrequency = "save",
            languageToolHttpServerUri = "", -- "https://api.languagetoolplus.com/",
            languageToolOrg = {
                username = "",
                apiKey = "",
            },
        },
    },
})
