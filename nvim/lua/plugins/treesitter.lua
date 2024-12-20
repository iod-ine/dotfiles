return {
    -- Tree-sitter code parser
    -- :TSInstall <lang> to install parsers, :TSInstallInfo to list available ones
    -- :TSUpdate to update all installed parsers
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                -- The seven parsers above must always be installed
                "python",
            },
            sync_install = false,
            auto_install = false,
            highlight = { enable = true },
        },
    },
    { "nvim-treesitter/nvim-treesitter-context", opts = {} },
}
