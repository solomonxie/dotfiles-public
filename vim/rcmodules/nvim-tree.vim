"REF: https://github.com/nvim-tree/nvim-tree.lua
Plug 'nvim-tree/nvim-tree.lua'

">> Key Mappings (same keys as nerdtree.vim -- nerdtree.vim is currently
" disabled, so free to reuse). Repo root passed straight to :NvimTreeToggle
" (it takes an optional path arg) so opening always resets there, rather
" than staying wherever "-" last left it.
nnoremap <silent> <Leader>f :execute 'NvimTreeToggle' trim(system('git rev-parse --show-toplevel'))<CR>
nnoremap <silent> ff :NvimTreeFindFile!<CR>zz

" Setup runs after plug#end() via the g:lua_configs loop in nvimrc.vim --
" vim-plug only adds nvim-tree's lua/ dir to package.path once plug#end()
" finishes, so require("nvim-tree") here (inline, mid Plug block) would fail.
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/nvim-tree.lua']

" Close nvim-tree when it's the only window left (official nvim-tree recipe)
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() =~# '^NvimTree_' | quit | endif


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
