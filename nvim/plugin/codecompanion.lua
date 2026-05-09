vim.pack.add({ 'https://www.github.com/nvim-lua/plenary.nvim' })
vim.pack.add({ { src = 'https://www.github.com/olimorris/codecompanion.nvim', version = vim.version.range('^19.0.0') } })

require('codecompanion').setup({
    strategies = {
        chat = {
            adapter = 'eliza_deepseek_internal',
        },
    },
    adapters = {
        http = {
            eliza_anthropic = function()
                return require('codecompanion.adapters').extend('anthropic', {
                    url = 'https://api.eliza.yandex.net/raw/anthropic/v1/messages',
                    env = {
                        api_key = 'cmd:cat ~/.local/tokens/eliza',
                    },
                })
            end,
            eliza_deepseek = function()
                return require('codecompanion.adapters').extend('deepseek', {
                    url = 'https://api.eliza.yandex.net/openrouter/v1/chat/completions',
                    env = {
                        api_key = 'cmd:cat ~/.local/tokens/eliza',
                    },
                    schema = {
                        model = {
                            default = 'deepseek-reasoner',
                        },
                    },
                })
            end,
            eliza_deepseek_internal = function()
                return require('codecompanion.adapters').extend('deepseek', {
                    url = 'https://api.eliza.yandex.net/internal/deepseek-v3-1-terminus/v1/chat/completions',
                    env = {
                        api_key = 'cmd:cat ~/.local/tokens/eliza',
                    },
                    schema = {
                        model = {
                            default = 'deepseek-reasoner',
                        },
                        reasoning_effort = 'medium',
                    },
                })
            end,
            eliza_mistral = function()
                return require('codecompanion.adapters').extend('mistral', {
                    url = 'https://api.eliza.yandex.net/mistral/v1/chat/completions',
                    env = {
                        api_key = 'cmd:cat ~/.local/tokens/eliza',
                    },
                    model = 'mistral-large-latest',
                })
            end
        },
    },
    display = {
        chat = {
            window = {
                layout = 'vertical',
                position = 'right',
                width = 0.4,
            },
            auto_scroll = false,
        },
    },
})

-- Toggle
vim.keymap.set('n', '<Leader>tc', '<Cmd>CodeCompanionChat toggle<CR>', { desc = 'working directory' })
