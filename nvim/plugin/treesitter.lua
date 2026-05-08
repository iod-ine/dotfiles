vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
})

require('nvim-treesitter').install({
    'lua',
    'markdown',
    'python',
    'yaml',
})
