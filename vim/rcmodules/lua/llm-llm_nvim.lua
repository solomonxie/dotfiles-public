-- Setup:
--   $ vim ~/.global.env then add `LLM_KEY=<YOUR_API_KEY>`
--   $ vim ~/.vimrc-local.vim then add `lua vim.env.OPENAI_API_KEY = "sk-xxxx"`

require('llm').setup({
    prompt = 'You are a professional programmer.',

    ------------------- set your model parameters -------------------
    -- You can choose to configure multiple models as needed.
    -----------------------------------------------------------------

    --- style1: set single model parameters
    url = 'https://api.openai.com/v1/chat/completions',
    model = 'gpt-4o-mini',
    api_type = 'openai',

    -- style2: set parameters of multiple models
    -- (If you need to use multiple models and frequently switch between them.)
    models = {
        {
            name = 'ChatGPT',
            url = 'https://api.openai.com/v1/chat/completions',
            model = 'gpt-4o-mini',
            api_type = 'openai',
            fetch_key = function()
                return vim.env.OPENAI_API_KEY
            end,
        },
        {
            name = 'Gemini',
            url = 'https://gemini.googleapis.com/v1/ai:chat',
            model = 'glm-4-flash',
            api_type = 'zhipu',
            max_tokens = 8000,
            fetch_key = function()
                return vim.env.GEMINI_API_KEY
            end,
            temperature = 0.3,
            top_p = 0.7,
        },
    },

    ---------------- set your keymaps for interaction ---------------
    keys = {
        ['Input:Submit'] = { mode = 'n', key = '<cr>' },
        ['Input:Cancel'] = { mode = { 'n', 'i' }, key = '<C-c>' },
        ['Input:Resend'] = { mode = { 'n', 'i' }, key = '<C-r>' },

        -- ...
    },

    ---------------------- set your app tools  ----------------------
    app_handler = {
        OptimCompare = {
            handler = require('llm.tools').action_handler,
            opts = {
                fetch_key = function()
                    return vim.env.OPENAI_API_KEY
                end,
                url = 'https://api.openai.com/v1/chat/completions',
                model = 'gpt-4o-mini',
                api_type = 'openai',
                language = 'English',
            },
            ['Your Tool Name'] = {
                -- handler =
                -- opts = {
                    --    fetch_key = function() return <your api key> end
                    -- }
                    -- url = 'https://xxx',
                    -- model = 'xxx'
                    -- api_type = ''
            },
            -- ...
        },
    },
})
