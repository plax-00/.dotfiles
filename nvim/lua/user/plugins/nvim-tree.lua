return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    opts = {
        view = {
            adaptive_size = true,
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
            highlight_opened_files = 'name',
            indent_markers = {
                enable = false,
            },
            root_folder_label = false,
        },
        git = {
            enable = false,
        },
        hijack_unnamed_buffer_when_opening = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
    },
}
