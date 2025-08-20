-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ' '

-- Sessions
vim.g.sessions_enabled = #vim.fn.argv() == 0  -- no file args
    and vim.env.VIM_NO_SESSION_LOAD ~= '1'    -- no env variable
    and vim.v.argv[3] ~= '+Man!'              -- no manpage
require('user.sessions')

-- Load settings and mappings
local config_dir = vim.fn.stdpath('config')
vim.cmd.source(config_dir .. '/settings.vim')
vim.cmd.source(config_dir .. '/mappings.vim')

-- Setup plugins
require('lazy').setup('user.plugins')

-- Neovide settings
if vim.g.neovide then
    require('user.neovide')
end

require('user.regedit')
