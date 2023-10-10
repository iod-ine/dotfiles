-- Disable netrw (using the nvim-tree plugin instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("user.plugins")
require("user.options")
require("user.remap")
require("user.completion")
require("user.filetypes")
require("user.lsp")

-- Set the colorscheme
vim.cmd.colorscheme("rose-pine")

