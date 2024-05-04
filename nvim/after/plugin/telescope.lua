local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- Enable search in hidden files
table.insert(vimgrep_arguments, "--hidden")

-- Disable search in .git/
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
    defaults = { vimgrep_arguments = vimgrep_arguments },
    pickers = {
        find_files = {
            find_command = {
                "rg", "--files", "--hidden",
                "--glob", "!**/.git/*",
                "--glob", "!**/.DS_Store",
            },
        },
    },
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
