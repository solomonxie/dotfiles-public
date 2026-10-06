-- REF: https://github.com/mason-org/mason-lspconfig.nvim

local my_lsp_servers = {
    'pylsp',
    'vimls',
    'cssls',
    'sqlls',
    'emmet_ls',  --HTML
    'clangd',  -- C, C++
    'gopls',  -- Go
    'terraformls',  -- Terraform
    -- 'lua_ls',  -- super slow, 18s+ to load (it analyzes whole repo on first load)
    'emmylua_ls',  -- Lua, Rust-based replacement for lua_ls; see vim/.emmyrc.json
    'bashls',  -- Bash, sh, zsh
}

require('mason').setup({
    -- log_level = vim.log.levels.DEBUG,
})

require('mason-lspconfig').setup({
  ensure_installed = my_lsp_servers,
  -- v2 defaults this to true, auto-enabling *any* Mason-installed server
  -- (not just ones above) -- e.g. it silently resurrected a leftover
  -- lua-language-server install. The loop below already does enabling
  -- explicitly for the servers we actually want.
  automatic_enable = false,
})
-- ^ IF GOT ERROR, run :MasonInstall <LSP_NAME> or :Mason
-- then manually select lsp serers

-- Init LSP models (we can still override each later)
for _, lsp in ipairs(my_lsp_servers) do
    vim.lsp.enable(lsp)  --New syntax after nvim v0.11
    vim.lsp.config(lsp, {})  --New syntax after nvim v0.11
end

-- bashls ships filetypes {bash, sh}; zsh scripts parse close enough that its
-- document symbols are worth having there too (shell functions and globals).
-- Must follow the loop above, which resets each server's config.
vim.lsp.config('bashls', { filetypes = { 'bash', 'sh', 'zsh' } })
