return {
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   enabled = false,
  --   main = "ibl",
  --   ---@module "ibl"
  --   ---@type ibl.config
  --   opts = {},
  --   config = function()
  --     local highlight = {
  --       "RainbowRed",
  --       "RainbowYellow",
  --       "RainbowBlue",
  --       "RainbowOrange",
  --       "RainbowGreen",
  --       "RainbowViolet",
  --       "RainbowCyan"
  --     }
  --
  --     local hooks = require("ibl.hooks")
  --     -- create the highlight groups in the highlight setup hook, so they are reset
  --     -- every time the colorscheme changes
  --     hooks.register(
  --       hooks.type.HIGHLIGHT_SETUP,
  --       function()
  --         vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  --         vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --         vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --         vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --         vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --         vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --         vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  --       end
  --     )
  --
  --     require("ibl").setup({ indent = { highlight = highlight } })
  --   end
  --
  -- },
  -- {
  --   "shellRaining/hlchunk.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     require("hlchunk").setup({
  --       chunk = {
  --         enable = true,
  --         notify = true,
  --         chars = { right_arrow = "─" }
  --       },
  --       indent = {
  --         enable = true
  --       },
  --       --  line_num = {
  --       --    enable = true
  --       --  },
  --       -- blank = {
  --       --    enable = true
  --       --  }
  --     })
  --   end
  -- },
  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    "nvim-mini/mini.indentscope",
    event = "VeryLazy",
    enabled = false,
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "lazyterm",
          "mason",
          "neo-tree",
          "notify",
          "toggleterm",
          "Trouble",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

}
