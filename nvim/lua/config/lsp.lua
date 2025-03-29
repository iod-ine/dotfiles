vim.lsp.config(
    "*",
    {
        root_markers = { ".git" },
    }
)

vim.lsp.enable({ "lua_ls", "pylsp", "ruff" })

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Highlight symbol under cursor",
    group = vim.api.nvim_create_augroup("lsp-highlight-symbol", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client:supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                callback = vim.lsp.buf.document_highlight,
                buffer = event.buf,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                callback = vim.lsp.buf.clear_references,
                buffer = event.buf,
            })
        end
    end,
})

vim.cmd("set completeopt+=noselect")

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP autocompletion",
    group = vim.api.nvim_create_augroup("lsp-autocompletion", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
    end,
})
