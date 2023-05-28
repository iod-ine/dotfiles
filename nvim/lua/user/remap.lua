vim.g.mapleader = " "

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)  -- file explorer

-- Center the screen after scrolling with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffer manipulation commands
vim.keymap.set("n", "<leader>bl", vim.cmd.ls)         -- buffer list
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)      -- buffer next
vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious)  -- buffer previus
vim.keymap.set("n", "<leader>bc", vim.cmd.bdelete)    -- buffer close
