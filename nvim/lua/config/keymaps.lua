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

local wk = require("which-key")

map("n", "<leader>gF", ":Telescope git_file_history<CR>", { silent = true })
map("n", "<leader>bn", ":enew<CR>", { silent = true })

-- Copilot and CopilotChat keymaps
wk.add({
  { "<leader>C", group = "Copilot", remap = false },
})

vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot-next)", { silent = true })
vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot-previous)", { silent = true })
vim.api.nvim_set_keymap("i", "<M-d>", "<Plug>(copilot-dismiss)", { silent = true })
map("i", "<M-f>", 'copilot#Accept("")', { expr = true, silent = true })
map("n", "<leader>Cp", ":Copilot panel<CR>", { silent = true, desc = "Copilot panel" })

-- LazyDocker keymap
map("n", "<leader>D", ":LazyDocker<CR>", { silent = true })

-- remove buffer with ctrl-q
vim.api.nvim_set_keymap("n", "<C-q>", " bd<CR>", { silent = true })
