local lspconfig = require("lspconfig")

-- Python LSP Server
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
-- https://docs.astral.sh/ruff/configuration/
lspconfig.pylsp.setup({})
lspconfig.ruff.setup({})


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

-- Go language server
lspconfig.gopls.setup({})

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

lspconfig.ccls.setup({})
