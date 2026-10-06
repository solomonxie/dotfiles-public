--REF: https://github.com/olimorris/codecompanion.nvim

require('codecompanion').setup({
    opts = {
        log_level = 'DEBUG', -- DEBUG|TRACE|INFO
    },
    adapters = {
        openai = {
            api_key = vim.env.OPENAI_API_KEY,   -- set in `~/.vimrc-env.vim`
            model = 'gpt-4.1-mini',
        }
    },
    strategies = {
        chat = {
            adapter = 'openai',
        },
        inline = {
            adapter = 'openai',
        },
        agent = {
            adapter = 'openai',
        }
    }
})
