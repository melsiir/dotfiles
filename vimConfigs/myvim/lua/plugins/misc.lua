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
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,              desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
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
    -- event = "VeryLazy",
    dependencies = {
      "stevearc/dressing.nvim",
      -- "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
    cmd = "Nerdy",
  },
  -- {
  --   "Dan7h3x/neaterm.nvim",
  --   branch = "stable",
  --   event = "VeryLazy",
  --   opts = {
  --     -- Your custom options here (optional)
  --     keymaps = {
  --       new_horizontal = '<C-_>',
  --     },
  --
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "ibhagwan/fzf-lua",
  --   },
  -- },
  -- {
  --   "rachartier/tiny-inline-diagnostic.nvim",
  --   event = "VeryLazy", -- Or `LspAttach`
  --   priority = 1000,    -- needs to be loaded in first
  --   config = function()
  --     require('tiny-inline-diagnostic').setup()
  --   end
  -- },
  {
    "watzon/goshot.nvim",
    cmd = "Goshot",
    opts = {
      binary = "goshot", -- Path to goshot binary (default: "goshot")
      auto_install = true, -- Automatically install goshot if not found (default: false)
    },
    keys = {
      { "<leader>bS", "<cmd>Goshot<cr>", mode = { "n" }, desc = "Take screenshot" },
      { "<leader>bS", "<cmd>'<,'>Goshot<cr>", mode = { "v" }, desc = "Take screenshot of selection" },
    },
  },
  -- "mikavilpas/blink-ripgrep.nvim"
  {
    "ficcdaf/academic.nvim",
    -- optional: only load for certain filetypes
    ft = { "markdown", "tex" },
  },
  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
      -- You don't need to set these options.
      require("colorful-menu").setup({
        ft = {
          lua = {
            -- Maybe you want to dim arguments a bit.
            auguments_hl = "@comment",
          },
          typescript = {
            -- Or "vtsls", their information is different, so we
            -- need to know in advance.
            ls = "typescript-language-server",
          },
          rust = {
            -- such as (as Iterator), (use std::io).
            extra_info_hl = "@comment",
          },
          c = {
            -- such as "From <stdio.h>"
            extra_info_hl = "@comment",
          },
        },
        -- If the built-in logic fails to find a suitable highlight group,
        -- this highlight is applied to the label.
        fallback_highlight = "@variable",
        -- If provided, the plugin truncates the final displayed text to
        -- this width (measured in display cells). Any highlights that extend
        -- beyond the truncation point are ignored. Default 60.
        max_width = 60,
      })
    end,
  },
  { -- color previews & color picker
    "uga-rosa/ccc.nvim",
    lazy = true,
    keys = {
      { "#", vim.cmd.CccPick, desc = " Color Picker" },
    },
    ft = { "css", "scss", "sh", "zsh", "lua" },
    config = function(spec)
      local ccc = require("ccc")

      ccc.setup({
        win_opts = { border = vim.g.borderStyle },
        highlight_mode = "background",
        highlighter = {
          auto_enable = true,
          filetypes = spec.ft, -- uses lazy.nvim's ft spec
          max_byte = 200 * 1024, -- 200kb
          update_insert = false,
        },
        pickers = {
          ccc.picker.hex_long, -- only long hex to not pick issue numbers like #123
          ccc.picker.css_rgb,
          ccc.picker.css_hsl,
          ccc.picker.css_name,
          ccc.picker.ansi_escape(),
        },
        alpha_show = "hide", -- needed when highlighter.lsp is set to true
        recognize = { output = true }, -- automatically recognize color format under cursor
        inputs = { ccc.input.hsl },
        outputs = {
          ccc.output.css_hsl,
          ccc.output.css_rgb,
          ccc.output.hex,
        },
        mappings = {
          ["<Esc>"] = ccc.mapping.quit,
          ["q"] = ccc.mapping.quit,
          ["L"] = ccc.mapping.increase10,
          ["H"] = ccc.mapping.decrease10,
          ["o"] = ccc.mapping.cycle_output_mode, -- = change output format
        },
      })
    end,
  },
  -- {
  --   "philosofonusus/morta.nvim",
  --   name = 'morta',
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     vim.cmd.colorscheme 'morta'
  --   end,
  -- },
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    main = "nvim-silicon",
    opts = {
      -- Configuration here, or leave empty to use defaults
      line_offset = function(args)
        return args.line1
      end,
      theme = "tokyonight_storm",
      output = function()
        return vim.fn.expand("$HOME") .. "/storage/pictures/" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
      end,
      language = function()
        return vim.bo.filetype
      end,
      -- background_image = function()
      --   return vim.fn.expand("$HOME") .. "/storage/shared/dark-desert.jpg"
      -- end,
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
      end,
      no_line_number = true,
    },
  },
  {
    "comfysage/evergarden",
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      transparent_background = true,
      variant = "medium", -- 'hard'|'medium'|'soft'
      overrides = {}, -- add custom overrides
    },
  },
  -- {
  --   "neo451/feed.nvim",
  --   cmd = "Feed",
  --   require "feed".setup {
  --     feeds = {
  --       "https://dotfyle.com/this-week-in-neovim/rss.xml"
  --     }
  --   }
  -- },
  -- {
  --   'marko-cerovac/material.nvim',
  --   config = function()
  --     require('material').setup({
  --       disable = {
  --         background = true,
  --       }
  --     })
  --     vim.cmd("colorscheme material-oceanic")
  --   end
  -- },
  {
    "nvzone/typr",
    cmd = "TyprStats",
    dependencies = "nvzone/volt",
    opts = {},
  },
}
