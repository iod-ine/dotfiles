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

  -- Colorschemes
  use("rebelot/kanagawa.nvim")
  use("folke/tokyonight.nvim")
  use("lunarvim/darkplus.nvim")
  use("lunarvim/Onedarker.nvim")
end)
