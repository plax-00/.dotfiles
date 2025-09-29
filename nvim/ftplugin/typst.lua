vim.cmd [[
    setlocal wrap
    setlocal linebreak
    setlocal spell
    nnoremap j gj
    nnoremap k gk
    nnoremap A g$a
    nnoremap I g^i
    nnoremap <Leader>a g$
    nnoremap <Leader>i g^
]]

local fname = vim.fn.expand('%:p')

if fname ~= vim.fn.fnamemodify(vim.fn.argv(0), ':p') then
    return
end

local proc = vim.system({'typst', 'watch', vim.fn.expand('%')})
vim.api.nvim_create_autocmd('VimLeavePre', {
   callback = function()
       vim.uv.kill(proc.pid)
   end,
   once = true,
})
