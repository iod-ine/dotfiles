return {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",       -- Buffer words
    "hrsh7th/cmp-path",         -- Filesystem paths
    "hrsh7th/cmp-nvim-lsp",     -- Built-in LSP client
    "saadparwaiz1/cmp_luasnip", -- Snippets
    "onsails/lspkind.nvim",     -- Formatting for the completion window
    {
        "Exafunction/codeium.vim",
        init = function()
            vim.g.codeium_enabled = false
            vim.g.codeium_disable_bindings = true
            vim.g.codeium_idle_delay = 500
            vim.g.codeium_manual = true
        end,
        config = function()
            local which_key = require("which-key")

            which_key.add(
                {
                    {
                        "<leader>ta",
                        function() vim.g.codeium_manual = not vim.g.codeium_manual end,
                        desc = "Codeium autosuggest",
                    },
                    { "<leader>tA", "<cmd>CodeiumToggle<cr>", desc = "Codeium" },
                    {
                        -- It was very annoying to figure out how to set these mappings up.
                        -- And the way they need to be set up is also annoying :)
                        mode = "i",
                        expr = true,
                        { "<M-e>", function() return vim.fn["codeium#Accept"]() end },
                        { "<M-l>", function() return vim.fn["codeium#AcceptNextLine"]() end },
                        { "<M-n>", function() return vim.fn["codeium#CycleOrComplete"]() end },
                        { "<M-p>", function() return vim.fn["codeium#CycleCompletions"](-1) end },
                        { "<M-w>", function() return vim.fn["codeium#AcceptNextWord"]() end },
                        { "<M-x>", function() return vim.fn["codeium#Clear"]() end },
                    },
                }
            )
        end,
    },
}
