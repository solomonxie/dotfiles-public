
"REF: https://github.com/olimorris/codecompanion.nvim
Plug 'olimorris/codecompanion.nvim', {'commit': 'bfc0cd9'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'commit': '42fc28b'}


" Post-Vimplug setup
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/llm-codecompanion.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
