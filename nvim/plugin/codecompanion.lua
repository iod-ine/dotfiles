require('codecompanion').setup({
    interactions = {
        chat = {
            adapter = { name = 'eliza', model = 'moonshotai/kimi-k3' },
            roles = {
                llm = function(adapter)
                    return string.format(
                        "CodeCompanion (%s — %s)",
                        adapter.formatted_name,
                        adapter.model.formatted_name or "default"
                    )
                end,
                user = "Me",
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
        inline = { adapter = { name = 'eliza' } },
    },
    adapters = {
        acp = {
            opts = { show_presets = false },
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
            opts = { show_presets = false },
            eliza = function()
                return require('codecompanion.adapters').extend('openrouter', {
                    url = 'https://api.eliza.yandex.net/raw/openrouter/v1/chat/completions',
                    env = { api_key = 'cmd:cat ~/.local/tokens/eliza' },
                    schema = {
                        model = {
                            default = 'moonshotai/kimi-k3',
                            choices = {
                                ['deepseek/deepseek-v4-flash'] = { formatted_name = 'DeepSeek V4 Flash' },
                                ['deepseek/deepseek-v4-pro'] = { formatted_name = 'DeepSeek V4 Pro' },
                                ['moonshotai/kimi-k3'] = { formatted_name = 'Kimi K3' },
                                ['qwen/qwen3.5-397b-a17b'] = { formatted_name = 'Qwen3.5 397B' },
                                ['z-ai/glm-5.2'] = { formatted_name = 'GLM 5.2' },
                            },
                        },
                    },
                    formatted_name = 'Eliza',
                })
            end,
            eliza_internal_fast = function()
                return require('codecompanion.adapters').extend('openrouter', {
                    url = 'https://api.eliza.yandex.net/internal/fast/v1/chat/completions',
                    env = { api_key = 'cmd:cat ~/.local/tokens/eliza' },
                    schema = { model = { default = '', choices = {} } },
                    formatted_name = 'Eliza Internal Fast',
                })
            end,
            eliza_internal_smart = function()
                return require('codecompanion.adapters').extend('openrouter', {
                    url = 'https://api.eliza.yandex.net/internal/smart/v1/chat/completions',
                    env = { api_key = 'cmd:cat ~/.local/tokens/eliza' },
                    schema = { model = { default = '', choices = {} } },
                    formatted_name = 'Eliza Internal Smart',
                })
            end,
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
