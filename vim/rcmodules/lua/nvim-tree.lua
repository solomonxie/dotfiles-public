-- Setup for rcmodules/nvim-tree.vim. Must run after plug#end() (nvim_lua_configs
-- loop in nvimrc.vim), not inline in the Plug block -- vim-plug only adds a
-- plugin's lua/ dir to package.path once plug#end() finishes, so require()
-- here would fail if called any earlier.

require("nvim-tree").setup({
    disable_netrw = false,
    hijack_netrw = false,
    sort = { sorter = "name", folders_first = true },
    view = {
        width = 40,
        side = "left",
    },
    renderer = {
        root_folder_label = false,
        highlight_git = false,
        indent_markers = { enable = false },
        indent_width = 2,
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = true,
                git = false,
                modified = false,
            },
            glyphs = {
                folder = {
                    arrow_closed = "▸",
                    arrow_open = "▾",
                },
            },
        },
    },
    filters = {
        dotfiles = true,  -- Mirrors NERDTreeHidden=1
        custom = { "^\\.git$", "__pycache__", "\\.pyc$", "node_modules" },
    },
    git = { enable = false },
    diagnostics = { enable = false },
    actions = {
        open_file = {
            quit_on_open = true,  -- Mirrors NERDTreeQuitOnOpen
            window_picker = { enable = false },
        },
    },
})
