-- Center the screen after scrolling with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

local which_key = require("which-key")
local telescope = require("telescope.builtin")

which_key.add(
    {
        { "<leader>b", group = "buffer" },
        { "<leader>bb", telescope.buffers, desc = "find buffer" },
        { "<leader>bd", vim.cmd.bdelete, desc = "delete buffer" },

        { "<leader>f", group = "find/file" },
        { "-", "<cmd>Oil<cr>", desc = "file browser" },
        { "<leader>ff", telescope.find_files, desc = "file file" },
        { "<leader>fl", telescope.live_grep, desc = "live grep" },
        { "<leader>fr", telescope.oldfiles, desc = "recent files" },
        { "<leader>fs", telescope.grep_string, desc = "grep string" },
        { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "find TODOs" },

        { "<leader>g", group = "git" },
        { "<leader>gl", telescope.git_bcommits, desc = "buffer commits" },
        { "<leader>gL", telescope.git_commits, desc = "git log" },

        { "<leader>h", group = "help" },
        { "<leader>hc", telescope.commands, desc = "commands" },
        { "<leader>hh", telescope.help_tags, desc = "help tags" },
        { "<leader>hk", telescope.keymaps, desc = "keymaps" },
        { "<leader>hl", telescope.command_history, desc = "command history" },
        { "<leader>ho", telescope.vim_options, desc = "options" },
        { "<leader>hs", telescope.search_history, desc = "search history" },

        -- For tabs:
        -- :tabedit to open a new one, :tabclose to close the current,
        -- :tabonly to leave only the current, :tabfirst / :tablast
        -- {N}gt goes to next tab or tab number N, gT goes to previous

        { "<leader>t", group = "toggle" },
        { "<leader>tc", "<cmd>TSContextToggle<cr>", desc = "context" },
        { "<leader>tw", "<cmd>set wrap!<cr>", desc = "wrap" },
        {
            "<leader>tD",
            function()
                if vim.g.colors_name == "catppuccin-macchiato" then
                    vim.cmd.colorscheme("catppuccin-latte")
                else
                    vim.cmd.colorscheme("catppuccin-macchiato")
                end
            end,
            desc = "dark theme",
        },

        { "<leader>q", telescope.diagnostics, desc = "diagnostics" },
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "undo tree" },
        { "<leader>p", "\"*p", desc = "paste from clipboard" },
        { "<leader>y", "\"*y", desc = "yank to clipboard", mode = { "n", "v" } },
        { "<leader>x", "\"*x", desc = "cut to clipboard", mode = { "n", "v" } },
        { "<leader>/", telescope.current_buffer_fuzzy_find, desc = "fuzzy find" },
    }
)

-- Add local mappings to buffers when LSP is attached
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-mappings", { clear = true }),
    callback = function(event)
        -- A helper wrapper for printing buffers in the workspace
        local list_workspace_folders = function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end

        -- Mappings for normal mode without the leader
        which_key.add(
            {
                {
                    buffer = event.buf,

                    { "gd", vim.lsp.buf.definition, desc = "go to definition" },
                    { "gD", vim.lsp.buf.declaration, desc = "go to declaration" },
                    { "grR", telescope.lsp_references, desc = "LSP references" },

                    { "<leader>bf", vim.lsp.buf.format, desc = "format code" },
                    { "<leader>bs", telescope.lsp_document_symbols, desc = "buffer symbols" },
                    { "<leader>D", vim.lsp.buf.type_definition, desc = "type definition" },

                    {
                        "<leader>tq",
                        function()
                            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                        end,
                        desc = "diagnostics",
                    },

                    { "<leader>w", group = "workspace" },
                    { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "add workspace folder" },
                    { "<leader>wl", list_workspace_folders, desc = "list workspace folders" },
                    { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "remove workspace folder" },
                    { "<leader>ws", telescope.lsp_workspace_symbols, desc = "symbols" },
                }
            }
        )
    end,
})
