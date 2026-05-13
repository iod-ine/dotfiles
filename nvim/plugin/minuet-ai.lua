require('minuet').setup {
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
    provider = 'claude',
    request_timeout = 2.5,
    throttle = 1500,
    debounce = 600,
    provider_options = {
        claude = {
            max_tokens = 256,
            model = 'claude-haiku-4-5',
            stream = true,
            api_key = 'ELIZA_API_KEY',
            end_point = 'https://api.eliza.yandex.net/raw/anthropic/v1/messages',
        },
    },
}
