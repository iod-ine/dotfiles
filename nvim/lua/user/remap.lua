vim.g.mapleader = " "

-- Center the screen after scrolling with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

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
            name = "find/file",
            b = { "<cmd>Telescope file_browser<CR>", "file browser" },
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
        -- For tabs:
        -- :tabedit to open a new one, :tabclose to close the current,
        -- :tabonly to leave only the current, :tabfirst / :tablast
        -- {N}gt goes to next tab or tab number N, gT goes to previous
        t = {
            name = "toggle",
            w = { "<cmd>set wrap!<cr>", "wrap" },
        },
        q = { telescope.diagnostics, "diagnostics" },
        u = { vim.cmd.UndotreeToggle, "undo tree" },
    },
    {
        mode = "n",
        prefix = "<leader>",
    }
)

which_key.register(
    {
        ["["] = {
            d = { vim.diagnostic.goto_prev, "Previous diagnostic" },
        },
        ["]"] = {
            d = { vim.diagnostic.goto_next, "Next diagnostic" },
        },
    },
    {
        mode = "n",
        prefix = nil,
    }
)
