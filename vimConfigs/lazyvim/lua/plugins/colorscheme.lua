return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = vim.g.transparent_enabled,
      style = "night",
      styles = {
        -- comments = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme("onedark")
    -- end,
  },
  -- {
  --   "svrana/neosolarized.nvim",
  --   -- enabled = false,
  --   -- priority = 1000, -- make sure to load this before all the other start plugins
  --
  --   dependencies = { "tjdevries/colorbuddy.nvim" },
  -- },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      -- vim.cmd('colorscheme github_dark')
    end,
  },

  -- {
  --   "rebelot/kanagawa.nvim",
  -- },

  {
    "AlexvZyl/nordic.nvim",
  },
  {
    "Rigellute/rigel",
    lazy = false,
  },
  {
    "gbprod/nord.nvim",
    -- lazy = true,
    priority = 1000,
    config = function()
      require("nord").setup({
        diff = { mode = "fg" },
        search = { theme = "vscode" },
        borders = true,
        transparent = vim.g.transparent_enabled,
        errors = { mode = "none" },
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          functions = { italic = false },
          strings = { italic = false },
          variables = { italic = false },
          NeoTreeGitUnstaged = { italic = false },
          NeoTreeGitUntracked = { italic = false },
          NeoTreeMessage = { italic = false },
          errors = { italic = false },
          bufferline = {
            current = { bold = false },
            modified = { bold = false, italic = true },
          },
        },
        on_highlights = function(highlights, colors)
          highlights["@variable.parameter.bash"] = { link = "@variable" }
          highlights.TelescopeNormal = {
            bg = colors.polar_night.bright,
            -- fg = colors.aurora.green,
          }
          highlights.TelescopeBorder = {
            bg = colors.polar_night.bright,
            fg = colors.polar_night.bright,
          }
          highlights.TelescopePromptNormal = {
            bg = colors.polar_night.brightest,
          }
          highlights.TelescopePromptBorder = {
            bg = colors.polar_night.brightest,
            fg = colors.polar_night.brightest,
          }
          highlights.TelescopePromptTitle = {
            bg = colors.polar_night.brightest,
            fg = colors.polar_night.brightest,
            -- bg = colors.frost.ice,
            -- fg = colors.frost.artic_icean,
          }
          highlights.TelescopePreviewTitle = {
            bg = colors.polar_night.bright,
            -- fg = colors.aurora.green,
          }
          highlights.TelescopeResultsTitle = {
            -- bg = colors.snow_storm.origin,
            bg = colors.polar_night.bright,
            fg = colors.polar_night.bright,
          }
          highlights.TelescopePromptCounter = {
            fg = colors.snow_storm.origin,
          }
          highlights.TelescopePromptPrefix = {
            fg = colors.frost.ice,
          }
          highlights.TelescopeSelection = {
            bg = colors.polar_night.brightest,
          }
          highlights.TelescopePreview = {
            bg = colors.polar_night.bright,
          }
        end,
      })
    end,
  },
  { "catppuccin/nvim",  name = "catppuccin", priority = 1000, lazy = false },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "whatyouhide/vim-gotham",
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
