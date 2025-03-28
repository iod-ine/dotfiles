local capabilities = require("blink.cmp").get_lsp_capabilities()


return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    capabilities = capabilities,
}
