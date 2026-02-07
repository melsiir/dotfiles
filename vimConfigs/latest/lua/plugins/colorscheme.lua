-- in active colorscheme set :
-- lazy = false,
-- priority = 1000, to load before everything anf avoid flickering on startup
-- on none active colorscheme
-- remove priority and set lazy = true
return {
  {
    "adibhanna/yukinord.nvim",
    Lazy = true,
    config = function()
      require("yukinord").setup({
        transparent = true,
        transparent_sidebar = true,
      })
      -- vim.cmd("colorscheme yukinord")
    end,
  },
  {
    "folke/tokyonight.nvim",
    -- priority = 1000,
    Lazy = true,
    opts = {
      transparent = vim.g.transparent_enabled,
      style = "night",
      styles = {
        -- comments = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "terminal", "dagger", "aerial", "OverseerList", "neotest-summary" },
    },
    config = function()
      -- window separartor for terminal
      -- vim.cmd.hi("WinSeparator guifg=" .. vim.g.terminal_color_8)
      -- borderless telescope
      require("tokyonight").setup({
        on_highlights = function(hl, c)
          hl.WinSeparator = { fg = "#444a73" }
        end,
      })
      -- vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1001,
    -- lazy = true,
    config = function()
      require("catppuccin").setup({
        -- flavour = "mocha",
        integrations = {
          telescope = {
            enabled = true,
            style = "nvchad",
          },
        },
        transparent_background = vim.g.transparent_enabled,
        no_italic = true, -- Force no italic
        custom_highlights = function(colors)
          return {
            FloatBorder = { fg = colors.purple },
            WinSeparator = { fg = colors.purple },
            -- BlinkCmpMenu = { fg = colors.text, bg = colors.mantle },
            -- BlinkCmpMenuBorder = { fg = colors.mantle, bg = colors.mantle },
            -- BlinkCmpDocBorder = { fg = colors.crust, bg = colors.crust },
            -- BlinkCmpDoc = { fg = colors.text, bg = colors.crust },
            -- BlinkCmpKindCopilot = { fg = colors.sky },
          }
        end,
      })
      -- vim.cmd([[highlight FlashLabel guibg=none]])
      -- vim.cmd([[highlight FlashMatch guibg=none]])
      vim.cmd.colorscheme("catppuccin-frappe")
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- priority = 1000,
    Lazy = true,

    opts = {
      styles = {
        bold = false,
        italic = false,
        transparency = true,
      },
    },

    config = function(_, opts)
      require("rose-pine").setup(opts)
      -- vim.cmd("colorscheme rose-pine")
      vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "none", fg = "#6e6a86", italic = true })
    end,
  },
}
