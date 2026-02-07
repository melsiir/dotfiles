return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-mini/mini.icons",
  },
  config = function()
    -- require("lspconfig.ui.windows").default_options.border = "single"

    local line_x = vim.fn.has("Android") == 1 and {} or { "fileformat", "encoding" }

    -- Lualine
    require("lualine").setup({
      options = {
        -- theme = "fullerene",
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
          },
          {
            "diagnostics",
            on_click = function()
              vim.cmd("Trouble diagnostics toggle filter.buf=0")
            end,
          },
          -- "filename",
        },
        lualine_c = {},
        lualine_x = {
          line_x,
          -- "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
