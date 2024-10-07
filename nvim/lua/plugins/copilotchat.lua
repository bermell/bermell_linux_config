return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },

    keys = {
      { "<leader>Cc", ":CopilotChatToggle<CR>", desc = "Toggle CopilotChat" },
      { "<leader>CC", ":CopilotChatToggle<CR>", desc = "Toggle CopilotChat" },
      { "<leader>Co", ":CopilotChatOptimize<CR>", mode = "x", desc = "Optimize selection" },
      { "<leader>Cr", ":CopilotChatReview<CR>", mode = "x", desc = "Review selection" }, -- visual mode
      { "<leader>Cr", ":CopilotChatReview<CR>", desc = "Review selection" }, -- normal mode
    },
    opts = {
      debug = false, -- Enable debugging
      model = "gpt-4",
      auto_insert_mode = false,
      context = "buffers", -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
    },
  },
}
