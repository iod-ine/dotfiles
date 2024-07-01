return {
    -- Mappings and help
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
        end,
        opts = {},
    },

    -- Highlight TODOs, FIXMEs, NOTEs, etc. (need : after the keyword)
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    -- Configuration for built-in LSP
    "neovim/nvim-lspconfig",

    -- LSP status updates
    {
        "j-hui/fidget.nvim",
        opts = {},
    },

    -- Undo tree: undo history visualization
    "mbbill/undotree",

    -- Snippet Engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    -- Precise horizontal navigation
    "justinmk/vim-sneak",
}
