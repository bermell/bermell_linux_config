-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.python3_host_prog = "/usr/bin/python3"
require("config.lazy")
vim.o.scrolloff = 10

-- HAPOON nvim
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():append()
end)
-- show the harpoon list of shortcuts. from here you can open them and remove them (need to save to take effect).
vim.keymap.set("n", "<C-a>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- jump to first harpoon bookmark, etc.
vim.keymap.set("n", "<C-n>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-i>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-o>", function()
  harpoon:list():select(4)
end)
