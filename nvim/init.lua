require("user.plugins")
require("user.options")
require("user.remap")
require("user.completion")

-- Set the colorscheme
vim.cmd.colorscheme("kanagawa-wave")

-- Make the background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
