-- Resolve a concrete python interpreter for pyright using only filesystem lookups.
-- Without this pyright runs `python` through the pyenv shim several times at init,
-- which costs seconds before the server answers anything.
local function exe(path)
  return path and vim.fn.executable(path) == 1 and path or nil
end

local function poetry_python(root)
  local f = io.open(root .. "/pyproject.toml")
  if not f then
    return nil
  end
  local name
  for line in f:lines() do
    name = line:match('^name%s*=%s*"(.-)"')
    if name then
      break
    end
  end
  f:close()
  if not name then
    return nil
  end
  -- Mirrors poetry's EnvManager.generate_env_name
  local sanitized = name:lower():gsub('[ $`!*@"\\\r\n\t]', "_"):sub(1, 42)
  local digest = vim.fn.sha256(root):gsub("%x%x", function(h)
    return string.char(tonumber(h, 16))
  end)
  local hash = vim.base64.encode(digest):gsub("%+", "-"):gsub("/", "_"):sub(1, 8)
  local cache = vim.env.POETRY_VIRTUALENVS_PATH or (vim.env.HOME .. "/Library/Caches/pypoetry/virtualenvs")
  local envs = vim.fn.glob(cache .. "/" .. sanitized .. "-" .. hash .. "-py*", false, true)
  table.sort(envs)
  return envs[#envs] and exe(envs[#envs] .. "/bin/python")
end

local function pyenv_python(root)
  local pyenv_root = vim.env.PYENV_ROOT or (vim.env.HOME .. "/.pyenv")
  local version = vim.env.PYENV_VERSION
  if not version then
    local file = vim.fs.find(".python-version", { path = root, upward = true })[1] or (pyenv_root .. "/version")
    local lines = vim.fn.filereadable(file) == 1 and vim.fn.readfile(file, "", 1) or {}
    version = lines[1] and vim.trim(lines[1])
  end
  if not version or version == "" or version == "system" then
    return nil
  end
  -- Prefix versions like "3.12" resolve to the newest matching install
  local dirs = vim.fn.glob(pyenv_root .. "/versions/" .. version .. "*", false, true)
  table.sort(dirs)
  return dirs[#dirs] and exe(dirs[#dirs] .. "/bin/python")
end

local function resolve_python(root)
  root = root and vim.uv.fs_realpath(root)
  if not root then
    return nil
  end
  return exe(root .. "/.venv/bin/python")
    or exe(root .. "/venv/bin/python")
    or (vim.env.VIRTUAL_ENV and exe(vim.env.VIRTUAL_ENV .. "/bin/python"))
    or poetry_python(root)
    or pyenv_python(root)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          before_init = function(_, config)
            local python = resolve_python(config.root_dir)
            -- Mutate in place: client.settings shares this table
            if python and config.settings then
              config.settings.python = config.settings.python or {}
              config.settings.python.pythonPath = config.settings.python.pythonPath or python
            end
          end,
        },
        ruff_lsp = {},
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
}
