-- REF: https://github.com/hedyhli/outline.nvim

-- `outline_window.split_command` is left at the default: outline.nvim has a
-- bug where any custom value not containing " vs" gets " vs" silently
-- appended (config.lua's resolve_config), which turns our "botright
-- Nsplit" into "botright Nsplit vs" -- Vim then parses trailing "vs" as a
-- filename argument, leaving a stray buffer literally named "vs" behind.
-- Bottom-bar placement is done via the BufWinEnter autocmd below instead.
require('outline').setup({
    outline_window = {
        auto_close = true,
    },
    providers = {
        priority = { 'lsp', 'markdown', 'man' },
    },
    symbol_folding = {
        -- Expand/collapse chevrons are Nerd Font glyphs too; same as
        -- tagbar_iconchars' Windows fallback: ['+', '-'].
        markers = { '+', '-' },
    },
    symbols = {
        -- Whitelist: only these kinds show up (omit `exclude=true` -> whitelist
        -- mode). Add kinds here as needed, e.g. 'Constructor', 'Interface'.
        filter = {
            'Function',
            'Class',
            'Method',
            'StaticMethod',
            'Struct'
        },
        -- Nerd Font glyphs render as blank/tofu without a patched font;
        -- use plain ASCII labels instead (same idea as tagbar_scopestrs).
        icons = {
            Class         = { icon = 'CLS', hl = 'Type' },
            Method        = { icon = 'M',  hl = 'Function' },
            StaticMethod  = { icon = 'M', hl = 'Function' },
            Function      = { icon = 'F',  hl = 'Function' },
            Variable      = { icon = 'VAR',   hl = 'Constant' },
            Constant      = { icon = 'CONST', hl = 'Constant' },
            String        = { icon = 'STR',   hl = 'String' },
            Number        = { icon = '#',     hl = 'Number' },
            Boolean       = { icon = 'BOOL',  hl = 'Boolean' },
            Array         = { icon = 'ARRAY',   hl = 'Constant' },
            File          = { icon = 'FILE',  hl = 'Identifier' },
            Module        = { icon = 'MOD',   hl = 'Include' },
            Namespace     = { icon = 'NS',    hl = 'Include' },
            Package       = { icon = 'PKG',   hl = 'Include' },
            Property      = { icon = 'PROP',  hl = 'Identifier' },
            Field         = { icon = 'FIELD', hl = 'Identifier' },
            Constructor   = { icon = 'CTOR',  hl = 'Special' },
            Enum          = { icon = 'ENUM',  hl = 'Type' },
            Interface     = { icon = 'IFACE', hl = 'Type' },
            Object        = { icon = 'OBJ',   hl = 'Type' },
            Key           = { icon = 'K',   hl = 'Type' },
            Null          = { icon = 'NULL',  hl = 'Type' },
            EnumMember    = { icon = 'EMEM',  hl = 'Identifier' },
            Struct        = { icon = 'STRU',hl = 'Structure' },
            Event         = { icon = 'EVENT', hl = 'Type' },
            Operator      = { icon = '+',     hl = 'Identifier' },
            TypeParameter = { icon = 'TYPE',  hl = 'Identifier' },
            Component     = { icon = 'COMP',  hl = 'Function' },
            Fragment      = { icon = 'FRAG',  hl = 'Constant' },
            TypeAlias     = { icon = 'Type',hl = 'Type' },
            Parameter     = { icon = 'PARAM', hl = 'Identifier' },
        },
    },
})

-- split_command's own "botright Nsplit" would hit an outline.nvim bug
-- (leaves a stray buffer -- see git history), so move+resize after open
-- instead. LspAttach re-triggers it for LSPs slow to attach (e.g. pylsp).
local function bottom_bar()
    if vim.bo.filetype == 'Outline' then
        vim.cmd('wincmd J | resize 10')
    end
end
vim.api.nvim_create_autocmd('BufWinEnter', { callback = bottom_bar })
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function()
        local outline = require('outline')
        if outline.is_open() then
            outline.close_outline()
            outline.open_outline({ focus_outline = false })
        end
    end,
})
