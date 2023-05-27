local colorscheme = "kanagawa-wave"

-- Load the colorscheme in a protected call to not fail if it is not installed
local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)

if not status_ok then
    vim.notify("Colorscheme " .. colorscheme .. " not found!")
    return
end

-- Make the background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
