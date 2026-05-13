require('flash').setup()

vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require("flash").treesitter() end, {})
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require("flash").jump() end, {})
