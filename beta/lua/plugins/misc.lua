return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim",    lazy = true },
  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,              desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "2kabhishek/nerdy.nvim",
    event = "VeryLazy",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
  -- disables hungry features for files larget than 2MB
  -- { "LunarVim/bigfile.nvim" },
  -- {
  --   "Dan7h3x/neaterm.nvim",
  --   branch = "stable",
  --   event = "VeryLazy",
  --   opts = {
  --     -- Your custom options here (optional)
  --     keymaps = {
  --       new_horizontal = '<C-_>',
  --     },
  --
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "ibhagwan/fzf-lua",
  --   },
  -- },
  -- {
  --   "rachartier/tiny-inline-diagnostic.nvim",
  --   event = "VeryLazy", -- Or `LspAttach`
  --   priority = 1000,    -- needs to be loaded in first
  --   config = function()
  --     require('tiny-inline-diagnostic').setup()
  --   end
  -- },
  {
    "watzon/goshot.nvim",
    cmd = "Goshot",
    opts = {
      binary = "goshot",   -- Path to goshot binary (default: "goshot")
      auto_install = true, -- Automatically install goshot if not found (default: false)
    },
    keys = {
      { "<leader>bS", "<cmd>Goshot<cr>",      mode = { "n" }, desc = "Take screenshot" },
      { "<leader>bS", "<cmd>'<,'>Goshot<cr>", mode = { "v" }, desc = "Take screenshot of selection" },
    },
  },
  {
    "hat0uma/csvview.nvim",
    opts = {
      view = {
        display_mode = "border",
      },
    },

    ft = { "csv" },
  },
  -- { "github/copilot.vim" }
  { 'AndreM222/copilot-lualine' },
  -- {
  -- },
  -- "mikavilpas/blink-ripgrep.nvim"
}
