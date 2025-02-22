return {
    {
        "Vigemus/iron.nvim",
        ft = { "python", "lua" },
        config = function()
            local iron = require("iron.core")

            iron.setup({
                config = {
                    scratch_repl = true,
                    repl_definition = {
                        python = {
                            command = { "ipython", "--no-autoindent", "--no-confirm-exit" },
                            format = require("iron.fts.common").bracketed_paste_python,
                        },
                        lua = {
                            command = { "lua" },
                        },
                        ros = {
                            command = function(meta)
                                return {
                                    "docker",
                                    "exec",
                                    "--interactive",
                                    "--tty",
                                    "--workdir=" .. vim.fn.getcwd(),
                                    "--env-file=/mnt/storage/home/ivandubrovin/internal_docker_env",
                                    "ivandubrovin-image-239b9145",
                                    "python3",
                                }
                            end,
                            format = require("iron.fts.common").bracketed_paste_python,
                    },
                    },
                    ignore_blank_lines = true,
                    repl_open_cmd = require("iron.view").split.vertical.botright(80),
                },
            })

            -- Define the keymaps inside an autocommand to make them buffer-local.
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "python", "lua" },
                desc = "Set up Iron REPL keybindings",
                group = vim.api.nvim_create_augroup("iron-repl-bindings", { clear = true }),
                callback = function(event)
                    -- :h iron-commands
                    -- :h iron-functions
                    -- REPL is run in the TERMINAL mode. To exit to normal mode: <C-\><C-n>
                    -- Any configured REPL can be created by :IronRepl ft or :IronReplHere ft
                    -- and then forcefully attached to the current buffer by :IronAttach ft.
                    require("which-key").add({
                        buffer = event.buf,
                        { "<leader>e", group = "repl", mode = { "n", "v" } },
                        { "<leader>ec", iron.send_until_cursor, desc = "send until cursor" },
                        { "<leader>ee", "<cmd>IronRepl<cr>", desc = "open repl" },
                        { "<leader>ef", "<cmd>IronFocus<cr>", desc = "focus repl" },
                        { "<leader>eF", iron.send_file, desc = "send file" },
                        { "<leader>eh", "<cmd>IronHide<cr>", desc = "hide repl" },
                        { "<leader>el", iron.send_line, desc = "send line" },
                        { "<leader>ep", iron.send_paragraph, desc = "send paragraph" },
                        { "<leader>eq", iron.close_repl, desc = "close repl" },
                        { "<leader>es", iron.visual_send, desc = "send selection", mode = "v" },
                    })
                end,
            })
        end,
    },
}
