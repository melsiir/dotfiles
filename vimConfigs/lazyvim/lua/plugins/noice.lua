return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      enabled = true,         -- enables the Noice cmdline UI
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
        bottom_search = true,   -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
      },
    },
  },
  keys = {
    { "<leader>n",  "",                         desc = "Noice" },
    { "<leader>nd", "<cmd>Noice dismiss<cr>",   desc = "Dismiss all visible messages" },
    { "<leader>nn", "<cmd>Noice<cr>",           desc = "Open Noice" },
    { "<leader>ne", "<cmd>Noice errors<cr>",    desc = "Open Noice Errors" },
    { "<leader>nt", "<cmd>Noice telescope<cr>", desc = "Open Noice with telescope" },
  },
}
