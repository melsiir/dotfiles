local generalCopilot = {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    lazy = false,
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
  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_x, 2,
        { "copilot" }
      )
    end,
  }

}

if vim.g.blinkcmp then
  return {
    generalCopilot,
    -- {
    --   -- enabled = false,
    --   "saghen/blink.cmp",
    --   optional = true,
    --   dependencies = {
    --     "giuxtaposition/blink-cmp-copilot",
    --   }
    -- },

  } or {
    generalCopilot,
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

-- local lspUtil = require("config.util.lsp")
-- vim.g.ai_cmp = true
-- return {
--   -- copilot
--   {
--     "zbirenbaum/copilot.lua",
--     cmd = "Copilot",
--     build = ":Copilot auth",
--     event = "InsertEnter",
--     opts = {
--       suggestion = {
--         enabled = not vim.g.ai_cmp,
--         auto_trigger = true,
--         keymap = {
--           accept = false, -- handled by nvim-cmp / blink.cmp
--           next = "<M-]>",
--           prev = "<M-[>",
--         },
--       },
--       panel = { enabled = false },
--       filetypes = {
--         markdown = true,
--         help = true,
--       },
--     },
--   },
--
--   -- add ai_accept action
--   {
--     "zbirenbaum/copilot.lua",
--     opts = function()
--       LazyVim.cmp.actions.ai_accept = function()
--         if require("copilot.suggestion").is_visible() then
--           LazyVim.create_undo()
--           require("copilot.suggestion").accept()
--           return true
--         end
--       end
--     end,
--   },
--
--   -- lualine
--   {
--     "nvim-lualine/lualine.nvim",
--     optional = true,
--     event = "VeryLazy",
--     opts = function(_, opts)
--       table.insert(
--         opts.sections.lualine_x,
--         2,
--         LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
--           local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
--           if #clients > 0 then
--             local status = require("copilot.api").status.data.status
--             return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
--           end
--         end)
--       )
--     end,
--   },
--
--   vim.g.ai_cmp
--   and {
--     -- copilot cmp source
--     {
--       "hrsh7th/nvim-cmp",
--       optional = true,
--       dependencies = { -- this will only be evaluated if nvim-cmp is enabled
--         {
--           "zbirenbaum/copilot-cmp",
--           opts = {},
--           config = function(_, opts)
--             local copilot_cmp = require("copilot_cmp")
--             copilot_cmp.setup(opts)
--             -- attach cmp source whenever copilot attaches
--             -- fixes lazy-loading issues with the copilot cmp source
--             lspUtil.on_attach(function()
--               copilot_cmp._on_insert_enter({})
--             end, "copilot")
--           end,
--           specs = {
--             {
--               "iguanacucumber/magazine.nvim",
--               optional = true,
--               ---@param opts cmp.ConfigSchema
--               opts = function(_, opts)
--                 table.insert(opts.sources, 1, {
--                   name = "copilot",
--                   group_index = 1,
--                   priority = 100,
--                 })
--               end,
--             },
--           },
--         },
--       },
--     },
--   }
--   or nil,
-- }
-- config blink.cmp
