vim.opt.sessionoptions = { 'buffers', 'folds', 'help', 'tabpages', 'winsize' }
local sessions_dir = vim.fs.joinpath(vim.fn.stdpath('data') .. '/sessions/')

local M = {}

function M.get_session_list()
    vim.system({ 'rmdir', '--ignore-fail-on-non-empty', sessions_dir, '/*' })
    return vim.iter(vim.fs.dir(sessions_dir))
        :filter(function(_, type)
            return type == 'directory'
        end)
        :map(function(name, _)
            return vim.fn.substitute(name, '__', '/', 'g')
        end)
        :totable()
end

local function get_session_file()
    local branch = vim.trim(vim.system({ 'git',  'branch', '--show-current' }):wait().stdout)
    local session_subdir = vim.fs.joinpath(sessions_dir, vim.fn.substitute(vim.fn.getcwd(), '/', '__', 'g'))
    local session_file = vim.fs.joinpath(session_subdir .. '/', branch == '' and '__norepo__' or branch)
    return session_file
end

local function create_session()
    vim.cmd.mksession { get_session_file(), bang = true }
    vim.notify('Session created')
end

local function delete_session()
    vim.fs.rm(get_session_file(), { force = true })
    vim.notify('Session deleted')
end

local function save_session()
    if vim.uv.fs_stat(get_session_file()) then
        vim.cmd.mksession { get_session_file(), bang = true }
        vim.notify('Session saved')
    end
end

local function load_session()
    local session_file = get_session_file()
    if vim.uv.fs_stat(session_file) then
        vim.cmd.source { session_file }
        vim.notify('Session loaded')
    end

    local timer = vim.uv.new_timer()
    local timeout = 1800000   -- 30 mins
    if timer then
        timer:start(timeout, timeout, save_session)
    end
end

vim.api.nvim_create_augroup('Sessions', { clear = true });
vim.api.nvim_create_autocmd('VimEnter', {
    group = 'Sessions',
    pattern = '*',
    callback = function()
        if vim.env.VIM_NO_SESSION_LOAD == '1' then
            return
        end
        load_session()
    end,
    nested = true,
})
vim.api.nvim_create_autocmd('VimLeave', {
    group = 'Sessions',
    pattern = '*',
    callback = function()
        if vim.env.VIM_NO_SESSION_LOAD == '1' then
            return
        end
        save_session()
    end,
})

vim.keymap.set('n', '<Leader>sm', create_session)
vim.keymap.set('n', '<Leader>sd', delete_session)


return M
