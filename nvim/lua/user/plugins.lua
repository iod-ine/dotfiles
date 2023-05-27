return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Colorschemes
  use("rebelot/kanagawa.nvim")
  use("folke/tokyonight.nvim")
  use("lunarvim/darkplus.nvim")
  use("lunarvim/Onedarker.nvim")
end)
