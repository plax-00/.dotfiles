vim.treesitter.start()
vim.cmd.wincmd("T")
vim.keymap.set("n", "q", vim.cmd.bdelete, { buffer = true })
