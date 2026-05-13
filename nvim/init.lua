vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.pack.add({
    'https://github.com/folke/flash.nvim',
    'https://github.com/milanglacier/minuet-ai.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    'https://github.com/rose-pine/neovim',
    { src = 'https://www.github.com/olimorris/codecompanion.nvim', version = vim.version.range('^19.0.0') },
})
