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

-- Load settings and mappings
local config_dir = vim.fn.stdpath('config')
vim.cmd.source(config_dir .. '/settings.link.vim')
vim.cmd.source(config_dir .. '/sessions.link.vim')
vim.cmd.source(config_dir .. '/mappings.link.vim')
vim.cmd.source(config_dir .. '/mappings.vim')
-- vim.cmd([[
--     source ~/.config/vim/settings.vim
--     source ~/.config/vim/sessions.vim
--     execute 'source' stdpath('config') .. '/mappings.link.vim'
--     source ~/.config/nvim/mappings.vim
-- ]])

-- Setup plugins
require('lazy').setup('user.plugins')

-- transparent bg
vim.cmd([[
    highlight Normal ctermbg=NONE
    highlight LineNr ctermbg=NONE
    highlight EndOfBuffer ctermbg=NONE
]])

