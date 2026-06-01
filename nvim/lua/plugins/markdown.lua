local md_config = vim.fn.expand("~/.markdownlint.jsonc")

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier", "markdownlint-cli2" },
      },
      formatters = {
        ["markdownlint-cli2"] = {
          command = "markdownlint-cli2",
          args = { "--fix", "--config", md_config, "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", md_config, "--" },
        },
      },
    },
  },
}
