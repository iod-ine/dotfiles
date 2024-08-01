return {
    -- Debugger Adapter Protocol and its friends
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            {
                "mfussenegger/nvim-dap-python",
                ft = "python",
                config = function()
                    local dap = require("dap")
                    local dap_py = require("dap-python")
                    local which_key = require("which-key")
                    local debugger_opts = { config = { justMyCode = false } }

                    dap_py.setup("python")
                    dap_py.test_runner = "pytest"

                    for _, conf in ipairs(dap.configurations.python) do
                        conf["justMyCode"] = false
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
}
