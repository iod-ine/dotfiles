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

require("treesitter-context").setup({
    -- https://github.com/nvim-treesitter/nvim-treesitter-context#configuration
    enable = true,
    max_lines = 10,
    min_window_height = 10,
    multiline_threshold = 5,
    mode = "topline",
})
