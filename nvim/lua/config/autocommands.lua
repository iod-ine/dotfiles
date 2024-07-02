-- :help lua-guide-autocommands

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-autocmds", { clear = true }),
    callback = function()
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            pattern = { "*.py", "*.lua", "*.c", "*.cpp" },
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            pattern = { "*.py", "*.lua", "*.c", "*.cpp" },
            callback = vim.lsp.buf.clear_references,
        })
    end,
})
