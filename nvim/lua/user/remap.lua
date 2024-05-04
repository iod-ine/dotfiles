vim.g.mapleader = " "

-- Center the screen after scrolling with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

local which_key = require("which-key")
local telescope = require("telescope.builtin")

which_key.register(
    {
        b = {
            name = "buffer",
            b = { telescope.buffers, "find buffer" },
            d = { vim.cmd.bdelete, "delete buffer" },
            n = { vim.cmd.bnext, "next buffer" },
            p = { vim.cmd.bprevious, "previous buffer" },
        },
        e = { vim.diagnostic.open_float, "expand diagnostic" },
        f = {
            name = "find/file",
            b = { "<cmd>Telescope file_browser<CR>", "file browser" },
            e = { vim.cmd.Ex, "file explorer" },
            f = { telescope.find_files, "find file" },
            l = { telescope.live_grep, "live grep" },
            r = { telescope.oldfiles, "recent files" },
            s = { telescope.grep_string, "grep string" },
        },
        g = {
            name = "git",
            l = { telescope.git_commits, "git log" },
            b = { telescope.git_commits, "buffer commits" },
        },
        h = {
            name = "help",
            h = { telescope.help_tags, "help tags" },
        },
        -- For tabs:
        -- :tabedit to open a new one, :tabclose to close the current,
        -- :tabonly to leave only the current, :tabfirst / :tablast
        -- {N}gt goes to next tab or tab number N, gT goes to previous
        t = {
            name = "toggle",
            w = { "<cmd>set wrap!<cr>", "wrap" },
        },
        q = { telescope.diagnostics, "diagnostics" },
        u = { vim.cmd.UndotreeToggle, "undo tree" },
    },
    {
        mode = "n",
        prefix = "<leader>",
    }
)

which_key.register(
    {
        ["["] = {
            d = { vim.diagnostic.goto_prev, "Previous diagnostic" },
        },
        ["]"] = {
            d = { vim.diagnostic.goto_next, "Next diagnostic" },
        },
    },
    {
        mode = "n",
        prefix = nil,
    }
)

-- Add local mappings to buffers when LSP is attached
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- A helper wrapper for printing buffers in the workspace
        local list_workspace_folders = function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end

        -- Mappings for normal mode without the leader
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        which_key.register(
            {
                g = {
                    d = { vim.lsp.buf.definition, "go to definition" },
                    D = { vim.lsp.buf.declaration, "go to declaration" },
                    r = { telescope.lsp_references, "references" },
                },
                K = { vim.lsp.buf.hover, "hover" },
            },
            {
                mode = "n",
                buffer = ev.buf,
                prefix = nil,
            }
        )

        -- Mappings for normal mode with the leader
        which_key.register(
            {
                b = {
                    name = "buffer",
                    f = { vim.lsp.buf.format, "format code" },
                },
                d = {
                    name = "document",
                    s = { telescope.lsp_document_symbols, "symbols" },
                },
                D = { vim.lsp.buf.type_definition, "go to type definition" },
                r = { vim.lsp.buf.rename, "rename symbol" },
                w = {
                    name = "workspace",
                    a = { vim.lsp.buf.add_workspace_folder, "add workspace folder" },
                    r = { vim.lsp.buf.remove_workspace_folder, "remove workspace folder" },
                    l = { list_workspace_folders, "list workspace folders" },
                },
            },
            {
                mode = "n",
                buffer = ev.buf,
                prefix = "<leader>",
            }
        )

        -- Mappings for both normal and visual modes with the leader
        which_key.register(
            { a = { vim.lsp.buf.code_action, "code action" } },
            {
                mode = { "n", "v" },
                buffer = ev.buf,
                prefix = "<leader>",
            }
        )
    end,
})
