vim.filetype.add({
    extension = {
        gitconfig = 'gitconfig',
    },
    pattern = {
        ['.*/git/config'] = 'gitconfig',
        ['zprofile'] = 'zsh',
        ['.*/zsh/functions/.*'] = 'zsh',
    }
})

vim.api.nvim_create_augroup('filetypeplugin', { clear = false })
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'gitcommit', 'gitrebase', 'edit-cmdline', 'man', 'oil' },
    callback = function()
        vim.env.VIM_NO_SESSION_LOAD = '1'
    end
})
