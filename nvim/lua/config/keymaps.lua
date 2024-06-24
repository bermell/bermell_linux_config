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
wk.register({ C = { name = "Copilot" } }, { prefix = "<leader>", mode = "n", silent = true, noremap = true })

vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot-next)", { silent = true })
vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot-previous)", { silent = true })
vim.api.nvim_set_keymap("i", "<M-d>", "<Plug>(copilot-dismiss)", { silent = true })
map("i", "<M-f>", 'copilot#Accept("")', { expr = true, silent = true })
map("n", "<leader>Cp", ":Copilot panel<CR>", { silent = true, desc = "Copilot panel" })

-- LazyDocker keymap
map("n", "<leader>D", ":LazyDocker<CR>", { silent = true })

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
