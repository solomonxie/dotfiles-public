" Origin: Microsoft DAP protocol (vs LSP protocol)
" REF: https://microsoft.github.io/debug-adapter-protocol/overview
" Learn: https://www.youtube.com/watch?v=lyNfnI-B640

" REF: https://github.com/mfussenegger/nvim-dap
Plug 'mfussenegger/nvim-dap', {'tag': '0.10.0'}  "General DAP engine in Neovim for all languages


" Optional:

" REF: https://github.com/jbyuki/one-small-step-for-vimkind
Plug 'jbyuki/one-small-step-for-vimkind', {'commit': '1af6ffb'}  "DAP-Adapter for Lua(Neovim) language
" Actions
" Step1: Stay at code editing mode, add breakpoint by command
" :lua require"dap".toggle_breakpoint()
" Step2: write in the code
" :lua require"osv".launch({port = 8086})
" Step2: Go to another shell, launch the target process
" Step2: tell debugging server to 'continue'
" :lua require"dap".continue()
" Step3: run my code from another shell normally (web server or whatever)
" Step4: go back to the editor nvim, will see some debugging UI, can start to manipulate the target
" :lua require"dap".step_over()
" :lua require"dap".step_into()


" REF: https://github.com/rcarriga/nvim-dap-ui
Plug 'rcarriga/nvim-dap-ui', {'tag': 'v4.0.0'}
Plug 'nvim-neotest/nvim-nio', {'tag': 'v1.10.1'}  "Async utils for ui

" REF: https://github.com/theHamsta/nvim-dap-virtual-text
Plug 'theHamsta/nvim-dap-virtual-text'

" Post-Vimplug setup
let g:lua_configs += ['~/.dotfiles/vim/rcmodules/lua/nvim_dap.lua']
