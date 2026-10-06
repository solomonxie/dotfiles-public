-- Setup:
--    $ vim ~/.global.env then add `OPENAI_API_KEY=<YOUR_API_KEY>`
--    $ vim ~/.vimrc-local.vim then add `lua vim.env.OPENAI_API_KEY = "sk-xxxx"`
--REF:" https://github.com/jackMort/ChatGPT.nvim


require('chatgpt').setup({
    openai_params = {
        model = "gpt-5-mini",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
    }
})
