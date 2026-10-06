" --- NERDTREE - FILE BROWSER ---

"LOAD SIGNIFICANTLY FASTER
"REF: https://github.com/preservim/nerdtree/issues/276
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTree'], 'commit': '690d061'}

" Plug 'scrooloose/nerdtree'  ", {'on': ['NERDTree', 'NERDTreeFind', 'NERDTreeToggle']}
" Plug 'jistr/vim-nerdtree-tabs'      " enhance nerdtree's tabs
" Plug 'ryanoasis/vim-devicons'       " add beautiful icons besides files
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "Slow down vim significantly

">> Key Mappings
nnoremap <Leader>f :NERDTree<CR>
" nnoremap <Leader>F :NERDTreeFind<CR>zz
" nnoremap FF :NERDTree<CR>
nnoremap ff :<C-U>call NerdTreeFindOrRoot()<CR>zz

function! NerdTreeFindOrRoot()
    if empty(expand('%'))
        NERDTree
    else
        NERDTreeFind
    endif
endfunction
" nnoremap <Leader>F :NERDTree %:p:h<CR>
" Add '%' for changing root accordingly
"nnoremap <Leader>f :NERDTree %:p:h<CR>
" nnoremap gd :NERDTreeFind<CR>zz
" nnoremap gD :NERDTree<CR>

">> UI settings
let NERDTreeQuitOnOpen=1   " Open|Close NERDtree when files was opened
let NERDTreeMinimalUI=1    " Start NERDTree in minimal UI mode (No help lines)
let NERDTreeDirArrows=1    " Display arrows instead of ascii art in NERDTree
let NERDTreeHighlightCursorline = 1  "Conflict with other addon-plugins for nerdtree
"let NERDTreeChDirMode=2    " Change current working directory based on root directory in NERDTree
let g:NERDTreeHidden=1     " Don't show hidden files
let NERDTreeWinSize=40     " Initial NERDTree width
let NERDTreeAutoDeleteBuffer = 1  " Auto delete buffer deleted with NerdTree
"let NERDTreeShowBookmarks=0   " Show NERDTree bookmarks
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '__pycache__', 'node_modules']   " Hide temp files in NERDTree
"let g:NERDTreeShowLineNumbers=1  " Show Line Number

"let NERDTreeAutoCenter = 1  "Not working

" Open Nerdtree when there's no file opened
"autocmd vimenter * if !argc()|NERDTree|endif
" Or, auto-open Nerdtree
"autocmd vimenter * NERDTree
function NerdTreeCustom()
    echom "nerd"
    " Close NERDTree when there's no other windows
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
        q
    endif
    " Manually turn on syntax
    " syntax manual
    " set syntax=on
endfunction

autocmd FileType nerdtree call NerdTreeCustom()

" NERDTree caches its "previous buffer" number at open time and jumps back to
" it on quit. Netrw's own buffer wiping (bufhidden=wipe, CloseNetrw) can free
" that number out from under it, throwing E86. Guard with bufexists() first.
function! SafeNERDTreeQuit() abort
    if exists('b:NERDTree') && b:NERDTree.isWinTree()
                \ && b:NERDTree.previousBuf() !=# -1 && bufexists(b:NERDTree.previousBuf())
        exec 'buffer ' . b:NERDTree.previousBuf()
    elseif winnr('$') > 1
        call g:NERDTree.Close()
    else
        call nerdtree#echo('Cannot close last window')
    endif
endfunction
autocmd FileType nerdtree nnoremap <buffer> q :call SafeNERDTreeQuit()<CR>

" Auto-refresh NERDTree root every second, replacing manual R press.
" Timer only runs while the NERDTree buffer is open.
let s:nerdtree_refresh_timer = -1

function! s:NerdTreeAutoRefresh(timer) abort
    silent! NERDTreeRefreshRoot
endfunction

function! s:StartNerdTreeAutoRefresh() abort
    if s:nerdtree_refresh_timer ==# -1
        let s:nerdtree_refresh_timer = timer_start(1000, function('s:NerdTreeAutoRefresh'), {'repeat': -1})
    endif
endfunction

function! s:StopNerdTreeAutoRefresh() abort
    if s:nerdtree_refresh_timer !=# -1
        call timer_stop(s:nerdtree_refresh_timer)
        let s:nerdtree_refresh_timer = -1
    endif
endfunction

if has('timers')
    autocmd FileType nerdtree call s:StartNerdTreeAutoRefresh()
    autocmd BufWinLeave NERD_tree_* call s:StopNerdTreeAutoRefresh()
endif


" Customize icons on Nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Git related
" Special characters
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
\ }


" --- Customized Abilities on Nerdtree ---
" call NERDTreeAddKeyMap({
"         \ 'key': 'E',
"         \ 'callback': 'MyNerdtreeFunc',
"         \ 'quickhelpText': 'put full path of current node into the default register' })
"
" function! MyNerdtreeFunc()
"     let n = g:NERDTreeFileNode.GetSelected()
"     if n != {}
"         call setreg('"', n.path.str())
"     endif
" endfunction



" --- Vim-Devicons - Icons for Nerdtree ---
"https://github.com/ryanoasis/vim-devicons/wiki/Extra-Configuration
if &runtimepath =~ 'vim-devicons'
    let g:webdevicons_enable = 1  "Enable plugin
    let g:webdevicons_enable_nerdtree = 1
    let g:webdevicons_enable_airline_tabline = 0
    let g:webdevicons_enable_airline_statusline = 0
    set guifont=DroidSansMono_Nerd_Font:h11
endif


" --- Nerdtree Syntax Highlight ---
"https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
if &runtimepath =~ 'nerdtree-syntax-highlight'
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
    let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
    let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
    let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreeLimitedSyntax = 1  "Disable uncommon file extensions highlighting
    " Disable
    " let g:NERDTreeDisableFileExtensionHighlight = 1
    " let g:NERDTreeDisableExactMatchHighlight = 1
    " let g:NERDTreeDisablePatternMatchHighlight = 1
endif


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
