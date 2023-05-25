-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99

-- turn off closing brackets
vim.opt.autoindent = false

-- local lspconfig = require("lspconfig")
-- lspconfig.pylsp.setup({
--   on_attach = on_attach,
--   settings = {
--     pylsp = {
--       plugins = {
--         pyls_black = { enabled = true },
--         isort = { enabled = true, profile = "black" },
--       },
--     },
--   },
-- })
