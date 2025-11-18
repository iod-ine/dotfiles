return {
    "olimorris/codecompanion.nvim",
    opts = {
        strategies = {
            chat = {
                adapter = "ollama",
                model = "qwen3:8b",
            },
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}
