------------------------------------------------------------------------
--                           Solargraph LSP                           --
------------------------------------------------------------------------
-- REF: https://github.com/castwide/solargraph
-- Dependencies:
-- $ export PATH="$HOME/.rbenv/versions/3.3.0/bin:$PATH"
-- $ gem install phashion -v '1.2.0'
-- or :MasonInstall solargraph
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- vim.lsp.config('ruby_lsp', {
--     -- Not working...
-- }

vim.lsp.enable('solargraph')
vim.lsp.config('solargraph', {
  cmd = { 'solargraph', 'stdio' },
  filetypes = {
      "ruby"
  },
  flags = {
      debounce_text_changes = 150
  },
  root_dir = vim.lsp.config.util.root_pattern('Gemfile', '.git', '.'),
  capabilities = capabilities,
  settings = {
    solargraph = {
      autoformat = false,
      formatting = false,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true
    }
  }
})


------------------------------------------------------------------------
--                          Shopify/ruby-lsp                          --
------------------------------------------------------------------------
-- -- REF: https://github.com/Shopify/ruby-lsp
-- -- Dependencies:
-- -- $ gem install ruby-lsp -v 0.5.1
-- local lspconfig = require('lspconfig')
-- local configs = require('lspconfig.configs')
-- local util = require('lspconfig.util')

-- if not configs.ruby_lsp then
--     local enabled_features = {
--         "documentHighlights",
--         "documentSymbols",
--         "foldingRanges",
--         "selectionRanges",
--         -- "semanticHighlighting",
--         "formatting",
--         "codeActions",
--     }

--     configs.ruby_lsp = {
--         default_config = {
--             cmd = { "bundle", "exec", "ruby-lsp" },
--             filetypes = { "ruby" },
--             root_dir = util.root_pattern("Gemfile", ".git"),
--             init_options = {
--                 enabledFeatures = enabled_features,
--             },
--             settings = {},
--         },
--         commands = {
--             FormatRuby = {
--                 function()
--                     vim.lsp.buf.format({
--                         name = "ruby_lsp",
--                         async = true,
--                     })
--                 end,
--                 description = "Format using ruby-lsp",
--             },
--         },
--     }
-- end

-- lspconfig.ruby_lsp.setup({ on_attach = on_attach, capabilities = capabilities })
