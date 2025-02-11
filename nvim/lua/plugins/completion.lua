return {
    {
        "saghen/blink.cmp",
        dependencies = "rafamadriz/friendly-snippets",
        version = "*",
        opts = {
            keymap = { preset = "default" },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono"
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
        },
        opts_extend = { "sources.default" },
        signature = { enabled = true },
    },
    "onsails/lspkind.nvim", -- Formatting for the completion window
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
                    { "<leader>tA", "<cmd>CodeiumToggle<cr>", desc = "Codeium" },
                    {
                        -- It was very annoying to figure out how to set these mappings up.
                        -- And the way they need to be set up is also annoying :)
                        mode = "i",
                        expr = true,
                        { "<M-e>", function() return vim.fn["codeium#Clear"]() end },
                        { "<M-l>", function() return vim.fn["codeium#AcceptNextLine"]() end },
                        { "<M-n>", function() return vim.fn["codeium#CycleOrComplete"]() end },
                        { "<M-p>", function() return vim.fn["codeium#CycleCompletions"](-1) end },
                        { "<M-w>", function() return vim.fn["codeium#AcceptNextWord"]() end },
                        { "<M-y>", function() return vim.fn["codeium#Accept"]() end },
                    },
                }
            )
        end,
    },
}
