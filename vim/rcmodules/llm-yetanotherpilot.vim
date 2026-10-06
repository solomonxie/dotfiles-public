
"REF: https://github.com/solomonxie/nvim-yetanotherpilot
Plug 'nvim-lua/plenary.nvim'
Plug 'solomonxie/nvim-yetanotherpilot', {'on': ['YetAnotherPilotSession', 'YetAnotherPilotSend', 'YetAnotherPilotAsk', 'YetAnotherPilotExplain', 'YetAnotherPilotClear', 'YetAnotherPilotProvider', 'YetAnotherPilotToggle']}

" Lazy-loaded via vim-plug's `on:` stubs: nothing loads/requires/runs until
" one of these commands fires for the first time. Defaults (provider,
" keymaps, models) match what setup() would otherwise set, so no eager
" luafile/require is needed.
nnoremap <leader>ce :YetAnotherPilotExplain<CR>
vnoremap <leader>ce :YetAnotherPilotExplain<CR>
nnoremap <leader>cs :YetAnotherPilotSession<CR>
vnoremap <leader>cs :YetAnotherPilotSession<CR>
nnoremap <leader>ct :YetAnotherPilotAsk
vnoremap <leader>ct :YetAnotherPilotAsk


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
