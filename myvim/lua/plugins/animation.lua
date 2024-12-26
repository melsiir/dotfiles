return {
  {
    "echasnovski/mini.animate",
    enabled = true,
    config = function()
      require('mini.animate').setup({
        cursor = {
          -- Whether to enable this animation
          enable = false,
        },
        scroll = {
          enable = true,
        },
        resize = {
          enable = true,
        },
        open = {
          -- Animate for 400 milliseconds with linear easing
          timing = require("mini.animate").gen_timing.linear({ duration = 400, unit = 'total' }),

          -- Animate with wiping from nearest edge instead of default static one
          winconfig = require("mini.animate").gen_winconfig.wipe({ direction = 'from_edge' }),

          -- Make bigger windows more transparent
          winblend = require("mini.animate").gen_winblend.linear({ from = 80, to = 100 }),
        },

        close = {
          -- Animate for 400 milliseconds with linear easing
          timing = require("mini.animate").gen_timing.linear({ duration = 400, unit = 'total' }),

          -- Animate with wiping to nearest edge instead of default static one
          winconfig = require("mini.animate").gen_winconfig.wipe({ direction = 'to_edge' }),

          -- Make bigger windows more transparent
          winblend = require("mini.animate").gen_winblend.linear({ from = 100, to = 80 }),
        },

      })
    end
  },
  {
    "sphamba/smear-cursor.nvim",
    enabled = true,
    opts = {
      filetypes_disabled = { "markdown" },
      stiffness = 0.8,          -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.3      [0, 1]
      -- distance_stop_animating = 0.5, -- 0.1      &gt; 0
      -- hide_target_hack = false,      -- true     boolean
      transparent_bg_fallback_color = "#303030",
      -- legacy_computing_symbols_support = true,
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = false,
      -- Smear cursor when moving within line or to neighbor lines.
      -- smear_between_neighbor_lines = false,


    },
  },
}
