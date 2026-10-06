"REF: https://github.com/hrsh7th/nvim-cmp
Plug 'hrsh7th/nvim-cmp', {'commit': '8c82d0b'}

"DEPs:
Plug 'neovim/nvim-lspconfig', {'tag': 'v2.5.0'}

" Completion Sources:
Plug 'hrsh7th/cmp-nvim-lsp', {'commit': 'cbc7b02'}
Plug 'hrsh7th/cmp-buffer', {'commit': 'b74fab3'}
Plug 'hrsh7th/cmp-path', {'commit': 'c642487'}
Plug 'hrsh7th/cmp-cmdline', {'commit': 'd126061'}
Plug 'hrsh7th/cmp-omni', {'commit': '4ef610b'}
" Plug 'f3fora/cmp-spell'
" Plug 'dmitmel/cmp-cmdline-history'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips', {'on': []}  "DISABLED for now, replaced by the 'my_snippets' source in rcmodules/lua/snippets.lua
" Plug 'uga-rosa/cmp-dictionary'
Plug 'ray-x/cmp-treesitter', {'commit': '958fcfa'}

let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/nvim_cmp.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
