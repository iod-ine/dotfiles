local iron = require("iron.core")

iron.setup({
    config = {
        scratch_repl = true,
        repl_definition = {
            python = {
                command = { "uv", "run", "ipython", "--no-autoindent", "--no-confirm-exit" },
                format = require("iron.fts.common").bracketed_paste_python,
            },
            lua = {
                command = { "lua" },
            },
        },
        ignore_blank_lines = true,
        repl_open_cmd = require("iron.view").split.vertical.botright(80),
    },
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'python', 'lua' },
    desc = 'Set up Iron REPL keybindings',
    group = vim.api.nvim_create_augroup('iron-repl-bindings', { clear = true }),
    callback = function(event)
        -- :h iron-commands
        -- :h iron-functions
        -- REPL is run in the TERMINAL mode. To exit to normal mode: <C-\><C-n>
        -- Any configured REPL can be created by :IronRepl ft or :IronReplHere ft
        -- and then forcefully attached to the current buffer by :IronAttach ft.
        vim.keymap.set('n', '<leader>rc', iron.send_until_cursor, { buffer = event.buf, desc = 'send until cursor' })
        vim.keymap.set('n', '<leader>rr', '<cmd>IronRepl<cr>', { buffer = event.buf, desc = 'open repl' })
        vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>', { buffer = event.buf, desc = 'focus repl' })
        vim.keymap.set('n', '<leader>rF', iron.send_file, { buffer = event.buf, desc = 'send file' })
        vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>', { buffer = event.buf, desc = 'hide repl' })
        vim.keymap.set('n', '<leader>rl', iron.send_line, { buffer = event.buf, desc = 'send line' })
        vim.keymap.set('n', '<leader>rp', iron.send_paragraph, { buffer = event.buf, desc = 'send paragraph' })
        vim.keymap.set('n', '<leader>rq', iron.close_repl, { buffer = event.buf, desc = 'close repl' })
        vim.keymap.set('n', '<leader>rR', iron.repl_restart, { buffer = event.buf, desc = 'restart repl' })
        vim.keymap.set('v', '<leader>rs', iron.visual_send, { buffer = event.buf, desc = 'send selection' })
    end,
})
