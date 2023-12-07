-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.python3_host_prog = "/usr/bin/python3"
require("config.lazy")
vim.o.scrolloff = 10

vim.wo.number = true
vim.wo.relativenumber = false
