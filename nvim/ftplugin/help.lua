vim.treesitter.start()
vim.cmd [[ silent wincmd T ]]
vim.keymap.set("n", "q", vim.cmd.bdelete, { buffer = true })
