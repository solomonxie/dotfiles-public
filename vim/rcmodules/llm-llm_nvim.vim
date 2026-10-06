" REF: https://github.com/Kurama622/llm.nvim

Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'Kurama622/llm.nvim', {'commit': 'd10c83e'}



" Post-Vimplug setup
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/llm-llm_nvim.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
