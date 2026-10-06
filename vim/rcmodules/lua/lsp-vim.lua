-- Setup:
--   $ npm install -g vim-language-server
--   $ npm i -g bash-language-server
--   $ npm install -g typescript typescript-language-server
--   $ pip install python-lsp-server

vim.lsp.enable('vimls')
vim.lsp.config('vimls', {
    settings = {
        vimls = {
            cmd = {"vim-language-server", "--stdio"},
            filetypes = {"vim"},
            init_options = {
                diagnostic = {enable = true},
                indexes = {
                    count = 3,
                    gap = 100,
                    projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
                    runtimepath = true
                },
                iskeyword = "@,48-57,_,192-255,-#",
                runtimepath = "",
                suggest = {
                    fromRuntimepath = true,
                    fromVimruntime = true
                },
                vimruntime = ""
            }
        }
    }
})
