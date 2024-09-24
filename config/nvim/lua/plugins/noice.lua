return {
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
}
