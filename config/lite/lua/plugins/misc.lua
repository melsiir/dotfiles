return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false, -- Recommended
  --   ft = "markdown", -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },
  -- {
  --   "nvim-neorg/neorg",
  --   lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  --   version = "*", -- Pin Neorg to the latest stable release
  --   config = true,
  -- },
  "LunarVim/breadcrumbs.nvim",
  {
    "brianhuster/live-preview.nvim",
    -- lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Not required, but recommended for integrating with Telescope
    },
    opts = {
      cmd = "LivePreview", -- Main command of live-preview.nvim
      port = 5500, -- Port to run the live preview server on.
      autokill = false, -- If true, the plugin will autokill other processes running on the same port (except for Neovim) when starting the server.
      browser = "am start -n mark.via.gp/mark.via.Shell --activity-clear-task >/dev/null", --~/.co- Terminal command to open the browser for live-previewing (eg. 'firefox', 'flatpak run com.vivaldi.Vivaldi'). By default, it will use the default browser.
      dynamic_root = false, -- If true, the plugin will set the root directory to the previewed file's directory. If false, the root directory will be the current working directory (`:lua print(vim.uv.cwd())`).
      sync_scroll = false, -- If true, the plugin will sync the scrolling in the browser as you scroll in the Markdown files in Neovim.
      picker = "telescope", -- Picker to use for opening files. 3 choices are available: 'telescope', 'fzf-lua', 'mini.pick'. If nil, the plugin look for the first available picker when you call the `pick` command.
    },
  },
  -- disables hungry features for files larget than 2MB
  { "LunarVim/bigfile.nvim" },
  -- {
  --   "jackMort/tide.nvim",
  --   config = function()
  --     require("tide").setup({
  --       -- optional configuration
  --       keys = {
  --         leader = ",", -- Leader key to prefix all Tide commands
  --         panel = ",", -- Open the panel (uses leader key as prefix)
  --       },
  --     })
  --   end,
  --   requires = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },
  -- add this to the file where you setup your other plugins:
  -- {
  --   "monkoose/neocodeium",
  --   event = "VeryLazy",
  --   config = function()
  --     local neocodeium = require("neocodeium")
  --     neocodeium.setup()
  --     vim.keymap.set("i", "<A-f>", neocodeium.accept)
  --   end,
  -- },
  -- {
  --   "utilyre/barbecue.nvim",
  --   name = "barbecue",
  --   version = "*",
  --   -- enabled = false,
  --   dependencies = {
  --     "SmiteshP/nvim-navic",
  --     "nvim-tree/nvim-web-devicons", -- optional dependency
  --   },
  --   config = function()
  --     require("barbecue").setup({
  --       -- show_dirname = false,
  --       -- theme = {
  --       --   -- this highlight is used to override other highlights
  --       --   -- you can take advantage of its `bg` and set a background throughout your winbar
  --       --   -- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
  --       --   normal = { fg = "#c0caf5" },
  --       --
  --       --   -- these highlights correspond to symbols table from config
  --       --   ellipsis = { fg = "#737aa2" },
  --       --   separator = { fg = "#737aa2" },
  --       --   modified = { fg = "#737aa2" },
  --       --
  --       --   -- these highlights represent the _text_ of three main parts of barbecue
  --       --   dirname = { fg = "#737aa2" },
  --       --   basename = { bold = true },
  --       --   context = {},
  --       --
  --       --   -- these highlights are used for context/navic icons
  --       --   context_file = { fg = "#ac8fe4" },
  --       --   context_module = { fg = "#ac8fe4" },
  --       --   context_namespace = { fg = "#ac8fe4" },
  --       --   context_package = { fg = "#ac8fe4" },
  --       --   context_class = { fg = "#ac8fe4" },
  --       --   context_method = { fg = "#ac8fe4" },
  --       --   context_property = { fg = "#ac8fe4" },
  --       --   context_field = { fg = "#ac8fe4" },
  --       --   context_constructor = { fg = "#ac8fe4" },
  --       --   context_enum = { fg = "#ac8fe4" },
  --       --   context_interface = { fg = "#ac8fe4" },
  --       --   context_function = { fg = "#ac8fe4" },
  --       --   context_variable = { fg = "#ac8fe4" },
  --       --   context_constant = { fg = "#ac8fe4" },
  --       --   context_string = { fg = "#ac8fe4" },
  --       --   context_number = { fg = "#ac8fe4" },
  --       --   context_boolean = { fg = "#ac8fe4" },
  --       --   context_array = { fg = "#ac8fe4" },
  --       --   context_object = { fg = "#ac8fe4" },
  --       --   context_key = { fg = "#ac8fe4" },
  --       --   context_null = { fg = "#ac8fe4" },
  --       --   context_enum_member = { fg = "#ac8fe4" },
  --       --   context_struct = { fg = "#ac8fe4" },
  --       --   context_event = { fg = "#ac8fe4" },
  --       --   context_operator = { fg = "#ac8fe4" },
  --       --   context_type_parameter = { fg = "#ac8fe4" },
  --       -- },
  --     })
  --   end,
  --   opts = {
  --     -- configurations go here
  --   },
  -- },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        -- table: default groups
        groups = {
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLine",
          "CursorLineNr",
          "StatusLine",
          "StatusLineNC",
          "EndOfBuffer",
        },
        -- table: additional groups that should be cleared
        extra_groups = {},
        -- table: groups you don't want to clear
        exclude_groups = {},
        -- function: code to be executed after highlight groups are cleared
        -- Also the user event "TransparentClear" will be triggered
        on_clear = function() end,
      })
      -- vim.g.transparent_groups = vim.list_extend(
      --   vim.g.transparent_groups or {},
      --   vim.tbl_map(function(v)
      --     return v.hl_group
      --   end, vim.tbl_values(require("bufferline.config").highlights))
      -- )
      -- require("transparent").clear_prefix("lualine")
    end,
  },
}
