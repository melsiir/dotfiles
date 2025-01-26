local get_raw_config = function(server)
  local ok, ret = pcall(require, "lspconfig.configs." .. server)
  if ok then
    return ret
  end
  return require("lspconfig.server_configurations." .. server)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
      },
      setup = {

        tailwindcss = function(_, opts)
          local tw = get_raw_config("tailwindcss")
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Additional settings for Phoenix projects
          opts.settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          }

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
  {
    "razak17/tailwind-fold.nvim",
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
    opts = {
      min_chars = 50,
    },
  },

  -- {
  --   "iguanacucumber/magazine.nvim",
  --   optional = true,
  --   dependencies = {
  --     {
  --       "roobert/tailwindcss-colorizer-cmp.nvim",
  --     },
  --   },
  --   opts = function(_, opts)
  --     -- original LazyVim kind icon formatter
  --     local format_kinds = opts.formatting.format
  --     opts.formatting.format = function(entry, item)
  --       format_kinds(entry, item) -- add icons
  --       -- return require("tailwindcss-colorizer-cmp").formatter(entry, item)
  --       return require("nvim-highlight-colors").format(entry, item)
  --     end
  --   end,
  -- },
  --
  -- {
  --   "iguanacucumber/magazine.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local formatted_item = require("nvim-highlight-colors").format(entry, item)
  --     item.menu_hl_group = formatted_item.abbr_hl_group
  --     return item
  --   end
  -- }
}
