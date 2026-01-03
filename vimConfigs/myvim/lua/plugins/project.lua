return {
  -- project management
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("projects")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>fp", pick, desc = "Projects" },
    },
  },

  -- {
  --   "folke/snacks.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     table.insert(opts.dashboard.preset.keys, 3, {
  --       action = pick,
  --       desc = "Projects (util.project)",
  --       icon = " ",
  --       key = "P",
  --     })
  --   end,
  -- },
}

-- return {
--   "DrKJeff16/project.nvim",
--   dependencies = { -- OPTIONAL
--     "nvim-lua/plenary.nvim",
--     -- "nvim-telescope/telescope.nvim",
--     "ibhagwan/fzf-lua",
--   },
--   opts = {
--     fzf_lua = { enabled = true },
--   },
-- }
