require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        -- These five should always be installed
    },
    sync_install = false,
    auto_install = false,
    highlight = { enable = true },
})
