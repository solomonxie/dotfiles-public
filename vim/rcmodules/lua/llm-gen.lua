-- REF: https://github.com/David-Kunz/gen.nvim
-- Default prompts: https://github.com/David-Kunz/gen.nvim/blob/main/lua/gen/prompts.lua

-- Change model: :lua require('gen').select_model()

require('gen').setup({
    model = 'mistral',  -- $ ollama list  # show available models
    host = 'localhost',  -- The host running the DeepSeek service.
    port = '11434',  -- The port on which the DeepSeek service is listening.
    display_mode = 'float',  -- Display mode: 'float', 'split', or 'horizontal-split'.
    show_prompt = true,  -- Show the prompt submitted to DeepSeek.
    show_model = true,  -- Show which model you are using.
    no_auto_close = false,  -- Never closes the window automatically.
    file = false,  -- Write the payload to a temporary file.
    hidden = false,  -- Hide the generation window.
    result_filetype = 'markdown',  -- Filetype for the result buffer.
    quit_map = 'q',  -- Keymap to close the response window.
    retry_map = '<c-r>',  -- Keymap to re-send the current prompt.
    accept_map = '<c-cr>',  -- Keymap to replace the previous selection with the last result.
    init = function(options)
        -- Start DeepSeek server if not already running
        pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
    end,
    -- command = function(options)
    --     local body = {model = options.model, stream = true}
    --     return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    -- end,
    -- context = 1024 * 1024,  -- Adjust the context length as needed
    -- system_prompt = 'You are an AI assistant inside Neovim. You understand Neovim commands, keybindings, buffers, and Vimscript/Lua configuration. Provide responses tailored for Neovim users.',
    debug = false,  -- Print errors and command run.
})

-- Custom prompt commands:
require('gen').prompts['Demo_Prompt'] = {
  prompt = "Elaborate the following text:\n$text",
  replace = true
}

require('gen').prompts['Demo_Prompt_Fix_Code'] = {
  prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  replace = true,
  extract = "```$filetype\n(.-)```"
}
