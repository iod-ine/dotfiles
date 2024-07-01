return {
    {
        "rose-pine/neovim",
        lazy = false,    -- Load during startup, since this is the default colorscheme
        priority = 1000, -- Load before any other start plugins
        name = "rose-pine",
        config = function()
            vim.cmd.colorscheme("rose-pine")
        end
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
    },
    {
        "lunarvim/Onedarker.nvim",
        lazy = true,
    },
    {
        "morhetz/gruvbox",
        lazy = true,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
    },
}
