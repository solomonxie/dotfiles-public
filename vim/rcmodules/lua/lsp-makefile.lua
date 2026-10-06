-- REF: https://github.com/Freed-Wu/autotools-language-server
-- Goto Definition, Find References, Diagnostics, Hover, Completion for
-- Makefile / Makefile.am / configure.ac. Not in Mason — installed into
-- the shared ~/virtualenv/venv nvim's python3_host_prog already points at.

vim.lsp.config('autotools_ls', {
  cmd = { vim.fn.expand('~/virtualenv/venv/bin/autotools-language-server') },
  filetypes = { 'make', 'automake', 'config' },
  root_markers = { 'Makefile', 'configure.ac', '.git' },
})
vim.lsp.enable('autotools_ls')
