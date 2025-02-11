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

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            sections = {
                lualine_x = {
                    function()
                        return "Codeium:" .. vim.api.nvim_call_function("codeium#GetStatusString", {})
                    end,
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
    }
}
