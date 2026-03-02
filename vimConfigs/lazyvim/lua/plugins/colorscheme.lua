--- lazyvim take care of lazyloading and prioratizings
return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = vim.g.transparent_enabled,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = vim.g.transparent_enabled,
      float = {
        transparent = vim.g.transparent_enabled, -- enable transparent floating windows
        -- solid = false, -- use solid styling for floating windows, see |winborder|
      },
      no_italic = true, -- Force no italic
    },
  },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "whatyouhide/vim-gotham",
  },

  {
    "gbprod/nord.nvim",
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
        },
      })
    end,
  },

  -- {
  --   "gbprod/nord.nvim",
  --   config = function()
  --     require("nord").setup({
  --       transparent = vim.g.transparent_enabled,
  --     })
  --   end,
  -- },
  {
    "jpwol/thorn.nvim",
    opts = {
      transparent = vim.g.transparent_enabled,
    },
  },
  -- {
  --   "shaunsingh/nord.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Example config in lua
  --     vim.g.nord_contrast = true
  --     vim.g.nord_borders = false
  --     vim.g.nord_disable_background = true
  --     vim.g.nord_italic = false
  --     vim.g.nord_uniform_diff_background = true
  --     vim.g.nord_bold = false
  --
  --     -- Load the colorscheme
  --
  --     vim.g.nord_disable_background = vim.g.transparent_enabled
  --   end,
  -- },
  {
    "vague-theme/vague.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
      })
      -- vim.cmd("colorscheme vague")
    end
  },
  {
    'https://gitlab.com/shmerl/neogotham.git',
    lazy = false,    -- to make sure it's loaded on startup
    priority = 1000, -- to load before other plugins
    -- config = function()
    --   vim.cmd.colorscheme('neogotham')
    -- end
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
      icons = {
        diagnostics = {
          --   󰌵  󱠃    󱠂
          Hint = "󰌵 ",
        },
      },
    },
  },
}
