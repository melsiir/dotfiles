
return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    default_component_configs = {
      git_status = {
        symbols = {
          added = "",
          deleted = "",
          modified = "",
          renamed = "➜",
          -- untracked = "★",
          untracked = "?",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        },
      }
    },
      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      }
      -- config = function ()
      --   require('neo-tree').setup {}
      -- end,

    }}
