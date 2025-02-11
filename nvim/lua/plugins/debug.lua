return {
    -- Debugger Adapter Protocol and its friends
    {
        "mfussenegger/nvim-dap",
        ft = { "python" },
        dependencies = {
            {
                "mfussenegger/nvim-dap-python",
                config = function()
                    local dap = require("dap")
                    local dap_py = require("dap-python")
                    local which_key = require("which-key")
                    local debugger_opts = { config = { justMyCode = false } }

                    dap_py.setup("uv")
                    dap_py.test_runner = "pytest"

                    local cwd = vim.fn.getcwd()

                    for _, conf in ipairs(dap.configurations.python) do
                        conf["justMyCode"] = false
                        conf["cwd"] = cwd
                        conf["env"] = { PYTHONPATH = cwd }
                    end

                    which_key.add(
                        {
                            { "<leader>dl", function() dap_py.class(debugger_opts) end, desc = "test class" },
                            { "<leader>dm", function() dap_py.test_method(debugger_opts) end, desc = "test method" },
                        }
                    )
                end,
            },
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                opts = {},
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                config = function()
                    local dap_virtual_text = require("nvim-dap-virtual-text")
                    local which_key = require("which-key")

                    dap_virtual_text.setup({
                        virt_text_pos = "eol",
                    })

                    which_key.add({
                        { "<leader>dv", "<cmd>DapVirtualTextToggle<cr>", desc = "toggle virtual text" },
                    })
                end
            },
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            local which_key = require("which-key")

            -- NOTE: How do I make these buffer-local?
            -- TODO: Move these into an autocommand
            which_key.add(
                {
                    { "<F1>", dap.continue, desc = "continue" },
                    { "<F2>", dap.step_into, desc = "step into" },
                    { "<F3>", dap.step_over, desc = "step over" },
                    { "<F4>", dap.step_out, desc = "step out" },
                    { "<F5>", dap.step_back, desc = "step back" },
                    { "<C-b>", dap.toggle_breakpoint, desc = "toggle breakpoint" },
                    {
                        "g<C-b>",
                        function()
                            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
                        end,
                        desc = "toggle breakpoint",
                    },

                    { "<leader>d", group = "debug" },
                    { "<leader>dc", dap.repl.toggle, desc = "toggle console" },
                    { "<leader>dd", dap.down, desc = "down stacktrace" },
                    { "<leader>dq", dap.terminate, desc = "terminate session" },
                    { "<leader>dr", dap.restart, desc = "restart session" },
                    { "<leader>du", dap.up, desc = "up stacktrace" },
                }
            )

            dap.listeners.before.attach.dapui = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui = function()
                ui.close()
            end
        end
    },
    -- REPLs
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
                    },
                    ignore_blank_lines = true,
                    repl_open_cmd = require("iron.view").split.vertical.botright(80)
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
