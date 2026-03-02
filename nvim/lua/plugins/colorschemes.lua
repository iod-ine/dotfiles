return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- Load during startup, since this is the default colorscheme
        priority = 1000, -- Load before any other start plugins
        config = function()
            vim.cmd.colorscheme("tokyonight-moon")
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
        "catppuccin/nvim",
        lazy = true,
    },
}
