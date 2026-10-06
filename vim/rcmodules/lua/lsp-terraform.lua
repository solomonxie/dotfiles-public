-- REF: https://github.com/hashicorp/terraform-ls
-- Setup:
--   :MasonInstall terraformls

vim.lsp.enable('terraformls')
vim.lsp.config('terraformls', {
    cmd = { 'terraform-ls', 'serve' },
    filetypes = { 'terraform', 'terraform-vars' },
})
