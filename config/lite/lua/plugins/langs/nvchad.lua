return {
  {
    "Fildo7525/pretty_hover",
    keys = { "<leader>k" },
    config = true,
  },
  {
    "utilyre/barbecue.nvim",
    event = "LspAttach",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    keys = { "<C-d>", "<C-u>" },
    opts = { mappings = {
      "<C-u>",
      "<C-d>",
    } },
  },
  -- {
  --   "chikko80/error-lens.nvim",
  --   event = "LspAttach",
  --   opts = {},
  -- },
  {
    "razak17/tailwind-fold.nvim",
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
    opts = {
      min_chars = 50,
    },
  },
}
