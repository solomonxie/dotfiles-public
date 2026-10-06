

"REF: https://github.com/Robitx/gp.nvim
Plug 'robitx/gp.nvim', {'commit': 'e6a01e9'}


" Post-Vimplug setup
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/llm-gp.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
