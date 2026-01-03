return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
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
          local prompt = "#2d3149"

          hl.WinSeparator = { fg = "#444a73" }
          hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopePromptNormal = {
            bg = prompt,
          }
          hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end,
      })
      -- vim.cmd.colorscheme("tokyonight")
    end,
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
      -- vim.cmd.colorscheme("nord")
    end,
  },
  install = {
    colorscheme = { "nord" },
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = true,
    opts = {
      options = {
        transparent = vim.g.transparent_enabled,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },

      groups = {
        all = {
          ["@markup.italic"] = { style = "italic" },
          -- Make and/or/not stand out more
          ["@keyword.operator"] = { link = "@keyword" },
          -- -- Make markdown links stand out
          ["@text.reference"] = { link = "@keyword" },
          ["@text.literal"] = { style = "" }, -- Don't italicize
          ["@codeblock"] = { bg = "palette.bg0" },
          ["@neorg.markup.strikethrough"] = { fg = "palette.comment", style = "strikethrough" },
        },
      },
    },
    config = function()
      -- vim.cmd.colorscheme("nightfox")
      require("nightfox").setup({
        on_highlights = function(hl, c)
          local prompt = "#2d3149"
          hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopePromptNormal = {
            bg = prompt,
          }
          hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end,
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
    -- commit = 'dd640f6',
    priority = 1000,
    -- enabled = false,
    config = function()
      local config = {
        -- Main options --
        style = "dark",                          -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = vim.g.transparent_enabled, -- Show/hide background
        term_colors = true,                      -- Change terminal color as per the selected theme style
        ending_tildes = false,                   -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false,            -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        -- toggle_style_key = "<leader>th",                                                     -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none",
        },

        -- Lualine options --
        lualine = {
          transparent = true, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {
          -- purple = '#56b6c2',
        },               -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true,     -- darker colors for diagnostic
          undercurl = true,  -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      }

      local onedark = require("onedark")
      onedark.setup(config)
      -- onedark.load()

      -- Make the background of diagnostics messages transparent
      local set_diagnostics_bg_transparency = function()
        vim.cmd([[highlight DiagnosticVirtualTextError guibg=none]])
        vim.cmd([[highlight DiagnosticVirtualTextWarn guibg=none]])
        vim.cmd([[highlight DiagnosticVirtualTextInfo guibg=none]])
        vim.cmd([[highlight DiagnosticVirtualTextHint guibg=none]])
      end
      set_diagnostics_bg_transparency()

      -- Toggle background transparency
      local toggle_transparency = function()
        config.transparent = not config.transparent
        onedark.setup(config)
        onedark.load()
        set_diagnostics_bg_transparency()
      end
      vim.cmd([[highlight FlashLabel guibg=none]])
      vim.cmd([[highlight FlashMatch guibg=none]])

      -- vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
      -- vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
      require("rose-pine").setup({
        variant = "moon",      -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        disable_background = vim.g.transparent_enabled,
        disable_float_bacground = vim.g.transparent_enabled,
        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true,        -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = false,
          transparency = vim.g.transparent_enabled,
        },

        groups = {
          border = "muted",
        },

        palette = {
          -- Override the builtin palette per variant
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
        },

        highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        },

        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          --     highlight.undercurl = false
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
        end,
      })
      -- vim.cmd("colorscheme rose-pine")
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
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

  'JoosepAlviste/palenightfall.nvim',
  {
    "Vallen217/eidolon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd [[colorscheme eidolon]]
    end
  },
}
