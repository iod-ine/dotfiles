require("nvim-treesitter.configs").setup({
  ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      -- The first five should always be installed
      "python",
      "r",
      "make",
      "sql",
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
