local md_config = vim.fn.expand("~/.markdownlint-cli2.jsonc")

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local cli2 = require("lint").linters["markdownlint-cli2"]
      cli2.args = { "--config", md_config, "-" }
      return opts
    end,
  },
}
