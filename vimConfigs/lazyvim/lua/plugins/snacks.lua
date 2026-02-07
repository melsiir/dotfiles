return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = not vim.g.default_screen,
      width = 35,
      preset = {
        header = "MELSIIR",
      },
    },
  },
}
