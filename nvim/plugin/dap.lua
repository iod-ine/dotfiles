local dap = require('dap')
local py = require('dap-python')
local ui = require('dapui')
local virtualtext = require('nvim-dap-virtual-text')

py.setup('uv')
ui.setup()
virtualtext.setup({ virt_text_pos = 'eol' })

vim.keymap.set('n', '<F1>', dap.continue, { desc = 'continue' })
vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'step into' })
vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'step_over' })
vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'step out' })
vim.keymap.set('n', '<F5>', dap.step_back, { desc = 'step back' })

local function set_conditional_breakpoint()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end

vim.keymap.set('n', '<C-b>', dap.toggle_breakpoint, { desc = 'toggle breakpoint' })
vim.keymap.set('n', 'g<C-b>', set_conditional_breakpoint, { desc = 'toggle breakpoint' })
vim.keymap.set('n', '<M-d>', dap.down, { desc = 'down stacktrace' })
vim.keymap.set('n', '<M-u>', dap.up, { desc = 'up stacktrace' })

vim.keymap.set('n', '<Leader>dR', dap.restart, { desc = 'restart session' })
vim.keymap.set('n', '<Leader>dQ', dap.terminate, { desc = 'terminate session' })

local function make_float_callback(element, title)
    return function() ui.float_element(element, { enter = true, title = title }) end
end

vim.keymap.set('n', '<Leader>db', make_float_callback('breakpoints', 'DAP Breakpoints'), { desc = 'float breakpoints' })
vim.keymap.set('n', '<Leader>dc', make_float_callback('console', 'DAP Console'), { desc = 'float console' })
vim.keymap.set('n', '<Leader>dr', make_float_callback('repl', 'DAP REPL'), { desc = 'float REPL' })
vim.keymap.set('n', '<Leader>ds', make_float_callback('scopes', 'DAP Scopres'), { desc = 'float scopes' })
vim.keymap.set('n', '<Leader>dS', make_float_callback('stacks', 'DAP Stacks'), { desc = 'float stacks' })
vim.keymap.set('n', '<Leader>dw', make_float_callback('watches', 'DAP Watches'), { desc = 'float watches' })

vim.keymap.set('n', '<Leader>du', ui.toggle, { desc = 'toggle UI' })
vim.keymap.set({ 'n', 'v'}, '<M-e>', ui.eval, { desc = 'eval' })
