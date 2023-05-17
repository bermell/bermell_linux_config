-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
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

map("i", "<C-f>", "", {
  callback = function()
    require("copilot.suggestion").accept()
  end,
  desc = "accept copilot suggestion",
})

-- map <leader>cb to running black in the current buffers
map("n", "<leader>cb", ":!black %<CR>", { silent = true })

-- <C-e> closes the popup menu for auto completion
