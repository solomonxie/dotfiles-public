" --- VIM FUNCTIONS ---

function! Hello_word()
    let my_grouped_opts = input ( "1.- Search one\n2.- Search two\n3.- Search three\n" )
    let my_list_opts = split( my_grouped_opts, ".\zs" )
    for selection in my_list_opts
        echo "\nOption number " selection " selected"
    endfor
endfunction


function! JumpToBuffer(...)
    let bufindex = a:1
    let buffer_list = filter(range(1, bufnr("$")), "buflisted(v:val)")
    " echo buffer_list
    exe ":buffer " . buffer_list[bufindex]
endfunction


function! HowManyBuffers()
    let buffer_list = filter(range(1, bufnr("$")), "buflisted(v:val)")
    echo 'There are [' . len(buffer_list) . '] buffers'
endfunction


" Open git changed files
function! EditChangedFiles()
    let fnames = split(system("git diff --name-only"), "\n")
    for fn in fnames
        " execute "argadd " fn
        execute "next " fn
    endfor
endfunction


"{Toggle Relative Line Number}
function! ToggleRelativeNumber()
    if &relativenumber == 0
        set number relativenumber
    else
        set number norelativenumber
    endif
endfunction

"{Flash Relative Line Number -- show just long enough to type a {count}j/k
" jump, then auto-hide on the first cursor move so it doesn't stay on}
function! FlashRelativeNumber() abort
    if &relativenumber
        return  " already on (e.g. via the permanent toggle) -- leave it alone
    endif
    set relativenumber
    augroup FlashRelativeNumberOff
        autocmd!
    augroup END
    " Arm the auto-hide on the next event-loop tick, not immediately: the
    " visual-mode mapping does :<C-u>call FlashRelativeNumber()<CR>gv, and
    " that trailing gv (restoring the selection) is itself a cursor move --
    " arming synchronously would let it self-trigger before the user ever
    " gets to type their real jump.
    call timer_start(0, {-> s:ArmUnflash()})
endfunction

function! s:ArmUnflash() abort
    if !&relativenumber
        return  " toggled off already (e.g. race with another flash)
    endif
    augroup FlashRelativeNumberOff
        autocmd!
        autocmd CursorMoved <buffer> call s:UnflashRelativeNumber()
    augroup END
endfunction

function! s:UnflashRelativeNumber() abort
    set norelativenumber
    autocmd! FlashRelativeNumberOff
endfunction


function! LoadVimrc()
    :tabnew
    :source ~/dotfiles/vim/workspace.vim
endfunction


