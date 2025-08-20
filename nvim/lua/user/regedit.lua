local function regedit()
    local reg = vim.fn.nr2char(vim.fn.getchar() --[[@as integer]])
    vim.ui.input({
        prompt = 'Edit register ' .. reg,
        default = vim.fn.getreg(reg)
    }, function (input)
        if input == nil then return end
        vim.fn.setreg(reg, input)
    end)
end

vim.keymap.set('n', '<Leader>"', regedit)
