return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        tag = "v0.2.1",
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
                defaults = { 
                    file_ignore_patterns = {
                        ".git/",
                        ".ipynb_checkpoints/",
                        ".venv/",
                        "venv/",
                        "__pycache__/",
                        ".DS_Store",
                    },
                    vimgrep_arguments = vimgrep_arguments,
                },
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden" },
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
