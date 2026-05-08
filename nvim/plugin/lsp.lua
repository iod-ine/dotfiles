vim.lsp.enable({ 'lua_ls' })

vim.keymap.set('n', '<Leader>bf', vim.lsp.buf.format, { desc = 'format' })
