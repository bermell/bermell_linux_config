-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("i", "<A-h>", "<C-o>h", { silent = true })
map("i", "<A-j>", "<C-o>j", { silent = true })
map("i", "<A-k>", "<C-o>k", { silent = true })
map("i", "<A-l>", "<C-o>l", { silent = true })

-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- vim.g.copilot_no_tab_map = true

-- map("i", "<C-f>", "", {
--   callback = function()
--     require("copilot.suggestion").accept()
--   end,
--   desc = "accept copilot suggestion",
-- })
vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot-next)", { silent = true })
vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot-previous)", { silent = true })
vim.api.nvim_set_keymap("i", "<M-d>", "<Plug>(copilot-dismiss)", { silent = true })
-- vim.api.nvim_set_keymap("i", "<C-f>", "<Plug>(copilot-accept)", { silent = true, noremap = false })
map("i", "<M-f>", 'copilot#Accept("")', { expr = true, silent = true })
map("n", "<leader>cp", ":Copilot panel<CR>", { silent = true })
-- vim.api.nvim_set_keymap("i", "<C-f>", "v:lua.copilot_accept()", { expr = true, silent = true })
-- vim.g.copilot_no_tab_map = true

-- map <leader>cb to running black in the current buffers
map("n", "<leader>cb", ":!black %<CR>", { silent = true })

-- <C-e> closes the popup menu for auto completion
