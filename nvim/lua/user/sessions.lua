vim.opt.sessionoptions = { 'buffers', 'curdir', 'folds', 'help', 'tabpages', 'winsize' }
local sessions_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'sessions')
vim.fn.mkdir(sessions_dir, 'p')

local function session_subdir()
    return vim.fs.joinpath(
        sessions_dir,
        vim.fn.substitute(vim.fn.getcwd(), '/', '__', 'g')
    )
end

local M = {}

function M.get_session_list()
    vim.fn.system('rmdir --ignore-fail-on-non-empty ' .. sessions_dir .. '/*' )
    return vim.iter(vim.fs.dir(sessions_dir))
        :filter(function(_, type)
            return type == 'directory'
        end)
        :map(function(name, _)
            return vim.fn.substitute(name, '__', '/', 'g')
        end)
        :totable()
end

function M.get_session_file()
    local branch = vim.trim(
        vim.fn.system('git branch --show-current 2> /dev/null')
    )
    local session_file = vim.fs.joinpath(
        session_subdir(),
        branch == '' and '__norepo__' or branch
    )
    return session_file
end

local function create_session()
    vim.fn.mkdir(session_subdir(), 'p')
    vim.cmd.mksession { M.get_session_file(), bang = true }
    vim.notify('Session created')
end

local function delete_session()
    vim.fs.rm(M.get_session_file(), { force = true })
    vim.notify('Session deleted')
end

function M.save_session()
    if not vim.g.sessions_enabled then return end

    if vim.uv.fs_stat(M.get_session_file()) then
        vim.cmd.mksession { M.get_session_file(), bang = true }
        vim.notify('Session saved')
    end
end

function M.load_session()
    if not vim.g.sessions_enabled then return end

    local session_file = M.get_session_file()
    if vim.uv.fs_stat(session_file) then
        vim.cmd.source { session_file }
        vim.notify('Session loaded')

    end

    local timer = vim.uv.new_timer()
    local timeout = 1800000   -- 30 mins
    if timer then
        timer:start(timeout, timeout, vim.schedule_wrap(M.save_session))
    end
end

vim.api.nvim_create_augroup('Sessions', { clear = true });
vim.api.nvim_create_autocmd('VimEnter', {
    group = 'Sessions',
    pattern = '*',
    callback = M.load_session,
    nested = true,
})
vim.api.nvim_create_autocmd('VimLeave', {
    group = 'Sessions',
    pattern = '*',
    callback = M.save_session,
})

vim.keymap.set('n', '<Leader>sm', create_session)
vim.keymap.set('n', '<Leader>sd', delete_session)


return M
