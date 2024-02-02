vim.g.mapleader = " "

-- Center the screen after scrolling with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Cycle through LSP diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

local which_key = require("which-key")
local telescope = require("telescope.builtin")

which_key.register(
    {
        b = {
            name = "buffer",
            b = { telescope.buffers, "find buffer" },
            d = { vim.cmd.bdelete, "delete buffer" },
            n = { vim.cmd.bnext, "next buffer" },
            p = { vim.cmd.bprevious, "previous buffer" },
        },
        e = { vim.diagnostic.open_float, "expand diagnostic" },
        f = {
            name = "find",
            e = { vim.cmd.Ex, "file explorer" },
            f = { telescope.find_files, "find file" },
            l = { telescope.live_grep, "live grep" },
            r = { telescope.oldfiles, "recent files" },
            s = { telescope.grep_string, "grep string" },
        },
        g = {
            name = "git",
            l = { telescope.git_commits, "git log" },
            b = { telescope.git_commits, "buffer commits" },
        },
        h = {
            name = "help",
            h = { telescope.help_tags, "help tags" },
        },
        t = {
            name = "tab",
            c = { vim.cmd.tabclose, "close tab" },
            e = { vim.cmd.tabedit, "new tab" },
            -- {N}gt goes to next tab or tab number N, gT goes to previous
            f = { vim.cmd.tabfirst, "go to first" },
            l = { vim.cmd.tablast, "go to last" },
            o = { vim.cmd.tabonly, "keep only this" },
        },
        q = { telescope.diagnostics, "diagnostics" },
        u = { vim.cmd.UndotreeToggle, "undo tree" },
        w = { "<cmd>set wrap!<cr>", "toggle wrap" },
    },
    {
        mode = "n",
        prefix = "<leader>",
    }
)
