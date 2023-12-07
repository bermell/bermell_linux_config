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
map("n", "<leader>D", ":DockerToolsToggle<CR>", { silent = true })
-- vim.api.nvim_set_keymap("i", "<C-f>", "v:lua.copilot_accept()", { expr = true, silent = true })
-- vim.g.copilot_no_tab_map = true

-- <C-e> closes the popup menu for auto completion

-- Octo keymaps
map("n", "<leader>op", ":Octo pr list<CR>", { silent = true, desc = "List repo PRs" })

-- opens a new tab with the diff of the PR
map("n", "<leader>od", ":Octo pr diff<CR>", { silent = true, desc = "Diff PR" })
-- reformats the diff message with diff-so-fancy

local function BaleiaColorize()
  -- format with Ansi color codes (to get diff-so-fancy to work)
  local baleia = require("baleia").setup({})
  baleia.once(vim.api.nvim_get_current_buf())
end
vim.api.nvim_create_user_command("BaleiaColorize", BaleiaColorize, {})

map("n", "<leader>of", ":%!diff-so-fancy<CR>:BaleiaColorize<CR>", { silent = true, desc = "Fancy format diff" })

-- HAPOON nvim
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():append()
end, { silent = true, desc = "Add harpoon bookmark" })
-- show the harpoon list of shortcuts. from here you can open them and remove them (need to save to take effect).
vim.keymap.set("n", "<C-a>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { silent = true, desc = "Show harpoon list" })
-- jump to first harpoon bookmark, etc.
vim.keymap.set("n", "<C-n>", function()
  harpoon:list():select(1)
end, { silent = true, desc = "harpoon bookmark 1" })
vim.keymap.set("n", "<C-e>", function()
  harpoon:list():select(2)
end, { silent = true, desc = "harpoon bookmark 2" })
vim.keymap.set("n", "<C-i>", function()
  harpoon:list():select(3)
end, { silent = true, desc = "harpoon bookmark 3" })
vim.keymap.set("n", "<C-h>", function()
  harpoon:list():select(4)
end, { silent = true, desc = "harpoon bookmark 4" })
