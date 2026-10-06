-- -- Check environment (Very fast, only check $PATH variable)
-- if vim.fn.executable('pylsp') ~= 1 then
--     print('LSP server not installed, please do $ pip install python-lsp-server[all]')
--     return
-- end

-- REF: https://github.com/python-lsp/python-lsp-server
vim.lsp.enable('pylsp')
vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            cmd = { "pylsp" },
            filetypes = {"python"},
            debounce = 100,
            single_file_support = true,
            skip_token_initialization=true,
            -- -- configurationSources = { "flake8" },  -- CONFLICT WITH pylsp.plugins.flake8.config
            init_options = { lint = false },
            plugins = {
                pylint =  { enabled = false, args = { "--rcfile", vim.fn.expand("~/.config/pylintrc") } },
                flake8 = { enabled = false, config = vim.fn.expand("~/.config/flake8")  },
                pylsp_mypy =  { enabled = false },
                mypy =  { enabled = false },
                pycodestyle =  { enabled = false },
                pyflakes =  { enabled = false },
                jedi_completion = { enabled = true, include_params = true },  -- Important for completion
            },
            -- ^ Have to specifically everything "enabled=false" otherwise enabled by default
        }
    }
})

-- REF: https://github.com/sourcery-ai/sourcery
vim.lsp.config("sourcery", {
    on_attach=on_attach_general,
})

-- REF: https://github.com/emanspeaks/pyls-flake8/
-- $ pip install pyls-flake8
vim.lsp.config("pylsp-flake8", {
    on_attach=on_attach_general,
})

-- REF: https://github.com/pappasam/jedi-language-server
-- REF: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jedi_language_server
-- $ pip install jedi-language-server
vim.lsp.config("jedi_language_server", {
    on_attach=on_attach_general,
    cmd = {"jedi-language-server"},
    filetypes = {"python"},
    single_file_support = true,
    jediSettings = {
        caseInsensitiveCompletion = true,
    },
})

vim.lsp.config("pyright", {
    on_attach=on_attach_general,
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    single_file_support = true,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    }
})
-- REF: https://github.com/microsoft/pyright
-- REF: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
-- $ npm -g install pyright
vim.lsp.config("pyright", {
    on_attach=on_attach_general,
    cmd = {"pyright-python-langserver", "--stdio"},
    filetypes = {"python"},
    single_file_support = true,
    -- root_dir = function(startpath)
    --     return M.search_ancestors(startpath, matcher)
    -- end,
    settings = {
      python = {
        analysis = {
          disableOrganizeImports = true,
          disableLanguageServices = false,
          autoImportCompletions = true,
          typeCheckingMode = "off",  -- off|basic|strict
          diagnosticMode = "workspace",  -- workspace | openFilesOnly
          useLibraryCodeForTypes = true,
        }
      }
    }
})

-- $ npm install -g diagnostic-languageserver
vim.lsp.config('diagnosticls', {
    filetypes = { "python" },
    init_options = {
        filetypes = {
            python = {"flake8"},
        },
        linters = {
            flake8 = {
                debounce = 100,
                sourceName = "flake8",
                command = "flake8",
                args = {
                    "--config",
                    "~/.config/flake8",
                    "--format",
                    "%(row)d:%(col)d:%(code)s:%(code)s: %(text)s",
                    "%file",
                },
                formatPattern = {
                    "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
                    {
                        line = 1,
                        column = 2,
                        message = {"[", 3, "] ", 5},
                        security = 4
                    }
                },
                securities = {
                    E = "error",
                    W = "warning",
                    F = "info",
                    B = "hint",
                },
            },
        },
    }
})
