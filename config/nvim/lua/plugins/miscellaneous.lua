

return {
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        WARN = { alt = { "WARNING", "XXX", "CAUTION", "ALERT" } },
      },
    },
  },
  {
    "garymjr/nvim-snippets",
    opts = {
      friendly_snippets = true,
    },
    dependencies = { "rafamadriz/friendly-snippets" },
  },
    {
      "olrtg/nvim-emmet",
      config = function()
        vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
      end,
    },
  -- disables hungry features for files larget than 2MB
  { "LunarVim/bigfile.nvim" },
  -- {
  --   "mg979/vim-visual-multi",
  --   event = { "BufReadPost", "BufNewFile" },
  -- },
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },

}
