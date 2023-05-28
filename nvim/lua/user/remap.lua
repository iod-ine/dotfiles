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

-- Window manipulation commands
vim.keymap.set("n", "<leader>ws", "<C-w>s")       -- window split horizontally
vim.keymap.set("n", "<leader>wv", "<C-w>v")       -- window split vertically
vim.keymap.set("n", "<leader>wc", vim.cmd.close)  -- window close current
vim.keymap.set("n", "<leader>wo", vim.cmd.only)   -- window keep only current
-- :help window-move-cursor
vim.keymap.set("n", "<leader>wh", "<C-w>h")       -- window select left
vim.keymap.set("n", "<leader>wj", "<C-w>j")       -- window select down
vim.keymap.set("n", "<leader>wk", "<C-w>k")       -- window select up
vim.keymap.set("n", "<leader>wl", "<C-w>l")       -- window select right
vim.keymap.set("n", "<leader>wn", "<C-w>w")       -- window select next (or <C-w><C-w>)

-- Tabpage manipulation commands
vim.keymap.set("n", "<leader>tt", vim.cmd.tabedit)      -- tabpage new
vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose)     -- tabpage close
vim.keymap.set("n", "<leader>to", vim.cmd.tabonly)      -- tabpage keep only current
-- {N}gt goes to next tab or tab number N
vim.keymap.set("n", "<leader>tl", vim.cmd.tabnext)      -- tabpage next
vim.keymap.set("n", "<leader>th", vim.cmd.tabprevious)  -- tabpage previous
