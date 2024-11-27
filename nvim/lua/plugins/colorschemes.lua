return {
    {
        "catppuccin/nvim",
        lazy = false,    -- Load during startup, since this is the default colorscheme
        priority = 1000, -- Load before any other start plugins
        name = "catppuccin",
        config = function()
            vim.cmd.colorscheme("catppuccin-macchiato")
        end
    },
    {
        "rose-pine/neovim",
        lazy = true,
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
