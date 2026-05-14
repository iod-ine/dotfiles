vim.lsp.enable({
    'clangd',
    'lua_ls',
    'ruff',
    'ty',
})

vim.diagnostic.config({ virtual_lines = false, virtual_text = true })

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Create buffer-local LSP keymaps',
    callback = function(args)
        -- Keymaps
        -- Keymaps: Buffers
        vim.keymap.set('n', '<Leader>bf', vim.lsp.buf.format, { buf = args.buf, desc = 'format' })

        -- Keymaps: Toggle
        local toggle_lsp_diagnostics = function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
        end
        vim.keymap.set('n', '<Leader>tq', toggle_lsp_diagnostics, { buf = args.buf, desc = 'diagnostics' })

        -- Client-specific configuration
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == 'ruff' then
            -- Both ruff and ty provide hover capability. Disable it in ruff to avoid race conditions
            client.server_capabilities.hoverProvider = false
        end
    end,
})
