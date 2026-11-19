require('minuet').setup({
    virtualtext = {
        auto_trigger_ft = {},
        keymap = {
            accept = '<A-A>',
            accept_line = '<A-a>',
            accept_n_lines = '<A-z>',
            prev = '<A-[>',
            next = '<A-]>',
            dismiss = '<A-e>',
        },
    },
    provider = 'openai_compatible',
    request_timeout = 2.5,
    throttle = 1500,
    debounce = 600,
    provider_options = {
        openai_compatible = {
            model = 'moonshotai/kimi-k3',
            api_key = 'ELIZA_API_KEY',
            end_point = 'https://api.eliza.yandex.net/raw/openrouter/v1/chat/completions',
            optional = {
                max_tokens = 256,
                reasoning_effort = 'none',
            },
        },
    },
})
