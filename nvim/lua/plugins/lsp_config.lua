return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                -- configurationSources = { "pycodestyle", "mccabe", "mypy", "ruff", "black", "isort", "rope_autoimport" },
                jedi_completion = {
                  enabled = true,
                  eager = true,
                  cache_for = { "numpy", "scipy", "matplotlib" },
                },
                jedi_definition = {
                  enabled = true,
                  follow_imports = true,
                  follow_builtin_imports = true,
                },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true, all_scopes = true, include_import_symbols = true },
                preload = { enabled = true, modules = { "numpy", "scipy", "matplotlib" } },
                isort = { enabled = true },
                black = { enabled = true },
                pylsp_black = { enabled = true },
                spyder = { enabled = false },
                mccabe = { enabled = false },
                ruff = { enabled = false },
                mypy = { enabled = true },
                rope_autoimport = { enabled = true },
                flake8 = { enabled = false, maxLineLength = 120 },
                yapf = { enabled = false },
                autopep8 = { enabled = false },
                pycodestyle = { enabled = false, ignore = { "E501" } },
                pyflakes = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
}