function! s:GitRemoteFileUrl(with_line, ...) abort
    let l:file = expand('%:p')
    let l:target = a:0 >= 1 ? a:1 : l:file
    let l:kind = a:0 >= 2 ? a:2 : 'blob'
    if empty(l:target) || (a:0 == 0 && &buftype !=# '')
        echoerr 'Current buffer is not a file'
        return ''
    endif

    let l:file_dir = a:0 >= 1 ? l:target : expand('%:p:h')
    let l:root = trim(system('git -C ' . shellescape(l:file_dir) . ' rev-parse --show-toplevel'))
    if v:shell_error || empty(l:root)
        echoerr 'Current file is not in a Git repository'
        return ''
    endif

    let l:remotes = systemlist('git -C ' . shellescape(l:root) . ' remote')
    let l:remote = get(l:remotes, 0, '')
    if empty(l:remote)
        echoerr 'No Git remote found'
        return ''
    endif

    let l:remote_url = trim(system('git -C ' . shellescape(l:root) . ' remote get-url ' . shellescape(l:remote)))
    if v:shell_error || empty(l:remote_url)
        echoerr 'Could not determine Git remote URL'
        return ''
    endif

    let l:remote_url = substitute(l:remote_url, '^git@\([^:]*\):', 'https://\1/', '')
    let l:remote_url = substitute(l:remote_url, '^ssh://git@', 'https://', '')
    let l:remote_url = substitute(l:remote_url, '^git+ssh://git@', 'https://', '')
    let l:remote_url = substitute(l:remote_url, '/\?$', '', '')
    let l:remote_url = substitute(l:remote_url, '\.git$', '', '')

    let l:branch = trim(system('git -C ' . shellescape(l:root) . ' symbolic-ref --short HEAD 2>/dev/null'))
    if empty(l:branch)
        let l:branch = trim(system('git -C ' . shellescape(l:root) . ' rev-parse HEAD'))
    endif

    let l:relative = strpart(l:target, strlen(l:root) + 1)
    let l:relative = substitute(l:relative, ' ', '%20', 'g')
    let l:branch = substitute(l:branch, ' ', '%20', 'g')
    let l:host = tolower(matchstr(l:remote_url, '^https\?://[^/]*'))
    if l:host =~# 'github\.com'
        let l:url = l:remote_url . '/' . l:kind . '/' . l:branch . '/' . l:relative
    elseif l:host =~# 'gitlab\.'
        let l:url = l:remote_url . '/-/' . l:kind . '/' . l:branch . '/' . l:relative
    elseif l:host =~# 'bitbucket\.'
        let l:url = l:remote_url . '/src/' . l:branch . '/' . l:relative
    else
        let l:url = l:remote_url . '/' . l:kind . '/' . l:branch . '/' . l:relative
    endif

    if a:with_line
        let l:url .= '#L' . line('.')
    endif
    return l:url
endfunction

function! GetGithubLink(with_line) abort
    let l:url = s:GitRemoteFileUrl(a:with_line)
    if empty(l:url)
        return
    endif
    let @+ = l:url
    echo 'Copied Git remote link'
endfunction

function! GetGitRemoteCodeReferenceLink()
    call GetGithubLink(1)
endfunction

function! GithubLink()
    call GetGithubLink(0)
endfunction

function! GithubLinkCurrentLine()
    call GetGithubLink(1)
endfunction

function! GitOpen() abort
    if empty(expand('%:p')) || &buftype !=# ''
        let l:url = s:GitRemoteFileUrl(0, getcwd(), 'tree')
    else
        let l:url = s:GitRemoteFileUrl(0)
    endif
    if empty(l:url)
        return
    endif

    if executable('open')
        let l:browser = 'open'
    elseif executable('xdg-open')
        let l:browser = 'xdg-open'
    elseif executable('cmd.exe')
        let l:browser = 'cmd.exe'
    else
        echo l:url
        return
    endif

    call jobstart([l:browser, l:url], {'detach': v:true})
    echo 'Opened ' . l:url
endfunction


function! GetSessionPath()
    let g:gitroot = trim(system("git rev-parse --show-toplevel"))
    if isdirectory(g:gitroot)
        let session_path = g:gitroot . "/.git/workspace.vim"
    else
        let session_path = "/tmp/lastsession.vim"
    endif
    return session_path
endfunction


" function! SaveSessionBuiltIn()
function! SaveSession()
    let session_path = GetSessionPath()
    execute "mksession! " . session_path
    echo "Saved session to: " . session_path
endfunction


function! SaveSessionSimple()
    echom "SAVING SESSION BY FILES..."
    let buffer_list = filter(range(1, bufnr("$")), "buflisted(v:val)")
    " echom 'Buffers: ' . string(buffer_list)
    let session_path = GetSessionPath()
    let steps = []
    call add(steps, 'cd '. fnameescape(getcwd()))
    call add(steps, 'let g:gitroot = "'. g:gitroot . '"')
    call add(steps, 'let s:wipebuf = bufnr("%")')  "Mark initial/empty buffer
    " Record buffers
    for bufnr in buffer_list
        let l:bufname = expand('#' .. bufnr .. ':p')
        if bufexists(bufnr) && buflisted(bufnr) && getbufvar(bufnr, '&buftype') ==# '' && !isdirectory(l:bufname)
            call add(steps, '$argadd ' . fnameescape(expand('#' . bufnr . ':p')))
        endif
    endfor
    " Record others
    call add(steps, 'edit ' . fnameescape(expand('#'. bufnr('%') .':p')))  "Set focused file
    call add(steps, 'call cursor(' . line('.') . ', ' . col('.') . ')')  "Restore cursor in focused file
    call add(steps, 'normal! zz')  "Center view on restored cursor line
    call add(steps, 'silent exe "bwipe " . s:wipebuf')  "Remove initial/empty buffer
    " echom 'Steps: ' . string(steps)
    if len(steps) > 0
        call writefile(steps, session_path, 'b')
    endif
    echom "SAVED SESSION TO: " . session_path
endfunction


function! SaveSessionByObsession()
    echom "SAVING SESSION BY FILES..."
    let session_path = GetSessionPath()
    execute "Obsession! " . session_path
    echom "SAVED SESSION TO: " . session_path
endfunction


function! LoadSession()
    let session_path = GetSessionPath()
    execute "source " . session_path
    echom "LOADED SESSION FROM: " . session_path
endfunction


"Search/grep pattern and open files
function! GrepOpen(...)
    let keywords = a:1
    let path = "."
    echo "searching [" . keywords . "]..."
    if executable("ag")
        let cmd = "ag -l '" . keywords . "' ". path
    else
        let cmd = "grep -l -r -E '" . keywords . "' " . path
    endif
    let result = trim(system(cmd))
    echo "Search result:\n" . result . "\n\n"
    let target_files = split(result, "\n")
    let choice = input("Open above [". len(target_files) ."] files? (Y/N):")
    if choice == 'y' || choice == 'Y'
        for fname in target_files
            execute "edit " . fname
        endfor
    endif
endfunction


function! UpdatePlugins()
    echo system('pip install --user --upgrade pynvim')
    echo system('pip install --user --upgrade msgpack')
endfunction


function! DebugCurrentFile()
    " https://marketplace.visualstudio.com/items?itemName=fabiospampinato.vscode-debug-launcher
    " - https://github.com/fabiospampinato/vscode-debug-launcher/blob/master/docs/terminal.md
    " REQUIRES:
    " 1. MACOS
    " 2. VSCODE + DEBUG LAUNCHER (EXTENSION)
    let file_path = expand('%:p')
    let cmd = "open 'vscode://fabiospampinato.vscode-debug-launcher/file?args=". file_path ."'"
    echo system(cmd)
endfunction

" REF: https://gist.github.com/JoshuaJWilborn/e8c14b8fabaca3e18178c69f556d30cf
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction


function! OpenLink(...)
    let link = a:1
    let url = substitute(link, '\#', '\\#', 'g')
    let cmd = "open " . url
    echo system(cmd)
endfunction


function! EscapeString(...)
    let text = a:1
    let text = substitute(text, '\\', '\\\\', 'g')
    let text = substitute(text, '\/', '\\/', 'g')
    let text = substitute(text, '\~', '\\~', 'g')
    let text = substitute(text, '\[', '\\[', 'g')
    let text = substitute(text, '\]', '\\]', 'g')
    " let text = substitute(text, '\#', '\\#', 'g')
    " let text = substitute(text, '\@', '\\@', 'g')
    return text
endfunction

function! GetVisualSelection()
    "REF: https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! ReplaceSelection()
    "Test: /path/to/abc/def/hah
    "Test: abc~!@#$%%^&&**()
    let l:src = GetVisualSelection()
    let l:src2 = EscapeString(l:src)
    let l:dest = input("Alternative ----> ", l:src)
    let l:dest2 = EscapeString(l:dest)
    if index(['y', 'Y'], input('All buffers? [Yy/Nn]: ', 'n')) >= 0
        let l:bufs = ' bufdo '
    else
        let l:bufs = ''
    endif
    let l:cmd = 'silent! '. l:bufs .' %s#' . l:src2 . '#' . l:dest2 . '#gc'
    if index(['y', 'Y'], input(l:cmd . ' ----> [Yy/Nn]: ', 'y')) >= 0
        let l:buf = bufnr('%')  "Remember current buffer
        " Add to command history
        call histadd("cmd", l:cmd)
        " execute l:cmd
        call feedkeys(':'. l:cmd, 'i')
        " Return to the remembered buffer:
        execute 'buffer ' . l:buf
    else
        echo "\n^Canceled"
    endif
endfunction


function! ToggleVerbose()
    " $ tail -f /tmp/vim-runtime.log
    " $ less +F /tmp/vim-runtime.log
    " When bigger than zero, Vim will give messages about what it is doing. Currently, these messages are given:
    " >= 1 When the viminfo file is read or written.
    " >= 2 When a file is ":source"'ed.
    " >= 5 Every searched tags file and include file.
    " >= 8 Files for which a group of autocommands is executed.
    " >= 9 Every executed autocommand.
    " >= 12 Every executed function.
    " >= 13 When an exception is thrown, caught, finished, or discarded.
    " >= 14 Anything pending in a ":finally" clause.
    " >= 15 Every executed Ex command (truncated at 200 characters).
    if !&verbose
        set verbosefile=/tmp/vim-runtime.log
        set verbose=9
    else
        set verbose=0
        set verbosefile=
    endif
endfunction


function! ShowHighlightGroupUnderCursor ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction


function! ChangeCwdToProjectRoot ()
    let s:cwd = expand('%:p')
    echo s:cwd
    " TBD
    " ...
endfunction


function! BuildCurrentFile ()
    write
    if &filetype ==# 'python'
        execute '!python3 ' . shellescape(expand('%:p'))
    elseif &filetype ==# 'c'
        execute '!gcc ' . shellescape(expand('%')) . ' -o /tmp/a.out && /tmp/a.out'
    elseif &filetype ==# 'cpp' || &filetype ==# 'c++' || &filetype ==# 'cc'
        execute '!clang++ ' . shellescape(expand('%')) . ' -Wall -Wextra -std=c++17 -o /tmp/a.out && /tmp/a.out'
    elseif &filetype ==# 'javascript'
        " Call your custom JS debug function
        call DebugCurrentFile()
    elseif &filetype ==# 'sh'
        execute '!bash ' . shellescape(expand('%'))
    elseif expand('%') =~# 'Makefile'
        execute '!make'
    elseif expand('%:t') =~# '\v(\.vim|\.vimrc|vimrc.*)'
        execute 'source ~/.vim/init.vim'
    elseif expand('%:t') =~# '\v(\.zshrc|zshrc.*)'
        execute '!source ' . shellescape(expand('%:p'))
    else
        echo "No build command defined for this filetype."
    endif
endfunction


function! PreviewMarkdown()
    " Render current markdown buffer to HTML (dark theme, mermaid diagrams, KaTeX math)
    " via pandoc and open it in the browser.
    if &filetype !=# 'markdown'
        echo 'Not a markdown file.'
        return
    endif
    echo 'Generating preview page for ' . expand('%:t') . '...'
    let l:css_dark = expand('<script>:p:h') . '/scripts/markdown-preview-dark.css'
    let l:css_light = expand('<script>:p:h') . '/scripts/markdown-preview-light.css'
    let l:mermaid = expand('<script>:p:h') . '/scripts/markdown-preview-mermaid.html'
    let l:toggle = expand('<script>:p:h') . '/scripts/markdown-preview-theme-toggle.html'
    let l:slug = substitute(expand('%:p:r'), '[/.]', '-', 'g')
    let l:out = '/tmp/' . l:slug . '.html'
    let l:cmd = 'pandoc ' . shellescape(expand('%:p'))
        \ . ' -s --katex --embed-resources'
        \ . ' --css=' . shellescape(l:css_dark)
        \ . ' --css=' . shellescape(l:css_light)
        \ . ' --include-after-body=' . shellescape(l:mermaid)
        \ . ' --include-after-body=' . shellescape(l:toggle)
        \ . ' -o ' . shellescape(l:out) . ' && open ' . shellescape(l:out)
    if exists('*jobstart')
        call jobstart(l:cmd)
    else
        call system(l:cmd)
    endif
endfunction


function! SearchInFile(pattern)
    " Good for searching text with special characters
    let oldpat=@/
    let @/=a:pattern
    let old_a=@a
    normal! gg"aygn
    let result=@a
    let @a=old_a
    let @/=oldpat
    return result
endfunction

function! ToggleVerbose()
    let s:path = "/tmp/vim_verbose_". strftime('%Y%m%d') .".log"
    if !&verbose
        echo 'Turnning on verbose mode and saving runtime log into: '. s:path
        let &verbosefile = s:path
        set verbose=15
    else
        echo 'Turnning off verbose mode'
        let &verbose=0  "set verbose=0
        set verbosefile=
    endif
endfunction


function! SendContextToAI(...) range
    " Send current file path + line (or visual line range), plus an optional
    " trailing message, to the tmux pane on the right.
    if a:firstline == a:lastline
        let l:loc = expand('%') . ':L' . a:firstline
    else
        let l:loc = expand('%') . ':L' . a:firstline . '-' . a:lastline
    endif
    let l:msg = 'Context: ' . l:loc
    let l:has_question = a:0 > 0 && a:1 !=# ''
    if l:has_question
        let l:msg .= "\n" . a:1
    else
        let l:msg .= "\n"
    endif
    call system('tmux send-keys -t "{right-of}" -l ' . shellescape(l:msg))
    if l:has_question
        " A pasted "\n" just inserts a line break in the prompt box, it
        " doesn't submit — send a real Enter keystroke to ask right away.
        call system('tmux send-keys -t "{right-of}" Enter')
    endif
    call system('tmux select-pane -t "{right-of}"')
endfunction

" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
