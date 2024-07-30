-- :help lua-guide-autocommands

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-autocmds", { clear = true }),
    callback = function()
        local clients = vim.lsp.get_active_clients()
        for _, client in ipairs(clients) do
            if client.supports_method("textDocument/documentHighlight") then
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    callback = vim.lsp.buf.clear_references,
                })
                break
            end
        end
    end,
})
