return {
    -- Debugger Adapter Protocol and its friends
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "mfussenegger/nvim-dap-python",
                config = function()
                    require("dap-python").setup("python")
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
    },

}
