" --- copilot.vim (tpope) ---
" REF: https://github.com/github/copilot.vim
Plug 'github/copilot.vim', {'tag': 'v1.59.0'}  "Develooped by Tpope

" Authentication: do ":Copilot setup" then follow instructions to jump to browser
" Verify: $ cat ~/.config/github-copilot/apps.json


" Set keymap for accept copilot suggestion
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

let g:copilot_no_tab_map = 1  "Disable default tab mapping
" imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

" let g:copilot_enabled = 0  "Disable by default, do `:Copilot enable` to use




" --- CopilotChat.nvim ---
" Feature: This is an independent plugin to `copilot.vim`
" REF: https://github.com/CopilotC-Nvim/CopilotChat.nvim
Plug 'CopilotC-Nvim/CopilotChat.nvim', {'tag': 'v4.7.4'}  "Require nvim>0.10
Plug 'nvim-lua/plenary.nvim', {'tag': 'v0.1.4'}

" Post-Vimplug setup
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/llm-copilot.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
