return {
    -- Debugger Adapter Protocol and its friends
    {
        "mfussenegger/nvim-dap",
        ft = { "python" },
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                opts = {},
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = { virt_text_pos = "eol" },
            },
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            local which_key = require("which-key")

            -- Define the keymaps inside an autocommand to make them buffer-local.
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "python" },
                desc = "Set up DAP keybindings",
                group = vim.api.nvim_create_augroup("dap-bindings", { clear = true }),
                callback = function(event)
                    which_key.add({
                        buffer = event.buf,
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

                        { "<leader>d", group = "debug", mode = { "n", "v" } },

                        { "<leader>dq", dap.terminate, desc = "terminate session" },
                        { "<leader>dR", dap.restart, desc = "restart session" },
                        { "<M-d>", dap.down, desc = "down stacktrace" },
                        { "<M-u>", dap.up, desc = "up stacktrace" },

                        {
                            "<leader>db",
                            function() ui.float_element("breakpoints", { enter = true, title = "DAP Breakpoints" }) end,
                            desc = "float breakpoints",
                        },
                        {
                            "<leader>dc",
                            function() ui.float_element("console", { enter = true, title = "DAP Console" }) end,
                            desc = "float console",
                        },
                        {
                            "<leader>dr",
                            function() ui.float_element("repl", { enter = true, title = "DAP REPL" }) end,
                            desc = "float REPL",
                        },
                        {
                            "<leader>ds",
                            function() ui.float_element("scopes", { enter = true, title = "DAP Scopes" }) end,
                            desc = "float scopes",
                        },
                        {
                            "<leader>dS",
                            function() ui.float_element("stacks", { enter = true, title = "DAP Stacks" }) end,
                            desc = "float stacks",
                        },
                        { "<leader>du", ui.toggle, desc = "toggle UI" },
                        {
                            "<leader>dw",
                            function() ui.float_element("watches", { enter = true, title = "DAP Watches" }) end,
                            desc = "float watches",
                        },
                        { "<M-e>", ui.eval, desc = "eval", mode = { "n", "v" } },
                        { "<leader>dv", "<cmd>DapVirtualTextToggle<cr>", desc = "toggle virtual text" },
                    })
                end,
            })
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = { "python" },
        config = function()
            local dap = require("dap")
            local dap_py = require("dap-python")

            dap_py.setup("uv")
            dap_py.test_runner = "pytest"

            local cwd = vim.fn.getcwd()

            for _, conf in ipairs(dap.configurations.python) do
                conf["justMyCode"] = false
                conf["cwd"] = cwd
                conf["env"] = { PYTHONPATH = cwd }
            end

            -- Define the keymaps inside an autocommand to make them buffer-local.
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "python" },
                desc = "Set up DAP Python keybindings",
                group = vim.api.nvim_create_augroup("dap-python-bindings", { clear = true }),
                callback = function(event)
                    local debugger_opts = { config = { justMyCode = false } }
                    require("which-key").add({
                        buffer = event.buf,
                        { "<leader>dl", function() dap_py.class(debugger_opts) end, desc = "test class" },
                        { "<leader>dm", function() dap_py.test_method(debugger_opts) end, desc = "test method" },
                    })
                end,
            })
        end,
    },
}
