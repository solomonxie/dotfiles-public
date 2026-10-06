" Setup:
"   $ brew install tig
"   $ ln -sf $PWD/etc/tigrc ~/.tigrc

" if executable('git') && executable('tig')
" endif

"REF: https://github.com/iberianpig/tig-explorer.vim
Plug 'iberianpig/tig-explorer.vim', {'commit': 'ac49ff1'}  "faster/prettier (tig required)

nnoremap gt :TigStatus<CR>
