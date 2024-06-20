return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = false, -- Enable debugging
      model = "gpt-4",
      auto_insert_mode = true,
      context = "buffer", -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
      -- See Configuration section for rest
      --
      --
      --
      --
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
