vim.lsp.enable({ 'lua_ls' })

vim.diagnostic.config({ virtual_lines = false, virtual_text = true })

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Create buffer-local LSP keymaps',
    callback = function(args)
        -- Buffers
        vim.keymap.set('n', '<Leader>bf', vim.lsp.buf.format, { buf = args.buf, desc = 'format' })

        -- Toggle
        local toggle_lsp_diagnostics = function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
        end

        vim.keymap.set('n', '<Leader>tq', toggle_lsp_diagnostics, { buf = args.buf, desc = 'diagnostics' })
    end,
})
