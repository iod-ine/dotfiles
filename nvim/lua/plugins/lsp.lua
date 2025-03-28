return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

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
