return {
    "olimorris/codecompanion.nvim",
    opts = {
        strategies = {
            chat = {
                adapter = "ollama",
                model = "qwen3:8b",
            },
        },
        adapters = {
            http = {
                eliza_anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        url = "https://api.eliza.yandex.net/raw/anthropic/v1/messages",
                        env = {
                            api_key = "cmd:cat ~/.local/tokens/eliza",
                        },
                    })
                end,
                eliza_deepseek = function()
                    return require("codecompanion.adapters").extend("deepseek", {
                        url = "https://api.eliza.yandex.net/openrouter/v1/chat/completions",
                        env = {
                            api_key = "cmd:cat ~/.local/tokens/eliza",
                        },
                        schema = {
                            model = {
                                default = "deepseek-reasoner",
                                choices = {
                                    ["deepseek-reasoner"] = { opts = { can_use_tools = true } },
                                },
                            },
                        },
                    })
                end,
                eliza_deepseek_internal = function()
                    return require("codecompanion.adapters").extend("deepseek", {
                        url = "https://api.eliza.yandex.net/internal/deepseek-v3-1-terminus/v1/chat/completions",
                        env = {
                            api_key = "cmd:cat ~/.local/tokens/eliza",
                        },
                        schema = {
                            model = {
                                default = "deepseek-reasoner",
                                choices = {
                                    ["deepseek-reasoner"] = { opts = { can_use_tools = true } },
                                },
                            },
                        },
                    })
                end,
                yalm_deepseek_r1 = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        env = {
                            url = "http://zeliboba.yandex-team.ru/balance/deepseek_r1",
                            api_key = "cmd:cat ~/.local/tokens/yalm",
                            chat_url = "/v1/chat/completions",
                        },
                        schema = {
                            model = {
                                default = "deepseek",
                            },
                        },
                    })
                end,
                yalm_deepseek_v3 = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        env = {
                            url = "http://zeliboba.yandex-team.ru/balance/communal-deepseek-v3-0324-in-yt",
                            api_key = "cmd:cat ~/.local/tokens/yalm",
                            chat_url = "/v1/chat/completions",
                        },
                        schema = {
                            model = {
                                default = "deepseek",
                            },
                        }
                    })
                end,
            },
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}
