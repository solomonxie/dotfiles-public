" --- TREE SITTER - FOR BUILDING PLUGINS ---

" REF: https://tree-sitter.github.io/tree-sitter/
" REF: https://github.com/nvim-treesitter/nvim-treesitter

" ACTIONS:
" 1. Download Nvim 0.5+ Release
" 2. :PlugInstall
" 3. :TSInstall python javascript bash json

Plug 'nvim-treesitter/nvim-treesitter', {'tag': 'v0.10.0'}
" Plug 'nvim-treesitter/playground'

Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'commit': '5ca4aaa6efdcc59be46b95a3e876300cfead05ef'}

" NOTE: also check settings in `./vim/nvimrc.vim` to avoid conflicts
" Treesitter folding is powerful but can be very slow on large files.
" We only enable it for files smaller than 100KB.
augroup TreesitterFolding
    autocmd!
    autocmd BufReadPost,BufNewFile *
        \ if getfsize(expand("<afile>")) < 100000 && getfsize(expand("<afile>")) != -2 |
        \   setlocal foldmethod=expr |
        \   setlocal foldexpr=v:lua.vim.treesitter.foldexpr() |
        \ else |
        \   setlocal foldmethod=indent |
        \ endif
augroup END


" Post-Vimplug setup
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/treesitter.lua']
