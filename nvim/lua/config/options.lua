-- :help options

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.tabstop = 4          -- Visual width of a tab character
vim.opt.softtabstop = 4      -- How much whitespace Tab key inserts
vim.opt.shiftwidth = 4       -- How much whitespace to use for indentation commands
vim.opt.expandtab = true     -- Replace tabs with spaces (CTRL-V<tab> to insert a real tab)

vim.opt.smartindent = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false   -- Disable folds by default, toggle with zi

vim.opt.list = true

vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.cursorline = true

-- Spelling (:help spell)
-- ]s moves to the next misspell, [s move to the previous misspell
-- z= shows suggestions, zg adds the word to the dictionary
vim.opt.spell = true
vim.opt.spelllang = "en_us,ru_yo"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "88"

vim.opt.updatetime = 100
