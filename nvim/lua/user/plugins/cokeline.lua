return {
    'willothy/nvim-cokeline',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        buffers = {
            new_buffers_position = 'next',
        },
        pick = {
            use_filename = false,
        },
        default_hl = {},
        sidebar = {
            filetype = { 'NvimTree' },
            components = {
                {
                    text = '   File Explorer   ',
                    bold = true,
                },
            },
        },
        tabs = {
            placement = 'right',
            components = {
                {
                    text = function(tabpage)
                        return tabpage.is_first and '' or ''
                    end,
                },
                {
                    text = function(tabpage)
                        return tabpage.index
                    end,
                },
                {
                    text = function(tabpage)
                        return (tabpage.is_first and tabpage.is_last) and ''
                        or tabpage.is_last and ''
                        or ' | '
                    end,
                },
                {
                    text = function(tabpage)
                        return tabpage.is_last and '' or ''
                    end,
                },
            },
        },
        components = {
            { text = '' },
            { text = 'icon/pick' },
            {
                text = function(buffer) return buffer.unique_prefix end,
                italic = true,
            },
            {
                text = function(buffer) return buffer.filename end,
                bold = function(buffer) return buffer.is_focused end,
            },
            { text = ' ' },
            {
                text = function(buffer) return buffer.is_modified and '' or ' ' end,
            },
            { text = '' },
        },
    },
    config = function(_, opts)
        local get_hex = require('cokeline.hlgroups').get_hl_attr
        local is_picking_focus = require('cokeline.mappings').is_picking_focus
        local is_picking_close = require('cokeline.mappings').is_picking_close

        local red = get_hex('DiagnosticError', 'fg')
        local yellow = get_hex('DiagnosticWarn', 'fg')
        local blue = vim.g.terminal_color_4
        local normal_fg = get_hex('Normal', 'fg')
        local normal_bg = get_hex('Normal', 'bg')
        local comment_fg = get_hex('Comment', 'fg')

        local function get_tab_color(buffer)
            return buffer.is_focused and normal_bg
            or 'black'
        end

        opts.default_hl.fg = function(buffer)
            return buffer.diagnostics.errors > 0 and red
            or buffer.diagnostics.warnings > 0 and yellow
            or buffer.is_focused and normal_fg
            or comment_fg
        end
        opts.default_hl.bg = get_tab_color

        -- NvimTree header
        opts.sidebar.components[1].bg = get_tab_color({ is_focused = false, diagnostics = {} })

        -- tabpage text
        opts.tabs.components[2].fg = function(tabpage)
            return tabpage.is_active and blue
            or comment_fg
        end
        -- tab separator
        opts.tabs.components[3].fg = comment_fg


        -- 
        opts.components[1].fg = get_tab_color
        opts.components[1].bg = normal_bg
        opts.tabs.components[1].fg = get_tab_color
        opts.tabs.components[1].bg = normal_bg

        -- icon/pick
        opts.components[2].text = function(buffer)
            local pick_letter = ' ' .. buffer.pick_letter .. ' '
            local icon = ' ' .. buffer.devicon.icon
            return (is_picking_focus() or is_picking_close()) and pick_letter
            or icon
        end
        opts.components[2].fg = function (buffer)
            return (is_picking_focus() and yellow)
            or (is_picking_close() and red)
            or buffer.devicon.color
        end

        -- dir prefix
        opts.components[3].fg = comment_fg

        -- 
        opts.components[7].fg = get_tab_color
        opts.components[7].bg = normal_bg
        opts.tabs.components[4].fg = get_tab_color
        opts.tabs.components[4].bg = normal_bg


        vim.api.nvim_set_hl(0, 'TabLineFill', { fg = normal_bg })
        vim.cmd [[
            nnoremap    <Leader>v    <Plug>(cokeline-pick-focus)
            nnoremap    <Leader>c    <Plug>(cokeline-pick-close)
            nmap        <Leader>n    <Plug>(cokeline-focus-next)<Leader>\buffer
            nmap        <Leader>N    <Plug>(cokeline-focus-prev)<Leader>\buffer
        ]]

        require('cokeline').setup(opts)
    end,
}
