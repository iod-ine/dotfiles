local lspconfig = require("lspconfig")

-- Python LSP Server
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
-- https://docs.astral.sh/ruff/configuration/
if string.find(vim.fn.getcwd(), "arcadia") then
    lspconfig.pylsp.setup({
        settings = {
            pylsp = {
                plugins = {
                    jedi = {
                        extra_paths = {
                            "/Users/ivandubrovin/arcadia/",
                        },
                    },
                },
            },
        },
    })
else
    lspconfig.pylsp.setup({})
end

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

lspconfig.ccls.setup({})
