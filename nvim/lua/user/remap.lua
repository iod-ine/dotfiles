vim.g.mapleader = " "

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)  -- file explorer

-- Center the screen after scrolling with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
