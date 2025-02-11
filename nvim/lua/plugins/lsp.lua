return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    }
                },
                capabilities = capabilities,
            })

            if string.find(vim.fn.getcwd(), "arcadia") then
                lspconfig.pylsp.setup({
                    settings = {
                        pylsp = {
                            plugins = {
                                jedi = { extra_paths = { "/Users/ivandubrovin/arcadia/" } },
                            },
                        },
                    },
                    capabilities = capabilities,
                })
            else
                lspconfig.pylsp.setup({ capabilities = capabilities })
            end

            lspconfig.ruff.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.ccls.setup({ capabilities = capabilities })
        end
    },
    -- LSP status updates
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
}
