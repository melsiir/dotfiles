return {
  --add
  {
    "nvimdev/dashboard-nvim",
    -- enabled = true,
    --
    --     opts = function(_, opts)
    --       local logo = [[
    -- "                        .   *        .       ."
    -- "         *      -0-"
    -- "            .                .  *       - )-"
    -- "         .      *       o       .       *"
    -- "   o                |"
    -- "             .     -O-"
    -- "  .                 |        *      .     -0-"
    -- "         *  o     .    '       *      .        o"
    -- "                .         .        |      *"
    -- "     *             *              -O-          ."
    -- "           .             *         |     ,"
    -- "                  .           o"
    -- "          .---."
    -- "    =   _/__~0_\_     .  *            o       '"
    -- "   = = (_________)             ."
    -- "                   .                        *"
    -- "         *               - ) -       *"
    -- "                .               ."
    --      ]]
    --       logo = string.rep("\n", 8) .. logo .. "\n\n"
    --       opts.config.header = vim.split(logo, "\n")
    --     end,
  },
  -- { "nvim-lualine/lualine.nvim", enabled = false },
  --
  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    -- enabled = false,
    opts = {
      servers = {
        lua_ls = {
          --do not install with mason
          mason = false,
        },
      },
    },
  },

  --disable notify for now
  -- { "rcarriga/nvim-notify", enabled = false },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        fish = { "fish_indent" },
        json = { "jq" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
    },
  },

  -- add custom snippets to cmp
  -- and change buffer cmp keyword_length
  {

    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        {
          name = "buffer",
          keyword_length = 3,
          -- option = {
          --   keyword_pattern = [[\k\+]],
          -- },
        },
        { name = "path" },
      }
      -- load custom fish snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "./lua/config/snippets" })
    end,
  },

  {
    "romgrk/barbar.nvim",
    -- event = "InsertEnter",
    enabled = true,
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      -- clickable = true,
      -- insert_at_start = true,
      icons = {
        modified = { button = "●" },
      },
      exclude_ft = {
        "dashboard",
      },
    },
    -- version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  -- this plugin handle error and warrning messages
  --  and the shape and feel of cmdline and seach bar
  --  make floating cmdline
  --
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        format = {
          --   cmdline = { icon = ">" },
          --   search_down = { icon = "🔍⌄" },
          search_down = { icon = "🔭" },
          --   search_up = { icon = "🔍⌃" },
          --   filter = { icon = "$" },
          --   lua = { icon = "☾" },
          --   help = { icon = "?" },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
        },
      },
    },
  },
  -- the this show you where you are in code but iam disable it for now
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  --this will earse the lazyvim list and add these instead if you
  -- just want to extend the original list see examples.lua
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vimdoc",
        "c",
        "bash",
        "lua",
        "python",
        "fish",
        "json",
        "csv",
        "html",
        "css",
        -- "toml",
        -- "yaml",
        "markdown",
        "tsx",
        "typescript",
        "javascript",
        "regex",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_z = {}
      opts.sections.lualine_y = {}
      opts.sections.lualine_y = { "progress" }
      opts.sections.lualine_z = { "location" }
      -- table.insert(opts.sections.lualine_x, "progress")
    end,
  },
}
