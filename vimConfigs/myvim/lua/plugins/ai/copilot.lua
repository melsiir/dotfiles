local generalCopilot = {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = false,
    enabled = false,
    build = ":Copilot auth",
    opts = {
      suggestion = {
        -- disable for copilot-cmp
        enabled = false,
        -- auto_trigger = true,
        keymap = {
          -- accept = false, -- handled by nvim-cmp / blink.cmp
          accept = "<c-l>",
          -- When auto_trigger is false, use the next or prev keymap to trigger copilot suggestion
          next = "<c-j>",
          prev = "<c-k>",
          dismiss = "<c-h>",
        },
      },
      panel = {
        enabled = false,
        keymap = {
          jump_next = "<c-j>",
          jump_prev = "<c-k>",
          accept = "<c-l>",
          refresh = "r",
          open = "<c-CR>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    keys = {
      {
        "<leader>ua",
        function()
          require("copilot.suggestion").toggle_auto_trigger()
        end,
        desc = "toggle copilot auto_trigger"
      }
    }
  },

  {
    "AndreM222/copilot-lualine",
    enabled = false, -- Disabled since copilot.lua is also disabled
  },
}

if vim.g.blinkcmp then
  return {
    generalCopilot,
    -- Only add lualine integration if main copilot plugin is enabled
    generalCopilot[1].enabled and {
      "nvim-lualine/lualine.nvim",
      optional = true,
      event = "VeryLazy",
      opts = function(_, opts)
        table.insert(
          opts.sections.lualine_x, 2,
          { "copilot" }
        )
      end,
    } or nil,
    {
      "saghen/blink.cmp",
      optional = true,
      dependencies = { "giuxtaposition/blink-cmp-copilot" },
      opts = {
        sources = {
          default = { "copilot" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-cmp-copilot",
              kind = "Copilot",
              score_offset = 100,
              async = true,
            },
          },
        },
      },
    },
  }
else
  return {
    generalCopilot,
    -- Only add lualine integration if main copilot plugin is enabled
    generalCopilot[1].enabled and {
      "nvim-lualine/lualine.nvim",
      optional = true,
      event = "VeryLazy",
      opts = function(_, opts)
        table.insert(
          opts.sections.lualine_x, 2,
          { "copilot" }
        )
      end,
    } or nil,
    {
      "zbirenbaum/copilot-cmp",
      opts = {},
      config = function(_, opts)
        require("copilot_cmp").setup(opts)
      end,
    },
    {
      -- "iguanacucumber/magazine.nvim",
      "nvim-cmp",
      optional = true,
      opts = function(_, opts)
        -- if you wish to use autocomplete
        table.insert(opts.sources, 1, {
          name = 'copilot',
          group_index = 2,
          -- priority = 100,
        })
      end
    },

  }
end
