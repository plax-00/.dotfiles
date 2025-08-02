local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local themes = require('telescope.themes')

local function pick_session()
    local opts = themes.get_dropdown()
    pickers.new(opts, {
        prompt_title = 'Sessions',
        finder = finders.new_table {
            results = require('user.sessions').get_session_list()
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()[1]

                vim.fn.SaveSessionCWD()
                vim.cmd [[ %bdelete ]]
                vim.cmd.cd(selection)
                vim.fn.LoadSessionCWD()
            end)
            return true
        end
    }):find()
end

return pick_session
