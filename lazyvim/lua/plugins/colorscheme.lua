return {
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
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },

  {
    "shaunsingh/nord.nvim",
    -- enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
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
