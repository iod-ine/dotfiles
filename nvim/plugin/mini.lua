vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.basics').setup({
    options = { basic = false },
    mappings = { basic = false },
    autocommands = { basic = true },
})
require('mini.clue').setup({
    triggers = {
        { mode = { 'n', 'x' }, keys = '<Leader>' },
        { mode = { 'n', 'x' }, keys = '<LocalLeader>' },
    },
    clues = {
        { mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
        { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
        { mode = 'n', keys = '<Leader>f', desc = '+Find' },
        { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
    },
})
require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.diff').setup({ view = { style = 'number' } })
require('mini.extra').setup()
require('mini.files').setup({ windows = { preview = true, width_preview = 50 } })
require('mini.icons').setup()
require('mini.indentscope').setup({ draw = { animation = require('mini.indentscope').gen_animation.none() } })
require('mini.move').setup({
    mappings = {
        left = '<C-M-h>',
        right = '<C-M-l>',
        down = '<C-M-j>',
        up = '<C-M-k>',
        line_left = '<C-M-h>',
        line_right = '<C-M-l>',
        line_down = '<C-M-j>',
        line_up = '<C-M-k>',
    }
})
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.splitjoin').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()

-- More information on mini.pick pickers:
--   https://nvim-mini.org/mini.nvim/doc/mini-pick.html#minipick.builtin
--   https://nvim-mini.org/mini.nvim/doc/mini-extra.html#miniextra.pickers

-- Explore:
vim.keymap.set('n', '<Leader>eD', '<Cmd>lua MiniFiles.open()<CR>', { desc = 'working directory' })
vim.keymap.set('n', '<Leader>ed', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>',
    { desc = 'current file directory' })

-- Find:
vim.keymap.set('n', '<Leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'buffers' })
vim.keymap.set('n', '<Leader>fD', '<Cmd>Pick diagnostic scope="all"<CR>', { desc = 'diagnostics (all)' })
vim.keymap.set('n', '<Leader>fd', '<Cmd>Pick diagnostic scope="current"<CR>', { desc = 'diagnostics (buffer)' })
vim.keymap.set('n', '<Leader>ff', '<Cmd>Pick files<CR>', { desc = 'files' })
vim.keymap.set('n', '<Leader>fh', '<Cmd>Pick help<CR>', { desc = 'help' })
vim.keymap.set('n', '<Leader>fr', '<Cmd>Pick oldfiles<CR>', { desc = 'recent files' })
vim.keymap.set('n', '<Leader>fl', '<Cmd>Pick grep_live<CR>', { desc = 'grep live' })

-- Toggle:
local toggle_local_cursorword = function()
    vim.b.minicursorword_disable = not vim.b.minicursorword_disable
end

vim.keymap.set('n', '<LocalLeader>C', toggle_local_cursorword, { desc = 'Toggle cursorword' })
