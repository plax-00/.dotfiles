-- vim.api.nvim_create_augroup('Sessions', { clear = true });
--
-- vim.api.nvim_create_autocmd('VimEnter', {
--     group = 'Sessions',
--     pattern = '*',
-- })
-- vim.api.nvim_create_autocmd('VimLeave', {
--     group = 'Sessions',
--     pattern = '*',
-- })

-- local sessions_dir = vim.fn.stdpath('data') .. '/sessions/'
local sessions_dir = vim.fs.joinpath(vim.fn.stdpath('data') .. '/sessions/')

local substitute = vim.fn.substitute

local function get_session_list()
    vim.system({ 'rmdir', '--ignore-fail-on-non-empty', sessions_dir, '/*' })
    return vim.iter(vim.fs.dir(sessions_dir))
        :filter(function(_, type)
            return type == 'directory'
        end)
        :map(function(name, _)
            return substitute(name, '__', '/', 'g')
        end)
        :totable()
end

local function get_session_file()
    local branch = vim.trim(vim.system({ 'git',  'branch', '--show-current' }):wait().stdout)
    local session_subdir = vim.fs.joinpath(sessions_dir, substitute(vim.fn.getcwd(), '/', '__', 'g') )
    local session_file = vim.fs.joinpath(session_subdir .. '/', branch)
    return session_file
end

local M = {
    get_session_list = get_session_list,
    get_session_file = get_session_file,
}

return M
