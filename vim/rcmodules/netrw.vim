"<NetRW File Tree>
" ============================================================================
" Netrw Directory Listing                                        (netrw v170)
"   ~/.dotfiles
"   Sorted by      name
"   Sort sequence: [\/]$,\<core\%(\.\d\+\)\=\>,\.h$,\.c$,\.cpp$,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$
"   Hiding:        \(^\|\s\s\)\zs\.\S\+
"   Quick Help: <F1>:help  -:go up dir  D:delete  R:rename  s:sort-by  x:special
" ==============================================================================
" HELP LINKS ===>
" :help netrw-quickmap

let g:netrw_banner=1
let g:netrw_hide=1
let g:netrw_browse_split=0  " 0 = open files in netrw's own window (single-window `:e folder/` use)
let g:netrw_liststyle=0  " flat listing -- tree (3) uses a shadow "NetrwTreeListing" buffer that lingers
let g:netrw_altv = 2
let g:netrw_winsize=30
let g:netrw_list_hide = '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'


let g:netrw_fastbrowse = 0

let g:netrw_winsize = 25  " Window size 25%

function! CloseNetrw() abort
    " Sweep every netrw buffer (by filetype, name, or b:netrw_curdir) -- netrw
    " juggles multiple buffers per listing, and wiping only the current one
    " leaves the directory-named buffer behind to reseed a fresh display.
    for bufn in range(1, bufnr('$'))
        if !bufexists(bufn) | continue | endif
        if getbufvar(bufn, '&filetype') ==# 'netrw'
                    \ || bufname(bufn) =~# 'NetrwTreeListing'
                    \ || !empty(getbufvar(bufn, 'netrw_curdir'))
            silent! execute 'bwipeout! ' . bufn
        endif
    endfor
endfunction

augroup closeOnOpen
    autocmd!
    autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), "&filetype") != "netrw"|call CloseNetrw()|endif
aug END

" All netrw buffer-local mappings/settings, kept in one place
augroup netrwLocal
    autocmd!
    autocmd FileType netrw setl bufhidden=wipe
    autocmd FileType netrw nmap <buffer> o <CR>
    autocmd FileType netrw nmap <buffer> p -
    " <nowait>: netrw's own qb/qf/qF/qL mappings make bare "q" an ambiguous
    " prefix otherwise (this also makes those four unreachable -- q always wins)
    autocmd FileType netrw nnoremap <buffer> <nowait> q :call CloseNetrw()<CR>
    autocmd FileType netrw if exists('b:netrw_bannercnt') | execute b:netrw_bannercnt | endif
augroup END

" nnoremap ff :silent execute "let @/=expand('%:t')<Bar>silent execute 'Lexplore' expand('%:h')<Bar>normal n"<CR>
" nnoremap <Leader>f :Lexplore .<CR>


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
