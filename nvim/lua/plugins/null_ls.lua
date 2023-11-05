return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("none-ls")
      return {
        root_dir = require("none-ls.utils").root_pattern(".none-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.black,
          -- nls.builtins.diagnostics.mypy,

          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
}
