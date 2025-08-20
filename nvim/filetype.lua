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

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = 'kitty.conf',
    callback = function()
        vim.system({'killall', '-SIGUSR1', 'kitty'}):wait()
    end
})
