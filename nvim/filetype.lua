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
