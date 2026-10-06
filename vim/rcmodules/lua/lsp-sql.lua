-- REF: https://github.com/joe-re/sql-language-server
-- Setup:
--   $ npm i -g sql-language-server
--   OR:
--   :MasonInstall sqlls

vim.lsp.enable('sqlls')
vim.lsp.config('sqlls', {
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
    filetypes = { 'sql', 'mysql' },
    settings = {
    }
})
