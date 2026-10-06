--REF: https://github.com/nanotee/nvim-lua-guide
--REF: https://github.com/wbthomason/packer.nvim

local fn = vim.fn
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
-- end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'ap/vim-buftabline'

    -- luafile "~/.dotfiles/vim/luamodule/perf_profiling.lua"
    -- luafile "~/.dotfiles/vim/luamodule/nvim_provider.lua"
    -- luafile "~/.dotfiles/vim/luamodule/basic.lua"
    -- luafile "~/.dotfiles/vim/luamodule/hop.lua"
    -- luafile "~/.dotfiles/vim/luamodule/indent_line.lua"
    -- luafile "~/.dotfiles/vim/luamodule/buftabline.lua"
    -- luafile "~/.dotfiles/vim/luamodule/lightline.lua"
    -- luafile "~/.dotfiles/vim/luamodule/nerdtree.lua"
    -- luafile "~/.dotfiles/vim/luamodule/netrw.lua"
    -- luafile "~/.dotfiles/vim/luamodule/semshi.lua"
    -- luafile "~/.dotfiles/vim/luamodule/tagbar.lua"
    -- luafile "~/.dotfiles/vim/luamodule/fzf.lua"
    -- luafile "~/.dotfiles/vim/luamodule/ultisnips.lua"
    -- luafile "~/.dotfiles/vim/luamodule/anyjump.lua"
    -- luafile "~/.dotfiles/vim/luamodule/autopairs.lua"
    -- luafile "~/.dotfiles/vim/luamodule/nvim_lspconfig.lua"
    -- luafile "~/.dotfiles/vim/luamodule/nvim_compe.lua"
    -- luafile "~/.dotfiles/vim/luamodule/tig.lua"
    -- luafile "~/.dotfiles/vim/luamodule/gitgutter.lua"
    -- luafile "~/.dotfiles/vim/luamodule/blame.lua"

    -- BUILT-IN SETTINGS
    vim.cmd('source ~/.dotfiles/vim/vimrc-functions.vim')
    vim.cmd('source ~/.dotfiles/vim/vimrc-commands.vim')
    vim.cmd('source ~/.dotfiles/vim/vimrc-keymappings.vim')
    vim.cmd('source ~/.dotfiles/vim/vimrc-ui.vim')

    --------------------------------------------------------------------
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
    --------------------------------------------------------------------
end)
