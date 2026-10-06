"REF:" https://github.com/jackMort/ChatGPT.nvim
Plug 'jackMort/ChatGPT.nvim', {'commit': 'a4f32a5'}

"DEPs:
Plug 'MunifTanjim/nui.nvim', {'commit': 'f535005'}  "Neovim UI components
Plug 'nvim-lua/plenary.nvim'  "Neovim Lua functions
Plug 'nvim-telescope/telescope.nvim', {'commit': '3333a52'}  "Popup UI
Plug 'folke/trouble.nvim', {'commit': 'bd67efe'}  "Optional: Telescope enhancements

" Post-Vimplug setup
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/llm-chatgpt.lua']
