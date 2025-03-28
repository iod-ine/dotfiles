local capabilities = require("blink.cmp").get_lsp_capabilities()

return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
            format = {
                defaultConfig = {
                    align_continuous_rect_table_field = false,
                },
            },
        }
    },
    capabilities = capabilities,
}
