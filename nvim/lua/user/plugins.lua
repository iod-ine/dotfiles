return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Fuzzy finder. :Telescope is the intry point
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
        {"nvim-lua/plenary.nvim"},
    },
  })

  -- Tree-sitter code parser
  -- :TSInstall <language> to install parsers, :TSInstallInfo to list available ones
  -- :TSUpdate to update all installed parsers
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

  -- Completion with sources (:help ins-completion for built-in completion)
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")          -- Buffer words
  use("hrsh7th/cmp-path")            -- Filesystem paths
  use("hrsh7th/cmp-nvim-lsp")        -- Built-in LSP client
  use("saadparwaiz1/cmp_luasnip")    -- Snippets

  use("onsails/lspkind.nvim")        -- Formating for the completion window

  -- Colorschemes
  use("rebelot/kanagawa.nvim")
  use("folke/tokyonight.nvim")
  use("lunarvim/darkplus.nvim")
  use("lunarvim/Onedarker.nvim")
end)
