
require("CopilotChat").setup({
    model = 'gpt-4.1',
    -- providers = {
    --     my_provider = {
    --         get_url = function(opts) return "https://api.example.com/chat" end,
    --         get_headers = function() return { ["Authorization"] = "Bearer " .. api_key } end,
    --         get_models = function() return { { id = "gpt-4.1", name = "GPT-4.1 model" } } end,
    --         prepare_input = require('CopilotChat.config.providers').copilot.prepare_input,
    --         prepare_output = require('CopilotChat.config.providers').copilot.prepare_output,
    --     }
    -- },

    temperature = 0.1,
    window = {layout = 'vertical', width = 0.5},
    auto_insert_mode = true,
    debug = false,
})
vim.g.copilot_no_tab_map = true
