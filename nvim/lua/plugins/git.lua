return {
    {
        "lewis6991/gitsigns.nvim",
        enabled = function()
            return not string.find(vim.fn.expand("%:p"), "arcadia/")
        end,
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
}
