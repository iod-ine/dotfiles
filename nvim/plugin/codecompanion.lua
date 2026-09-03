require('codecompanion').setup({
    interactions = {
        chat = {
            adapter = {
                name = 'eliza_anthropic',
                model = 'claude-sonnet-4-6',
            },
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
                        model = 'Eliza Anthropic/Claude Sonnet 4.6',
                    },
                })
            end,
            codex = function()
                return require("codecompanion.adapters").extend("codex", {
                    defaults = { auth_method = "chat-gpt" },
                })
            end,
        },
        http = {
            eliza_anthropic = function()
                return require('codecompanion.adapters').extend('anthropic', {
                    url = 'https://api.eliza.yandex.net/raw/anthropic/v1/messages',
                    env = {
                        api_key = 'cmd:cat ~/.local/tokens/eliza',
                    },
                    schema = {
                        model = {
                            default = 'claude-sonnet-4-6',
                            choices = {
                                'claude-opus-5',
                                'claude-opus-4-8',
                                'claude-opus-4-7',
                                'claude-opus-4-6',
                                'claude-opus-4-5',
                                'claude-sonnet-5',
                                'claude-sonnet-4-6',
                                'claude-sonnet-4-5',
                                'claude-haiku-4-5',
                            },
                        },
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
    mcp = {
        servers = {
            ['arcanum-mcp'] = {
                cmd = { 'arcanum-mcp', '--arcadia', '~/arcadia' },
                env = {
                    ARC_TOKEN_PATH = '/home/ivandubrovin/.arc/token',
                },
            },
            intrasearch = {
                cmd = { 'ya', 'tool', 'mcp', 'connect', 'mcp.yandex.net/ws?servers=intrasearch' },
            },
        },
    },
    display = {
        chat = {
            window = {
                layout = 'vertical',
                position = 'right',
                width = 0.4,
            },
            auto_scroll = true,
        },
    },
})

-- Toggle
vim.keymap.set({ 'n', 'v' }, '<Leader>cA', '<Cmd>CodeCompanionCLI<CR>', { desc = 'start a new CLI agent' })
vim.keymap.set({ 'n', 'v' }, '<Leader>ca', '<Cmd>CodeCompanionActions<CR>', { desc = 'actions' })
vim.keymap.set({ 'n', 'v' }, '<Leader>cC', '<Cmd>CodeCompanionChat<CR>', { desc = 'start a new chat' })
vim.keymap.set({ 'n', 'v' }, '<Leader>cc', function() require('codecompanion').toggle() end, { desc = 'toggle chat' })
vim.keymap.set('v', 'ga', '<Cmd>CodeCompanionChat Add<CR>', { desc = 'paste to chat' })
