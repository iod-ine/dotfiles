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
                    local dap_py = require("dap-python")
                    local which_key = require("which-key")
                    local debugger_options = { config = { justMyCode = false } }

                    dap_py.setup("python")

                    which_key.register(
                        {
                            d = {
                                name = "debug",
                                l = { function() dap_py.class(debugger_options) end, "test class" },
                                m = { function() dap_py.test_method(debugger_options) end, "test method" },
                            },
                        },
                        {
                            mode = "n",
                            prefix = "<leader>",
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
                opts = {},
            },
        },
        config = function()
            local dap = require("dap")
            local which_key = require("which-key")

            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
            vim.keymap.set("n", "<F3>", dap.step_over)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.step_back)

            which_key.register(
                {
                    ["<C-b>"] = { dap.toggle_breakpoint, "toggle breakpoint" },
                    ["g<C-b>"] = {
                        function()
                            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
                        end,
                        "conditional breakpoint",
                    },
                },
                {
                    mode = "n",
                    prefix = nil,
                }
            )

            which_key.register(
                {
                    d = {
                        name = "debug",
                        c = { dap.repl.toggle, "toggle console" },
                        d = { dap.down, "down staktrace" },
                        q = { dap.terminate, "terminate session" },
                        r = { dap.restart, "restart session" },
                        u = { dap.up, "up staktrace" },
                    },
                },
                {
                    mode = "n",
                    prefix = "<leader>",
                }
            )
        end
    },
}
