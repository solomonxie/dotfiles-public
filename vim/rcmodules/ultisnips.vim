" DISABLED for now: not sourced from nvimrc.vim anymore, replaced by the
" custom engine in snippets.vim + lua/snippets.lua. Kept here for reference /
" in case it's worth reviving (e.g. for its `!p` Python interpolation, which
" the replacement doesn't support).

" REF: https://github.com/SirVer/ultisnips/blob/master/doc/UltiSnips.txt
Plug 'SirVer/ultisnips', {'commit': 'b22a86f', 'on': []}  " Track the engine. Lazy-loaded on InsertEnter (saves ~54ms off startup).

" REF: https://github.com/honza/vim-snippets
Plug 'honza/vim-snippets', {'commit': 'ededcf7'}  " Snippets are separated from the engine.

" Could be buggy if not specifying the Python version
let g:UltiSnipsUsePythonVersion=3

" Trigger configuration.
" Do not use <tab> if you use YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-k>"  "Anything but <Tab>/<Enter>/<Space>, too many conflicts.
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Specify snippets locations ==> MUST BE FULL PATH (`~` DOESN'T WORK) !!
" let g:UltiSnipsSnippetsDir = expand("~/.vim/mysnippets")
let g:UltiSnipsSnippetDirectories=[expand('~/vim_plugged/vim-snippets/UltiSnips/'), expand('~/.dotfiles/vim/mysnippets')]

" [  Lazy Load Plugins  ]-----------{
    augroup load_ultisnips
        autocmd!
        autocmd InsertEnter * ++once call plug#load('ultisnips', 'cmp-nvim-ultisnips')
    augroup END
" }


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
