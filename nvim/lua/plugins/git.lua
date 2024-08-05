return {
    {
        "lewis6991/gitsigns.nvim",
        cond = function()
            return not string.find(vim.fn.getcwd(), "arcadia")
        end,
        config = function()
            local which_key = require("which-key")
            local gitsigns = require("gitsigns")

            gitsigns.setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            })

            which_key.add({
                { "<leader>gp", gitsigns.preview_hunk, desc = "preview hunk" },
                { "<leader>gr", gitsigns.reset_hunk, desc = "reset hunk" },
                { "<leader>gR", gitsigns.reset_buffer, desc = "reset buffer" },
                { "<leader>gs", gitsigns.stage_hunk, desc = "stage hunk" },
                { "<leader>gS", gitsigns.stage_buffer, desc = "stage buffer" },
                { "<leader>gu", gitsigns.undo_stage_hunk, desc = "undo stage" },
                { "<leader>gb", gitsigns.blame_line, desc = "blame line" },
                { "<leader>gB", gitsigns.blame, desc = "blame" },
                { "<leader>tb", gitsigns.toggle_current_line_blame, desc = "line blame" },
                { "<leader>td", gitsigns.toggle_deleted, desc = "show deleted" },
            })
        end
    },
}
