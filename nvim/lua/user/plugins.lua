-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Fuzzy finder. :Telescope is the entry point
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = [[
            cmake -S . -Bbuild -DCMAKE_BUILD_TYPE=Release && \
            cmake --build build --config Release && \
            cmake --install build --prefix build
        ]],
    },
    "nvim-telescope/telescope-file-browser.nvim",

    -- Tree-sitter code parser
    -- :TSInstall <lang> to install parsers, :TSInstallInfo to list available ones
    -- :TSUpdate to update all installed parsers
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "nvim-treesitter/nvim-treesitter-context",

    -- Undo tree: undo history visualization
    "mbbill/undotree",

    -- Snippet Engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },

    -- Completion with sources (:help ins-completion for built-in completion)
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",        -- Buffer words
    "hrsh7th/cmp-path",          -- Filesystem paths
    "hrsh7th/cmp-nvim-lsp",      -- Built-in LSP client
    "saadparwaiz1/cmp_luasnip",  -- Snippets
    "onsails/lspkind.nvim",      -- Formatting for the completion window

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

    -- Configuration for built-in LSP
    "neovim/nvim-lspconfig",

    -- Managing comments
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {},
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    -- Precise horizontal navigation
    "justinmk/vim-sneak",

    -- Colorschemes
    "rebelot/kanagawa.nvim",
    "lunarvim/Onedarker.nvim",
    "morhetz/gruvbox",
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
})
