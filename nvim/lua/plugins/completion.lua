return {
    -- Formatting for the completion window
    {
        "onsails/lspkind.nvim",
        config = function()
            require("lspkind").init({
                mode = "text_symbol",
                preset = "default",
            })
        end
    }
}
