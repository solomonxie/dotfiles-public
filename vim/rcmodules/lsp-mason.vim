" --- MASON - MODERN LSP INSTALLER ---
" Feature: Mason is alternative to `lspinstaller`, `npm`, `homebrew`...
" NOTE: This plugin only manages installation (including virtual env of each package)
" NOTE: but it does not care about configurations of each LLP

" REF: https://github.com/williamboman/mason.nvim
Plug 'mason-org/mason.nvim', {'commit': '44d1e90e1f66e077268191e3ee9d2ac97cc18e65'}

" DEPs:
" REF: https://github.com/mason-org/mason-lspconfig.nvim
Plug 'mason-org/mason-lspconfig.nvim', {'tag': 'v2.3.0'}  "Auto install/enable/configure multiple LSPs
Plug 'neovim/nvim-lspconfig', {'tag': 'v2.5.0'}

" All pre-enabled LSPs are defined here:
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/lsp-mason.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t')
