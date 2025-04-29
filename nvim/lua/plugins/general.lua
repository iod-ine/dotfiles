return {
    -- Mappings and help
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Highlight TODOs, FIXMEs, NOTEs, etc. (need : after the keyword)
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    -- Undo tree: undo history visualization
    "mbbill/undotree",

    -- Surroundings (:h surround)
    "tpope/vim-surround",

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            sections = {
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },
            },
        },
    },

    -- Precise horizontal navigation
    "justinmk/vim-sneak",

    -- File explorer
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
