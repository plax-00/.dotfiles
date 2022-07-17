require('nvim-tree').setup {
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                {key = 'O', action = 'cd'},
            },
        },
        hide_root_folder = true,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    filters = {
        dotfiles = true,
    },
    renderer = {
        group_empty = true,
        indent_markers = {
            enable = false,
        }
    },
    git = {
        enable = false,
    },
    hijack_unnamed_buffer_when_opening = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
}

