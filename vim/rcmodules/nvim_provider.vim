" --- NEOVIM PROVIDERS ---

":checkhealth provider


" --- NODE.JS ---
"$ npm install -g neovim
let g:node_host_prog = expand('~/virtualnode/venv/bin/neovim-node-host')

" --- PYTHON ---
" Default
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('~/virtualenv/venv/bin/python')
" let g:python3_host_prog = '~/virtualenv/venv_nvim/bin/python'  "SHOULD BE INDEPENDENT
" let g:python_host_prog = '~/virtualenv/venv2/bin/python'


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
