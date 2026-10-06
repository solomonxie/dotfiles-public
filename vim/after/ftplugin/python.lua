-- `]]`/`[[`/`][`/`[]` jump between top-level defs/classes only, skipping
-- class methods (which the global treesitter.lua binding treats as
-- functions too). See vim/after/queries/python/textobjects.scm.
-- Deferred: nvim-treesitter-textobjects attaches its own buffer-local
-- ]]/[[ keymaps (bound to @function.outer) after FileType fires, which
-- would otherwise clobber these.
vim.schedule(function()
    local move = require('nvim-treesitter.textobjects.move')
    local opts = { buffer = true, silent = true }
    vim.keymap.set({'n', 'x', 'o'}, ']]', function() move.goto_next_start('@definition.outer') end, opts)
    vim.keymap.set({'n', 'x', 'o'}, '][', function() move.goto_next_end('@definition.outer') end, opts)
    vim.keymap.set({'n', 'x', 'o'}, '[[', function() move.goto_previous_start('@definition.outer') end, opts)
    vim.keymap.set({'n', 'x', 'o'}, '[]', function() move.goto_previous_end('@definition.outer') end, opts)
end)
