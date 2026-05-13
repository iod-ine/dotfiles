require('codecompanion').setup({
    interactions = {
        chat = {
            adapter = 'eliza_deepseek_internal',
        },
        cli = {
            agent = 'opencode',
            agents = {
                opencode = {
                    cmd = 'opencode',
                    args = {},
                    description = 'OpenCode CLI',
                },
            },
        },
        inline = {
            adapter = {
                name = 'eliza_anthropic',
                model = 'claude-sonnet-4-6',
            },
        },
    },
    adapters = {
        acp = {
            opencode = function()
                return require('codecompanion.adapters').extend('opencode', {
                    defaults = {
                        model = 'Eliza Anthropic/Claude Sonnet 4.5',
                    },
                })
            end
        },
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
vim.keymap.set({ 'n', 'v' }, '<Leader>cA', '<Cmd>CodeCompanionCLI Ask<CR>', { desc = 'start a new CLI agent' })
vim.keymap.set({ 'n', 'v' }, '<Leader>ca', '<Cmd>CodeCompanionActions<CR>', { desc = 'actions' })
vim.keymap.set({ 'n', 'v' }, '<Leader>cC', '<Cmd>CodeCompanionChat<CR>', { desc = 'start a new chat' })
vim.keymap.set({ 'n', 'v' }, '<Leader>cc', function() require('codecompanion').toggle() end, { desc = 'toggle chat' })
vim.keymap.set('v', 'ga', '<Cmd>CodeCompanionChat Add<CR>', { desc = 'paste to chat' })
