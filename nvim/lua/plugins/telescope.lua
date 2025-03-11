return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
            {
                "nvim-tree/nvim-web-devicons",
                enabled = vim.g.have_nerd_font,
            },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            -- Clone the default Telescope configuration
            local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

            -- Enable search in hidden files
            table.insert(vimgrep_arguments, "--hidden")

            -- Disable search in .git/
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            require("telescope").setup({
                defaults = { vimgrep_arguments = vimgrep_arguments },
                pickers = {
                    find_files = {
                        find_command = {
                            "rg", "--files", "--hidden",
                            "--glob", "!**/.git/*",
                            "--glob", "!**/.venv/*",
                            "--glob", "!**/.ipynb_checkpoints/*",
                            "--glob", "!**/.DS_Store",
                            "--glob", "!**/venv",
                            "--glob", "!**/__pycache__",
                        },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")
        end
    },
}
