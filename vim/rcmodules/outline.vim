"REF: https://github.com/hedyhli/outline.nvim
" Symbol outline/tagbar replacement, LSP-based only (no treesitter, no
" ctags). Lighter than aerial.nvim and only needs Neovim 0.7+.
Plug 'hedyhli/outline.nvim', {'tag': 'v1.2.0'}

noremap ft <cmd>Outline<CR>

let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/outline.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
