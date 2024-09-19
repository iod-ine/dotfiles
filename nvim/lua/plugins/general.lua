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
                    function()
                        return "Codeium:" .. vim.api.nvim_call_function("codeium#GetStatusString", {})
                    end,
                },
            },
        },
    },

    -- Precise horizontal navigation
    "justinmk/vim-sneak",
}
