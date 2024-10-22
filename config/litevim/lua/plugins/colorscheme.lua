return {
  {

    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Example config in lua
      vim.g.nord_contrast = false
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true -- will the cmp menu highlight
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false

      -- Load the colorscheme
      require("nord").set()

      -- Toggle background transparency
      local bg_transparent = true

      local toggle_transparency = function()
        bg_transparent = not bg_transparent
        vim.g.nord_disable_background = bg_transparent
        vim.cmd([[colorscheme nord]])
      end

      vim.keymap.set(
        "n",
        "<leader>bg",
        toggle_transparency,
        { desc = "toggle nord transparency", noremap = true, silent = true }
      )
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = true,
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
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      style = "night",
      styles = {
        -- comments = { italic = false },
        keywords = { italic = false },
        floats = "normal",
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
    config = true,
  },
}
