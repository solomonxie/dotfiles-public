local dap = require('dap')
-- vim.keymap.set('n', '<leader>db', require"dap".toggle_breakpoint, { noremap = true })
-- vim.keymap.set('n', '<leader>dc', require"dap".continue, { noremap = true })
-- vim.keymap.set('n', '<leader>do', require"dap".step_over, { noremap = true })
-- vim.keymap.set('n', '<leader>di', require"dap".step_into, { noremap = true })
-- vim.keymap.set('n', '<leader>dl', function()
--   require"osv".launch({port = 8086})
-- end, { noremap = true })
-- vim.keymap.set('n', '<leader>dw', function()
--   local widgets = require"dap.ui.widgets"
--   widgets.hover()
-- end)
-- vim.keymap.set('n', '<leader>df', function()
--   local widgets = require"dap.ui.widgets"
--   widgets.centered_float(widgets.frames)
-- end)

-- <one-small-step-for-vimkind>
dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
    }
}
dap.adapters.nlua = function(callback, config)
    local a = 1
    local b = {a=1, b=2}
    callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
end

-- <nvim-dap-ui>
local dapui = require('dapui')
dapui.setup({})
-- Use nvim-dap events to open and close the UI windows automatically (:help dap-extensions)
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- <nvim-dap-virtual-text>
require('nvim-dap-virtual-text').setup({})
