return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    -- opts = { style = "moon" },
  },
  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme("onedark")
    -- end,
  },
  {
    "svrana/neosolarized.nvim",
    -- enabled = false,
    -- priority = 1000, -- make sure to load this before all the other start plugins

    dependencies = { "tjdevries/colorbuddy.nvim" },
  },
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

  {
    "rebelot/kanagawa.nvim",
  },
  -- Configure LazyVim to loadd colorscheme
  {
    "AlexvZyl/nordic.nvim",
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
  },
  {
    "Rigellute/rigel",
    lazy = false,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Example config in lua
      vim.g.nord_contrast = true -- Make sidebars and popup menus like nvim-tree and telescope have a different background
      vim.g.nord_borders = false -- Enable the border between verticaly split windows visable
      vim.g.nord_disable_background = true -- Disable the setting of background color so that NeoVim can use your terminal background
      vim.g.set_cursorline_transparent = false -- Set the cursorline transparent/visible
      vim.g.nord_italic = false -- enables/disables italics
      vim.g.nord_enable_sidebar_background = false -- Re-enables the background of the sidebar if you disabled the background of everything
      vim.g.nord_uniform_diff_background = true -- enables/disables colorful backgrounds when used in diff mode
      vim.g.nord_bold = false -- enables/disables bold

      -- Load the colorscheme
      -- require("nord").set()

      --   local bg_transparent = true
      --
      --   -- Toggle background transparency
      --   local toggle_transparency = function()
      --     bg_transparent = not bg_transparent
      --     vim.g.nord_disable_background = bg_transparent
      --     vim.cmd([[colorscheme nord]])
      --   end
      --
      --   vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
    },
  },
}
