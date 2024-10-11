return {
  -- { "cocopon/iceberg.vim" },
  { "oahlen/iceberg.nvim" },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  }, -- Lazy
  -- Lua

  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup({
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      })
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
      -- vim.cmd("colorscheme poimandres")
    end,
  },
  {
    "shaunsingh/moonlight.nvim",
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "2giosangmitom/nightfall.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "sainnhe/sonokai",
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
      -- vim.cmd [[colorscheme tokyodark]]
    end,
  },
  {
    "sonph/onehalf",
  },
  {
    "oxfist/night-owl.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
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
    enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    --   -- Example config in lua
    --   vim.g.nord_contrast = true -- Make sidebars and popup menus like nvim-tree and telescope have a different background
    --   vim.g.nord_borders = false -- Enable the border between verticaly split windows visable
    --   vim.g.nord_disable_background = true -- Disable the setting of background color so that NeoVim can use your terminal background
    --   vim.g.set_cursorline_transparent = false -- Set the cursorline transparent/visible
    --   vim.g.nord_italic = false -- enables/disables italics
    --   vim.g.nord_enable_sidebar_background = false -- Re-enables the background of the sidebar if you disabled the background of everything
    --   vim.g.nord_uniform_diff_background = true -- enables/disables colorful backgrounds when used in diff mode
    --   vim.g.nord_bold = false -- enables/disables bold
    --
    --   -- Load the colorscheme
    --   -- require("nord").set()
    --
    --   --   local bg_transparent = true
    --   --
    --   --   -- Toggle background transparency
    --   --   local toggle_transparency = function()
    --   --     bg_transparent = not bg_transparent
    --   --     vim.g.nord_disable_background = bg_transparent
    --   --     vim.cmd([[colorscheme nord]])
    --   --   end
    --   --
    --   --   vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
    -- end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "whatyouhide/vim-gotham",
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      local terafox = require("nightfox.palette").load("terafox")

      -- {
      --   bg0 = "#0f1c1e",
      --   bg1 = "#152528",
      --   bg2 = "#1d3337",
      --   bg3 = "#254147",
      --   bg4 = "#2d4f56",
      --   black = {
      --     base = "#2f3239",
      --     bright = "#4e5157",
      --     dim = "#282a30",
      --     light = false,
      --     <metatable> = <1>{
      --       __call = <function 1>,
      --       __index = <table 1>,
      --       harsh = <function 2>,
      --       new = <function 3>,
      --       subtle = <function 4>
      --     }
      --   },
      --   blue = {
      --     base = "#5a93aa",
      --     bright = "#73a3b7",
      --     dim = "#4d7d90",
      --     light = false,
      --     <metatable> = <table 1>
      --   },
      --   comment = "#6d7f8b",
      --   cyan = {
      --     base = "#a1cdd8",
      --     bright = "#afd4de",
      --     dim = "#89aeb8",
      --     light = false,
      --     <metatable> = <table 1>
      --   },
      --   fg0 = "#eaeeee",
      --   fg1 = "#e6eaea",
      --   fg2 = "#cbd9d8",
      --   fg3 = "#587b7b",
      --   generate_spec = <function 5>,
      --   green = {
      --     base = "#7aa4a1",
      --     bright = "#8eb2af",
      --     dim = "#688b89",
      --     light = false,
      --     <metatable> = <table 1>
      --   },
      --   magenta = {
      --     base = "#ad5c7c",
      --     bright = "#b97490",
      --     dim = "#934e69",
      --     light = false,
      --     <metatable> = <table 1>
      --   },
      --   meta = {
      --     light = false,
      --     name = "terafox"
      --   },
      --   orange = {
      --     base = "#ff8349",
      --     bright = "#ff9664",
      --     dim = "#d96f3e",
      --     light = false,
      --     <metatable> = <table 1>
      --   },
      --   pink = {
      --     base = "#cb7985",
      --     bright = "#d38d97",
      --     dim = "#ad6771",
      --     light = false,
      --     <metatable> = <table 1>
      --   },
      --   red = {
      --     base = "#e85c51",
      --     bright = "#eb746b",
      --     dim = "#c54e45",
      --     light = false,
      --     <metatable> = <table 1>
      --   },
      --   sel0 = "#293e40",
      --   sel1 = "#425e5e",
      --   white = {
      --     base = "#ebebeb",
      --     bright = "#eeeeee",
      --     dim = "#c8c8c8",
      --     light = false,
      --     <metatable> = <table 1>
      --   },
      --   yellow = {
      --     base = "#fda47f",
      --     bright = "#fdb292",
      --     dim = "#d78b6c",
      --     light = false,
      --     <metatable> = <table 1>
      --   }
      -- }
      local colors = {
        added_line = "#0e3929",
        added_text = "#19674a",
        deleted_line = "#2d1c1c",
        deleted_text = "#4e3131",
        off_white_text = "#cccccc",
      }
      local groups = {
        -- general
        -- Search = { fg = 'white', bg = terafox.magenta.dim },
        -- IncSearch = { fg = 'white', bg = terafox.yellow.dim },
        CmpPmenuBorder = { link = "NormalFloatBorder" },
        CursorLine = { bg = terafox.bg2 },
        DiagnosticSignInfo = { link = "FloatBorder" }, -- used heavily by noice
        DiffAdd = { bg = colors.added_line }, -- show added lines
        DiffAddAsDelete = { bg = colors.deleted_line }, -- used in diffview (left panel) highlight line that changed
        DiffAddText = { bg = colors.added_text, fg = colors.off_white_text }, -- show added characters within added lines
        DiffChange = { bg = colors.deleted_line }, -- fugitive (left side) to show what LINE text was changed on
        DiffDelete = { bg = colors.deleted_line, fg = colors.deleted_text }, -- shows fully deleted blocks of code
        DiffDeleteText = { bg = colors.deleted_text, fg = colors.off_white_text }, -- diffview (left panel) highlight word that changed
        DiffText = { bg = colors.deleted_text, fg = colors.off_white_text }, -- fugitive (left side) to show exact characters that deleted
        FloatBorder = { fg = terafox.green.dim },
        LeapBackdrop = { link = "Comment" },
        LeapMatch = { bg = terafox.magenta.dim, fg = colors.off_white_text },
        LeapLabelPrimary = { bg = terafox.sel0, fg = colors.off_white_text },
        LeapLabelSecondary = { bg = terafox.sel1, fg = colors.off_white_text },
        LspInfoBorder = { link = "FloatBorder" },
        MasonHeader = { bg = terafox.green.dim },
        MasonHeaderSecondary = { bg = terafox.green.dim },
        MasonHighlightBlock = { bg = terafox.green.dim },
        MasonHighlightBlockBold = { bg = terafox.green.dim },
        NeoTreeNormal = { bg = "none" },
        NvimTreeNormal = { bg = "none" },
        Normal = { bg = "none" },
        NormalFloat = { bg = "none" },
        NormalFloatBorder = { link = "FloatBorder" },
        NormalNC = { bg = "none" },
        Pmenu = { bg = terafox.bg1 },
        -- FzfLuaBorder = { link = "FloatBorder" },
        PmenuBorder = { link = "FloatBorder" },
        StatusLine = { bg = "none" }, -- this must be style different that NC otherwise vim will use ^^^^^^ to differentiate
        TabLineFill = { bg = "none" },
        StatusLineNC = { bg = "none", fg = "#7aa4a1" }, -- status line none current
        Substitute = { bg = terafox.magenta.dim, fg = "white" },
        TelescopeBorder = { link = "FloatBorder" },
        TelescopeMatching = { fg = terafox.orange.base },
        TelescopeSelection = { fg = "#ffffff", bg = terafox.bg2 },
        TelescopeResultsNormal = { fg = terafox.comment },
        VertSplit = { fg = terafox.bg2 },
        MatchParen = { bg = terafox.blue.dim, fg = colors.off_white_text },
        WhichKeyFloat = { link = "NormalyFloat" },
      }

      return {
        options = {
          styles = {
            -- comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
          transparent = true,
        },
        groups = {
          terafox = groups,
        },
      }
    end,
  },
  {
    "arcticicestudio/nord-vim",
  },
  { "diegoulloao/neofusion.nvim", priority = 1000, config = true, opts = ... },
  { "articblush/articblush.nvim", as = "articblush" },
}
