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

map("n", "<leader>gF", ":Telescope git_file_history<CR>", { silent = true })
map("n", "<leader>bn", ":enew<CR>", { silent = true })

-- Copilot keymaps
--
vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot-next)", { silent = true })
vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot-previous)", { silent = true })
vim.api.nvim_set_keymap("i", "<M-d>", "<Plug>(copilot-dismiss)", { silent = true })
-- vim.api.nvim_set_keymap("i", "<C-f>", "<Plug>(copilot-accept)", { silent = true, noremap = false })
map("i", "<M-f>", 'copilot#Accept("")', { expr = true, silent = true })
map("n", "<leader>cp", ":Copilot panel<CR>", { silent = true })
map("n", "<leader>D", ":LazyDocker<CR>", { silent = true })

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

if vim.g.neovide == true then
  -- vim.cmd 'set guifont=Hack\ NF:h10'
  -- vim.o.guifont='Consolas:h10'
  -- vim.o.guifont='FiraCode NF:h14'
  -- vim.o.guifont = "Operator Mono,FiraCode NF:h14"
  vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})

  -- these are also set in neovide config file...
  vim.g.gui_font_default_size = 12
  vim.g.gui_font_size = vim.g.gui_font_default_size
  vim.g.gui_font_face = "Hack Nerd Font"
  RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
  end

  ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
  end

  ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
  end

  -- Call function on startup to set default value
  ResetGuiFont()

  -- Keymaps

  local opts = { noremap = true, silent = true }

  vim.keymap.set({ "n", "i" }, "<C-+>", function()
    ResizeGuiFont(1)
  end, opts)
  vim.keymap.set({ "n", "i" }, "<C-->", function()
    ResizeGuiFont(-1)
  end, opts)
end
