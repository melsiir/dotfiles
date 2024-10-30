local isTransparent = true

-- if isTransparent then
--   local cmp = require("cmp")
--   if vim.g.colors_name == "nord" then
--     return
--   else
--     cmp.setup({
--       window = {
--         completion = cmp.config.window.bordered({
--           scrollbar = false,
--           side_padding = 1,
--           winhighlight = "Normal:CmpPmenu,Search:None",
--           -- border = "single",
--         }),
--         documentation = cmp.config.window.bordered({
--           winhighlight = "Normal:CmpDoc",
--         }),
--       },
--     })
--   end
-- end

return {
  {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        transparent = isTransparent,
        -- style = "night",
        styles = {
          -- comments = { italic = false },
          keywords = { italic = false },
          sidebars = "transparent",
          floats = "transparent",
        },
        sidebars = { "qf", "help", "terminal", "dagger", "aerial", "OverseerList", "neotest-summary" },
        on_highlights = function(highlights, c)
          for _, defn in pairs(highlights) do
            if defn.undercurl then
              defn.undercurl = false
              defn.underline = true
            end
          end
          highlights.AerialLineNC = { link = "LspReferenceText" }
          highlights.WinSeparator = { fg = "#444a73" }
          highlights.OverseerOutput = { link = "NormalSB" }
          highlights.TabLine = { fg = c.comment, bg = c.bg_statusline }
          highlights.TabLineSel = { fg = c.bg, bg = c.blue }
          highlights.TabLineModifiedSel = { fg = c.bg, bg = c.warning }
          highlights.TabLineIndexSel = { fg = c.bg, bg = c.blue, bold = true }
          highlights.TabLineIndexModifiedSel = { fg = c.bg, bg = c.warning, bold = true }
          highlights.TabLineDivider = { fg = c.blue }
          highlights.TabLineDividerSel = { fg = c.blue, bg = c.blue }
          highlights.TabLineDividerVisible = { fg = c.blue }
          highlights.TabLineDividerModifiedSel = { fg = c.warning, bg = c.warning }
        end,
      },
      config = function()
        -- vim.cmd.colorscheme("tokyonight")
        -- window separartor for terminal
        -- vim.cmd.hi("WinSeparator guifg=" .. vim.g.terminal_color_8)
        -- borderless telescope
        require("tokyonight").setup({
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
      "gbprod/nord.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("nord").setup({
          diff = { mode = "fg" },
          search = { theme = "vscode" },
          borders = true,
          transparent = isTransparent,
          errors = { mode = "none" },
          styles = {
            comments = { italic = true },
            keywords = {},
            functions = { italic = true },
            variables = {},
            errors = {},
            bufferline = {
              current = { bold = false },
              modified = { bold = false, italic = true },
            },
          },
          on_highlights = function(highlights, colors)
            highlights["@variable.parameter.bash"] = { link = "@variable" }
          end,
        })
        vim.cmd.colorscheme("nord")
      end,
    },
    install = {
      colorscheme = { "nord" },
    },
    -- {
    --   -- if you dont want to use just commentit because
    --   -- this configuration cause wirerd highlight issue
    --   -- in telescope
    --   "shaunsingh/nord.nvim",
    --   lazy = false,
    --   name = "nordold",
    --   -- enabled = false,
    --   priority = 1000,
    --   config = function()
    --     -- Example config in lua
    --     -- hi Statement ctermfg=Blue guifg=Blue
    --     vim.g.nord_contrast = false
    --     vim.g.nord_borders = false
    --     vim.g.nord_disable_background = false -- will the cmp menu highlight
    --     vim.g.nord_italic = false
    --     vim.g.nord_uniform_diff_background = true
    --     vim.g.nord_bold = false
    --     -- Load the colorscheme
    --     require("nord").set()
    --
    --     -- Toggle background transparency
    --     local bg_transparent = false
    --
    --     local toggle_transparency = function()
    --       bg_transparent = not bg_transparent
    --       vim.g.nord_disable_background = bg_transparent
    --       vim.cmd([[colorscheme nord]])
    --     end
    --     -- local colora = require("nord.named_colors")
    --     -- vim.cmd.hi("WinSeparator guifg=" .. colora.light_gray)
    --     -- vim.cmd.hi("WinSeparator guifg=" .. vim.g.terminal_color_8)
    --     vim.keymap.set(
    --       "n",
    --       "<leader>bg",
    --       toggle_transparency,
    --       { desc = "toggle nord transparency", noremap = true, silent = true }
    --     )
    --   end,
    -- },
    {
      "EdenEast/nightfox.nvim",
      priority = 1000,
      lazy = false,
      opts = {
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
  },
  {
    "navarasu/onedark.nvim",
    -- commit = 'dd640f6',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'onedark'

      local config = {
        -- Main options --
        style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = "<leader>th", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
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
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {
          -- purple = '#56b6c2',
        }, -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      }

      local onedark = require("onedark")
      onedark.setup(config)
      onedark.load()

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

      vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
    end,
  },
}
