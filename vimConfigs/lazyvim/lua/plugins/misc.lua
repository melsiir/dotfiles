return {
  {
    "folke/todo-comments.nvim",
    optional = true,
    opts = {
      keywords = {
        WARN = { alt = { "WARNING", "XXX", "CAUTION", "ALERT" } },
      },
    },
  },
  -- {
  --   "olrtg/nvim-emmet",
  --   config = function()
  --     vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
  --   end,
  -- },
  -- Lazy
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = "Nerdy",
    opts = {
      max_recents = 30, -- Configure recent icons limit
      copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
      copy_register = "+", -- Register to use for copying (if `copy_to_clipboard` is true)
    },
    keys = {
      { "<leader>in", ":Nerdy list<CR>", desc = "Browse nerd icons" },
      { "<leader>iN", ":Nerdy recents<CR>", desc = "Browse recent nerd icons" },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },
  {
    "brianhuster/live-preview.nvim",
    -- Lazy = true,
    dependencies = {
      -- You can choose one of the following pickers
      -- "ibhagwan/fzf-lua",
      "folke/snacks.nvim",
    },
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        function()
          if vim.g.liveserver_bufnr == nil then
            if vim.o.filetype == "markdown" then
              vim.cmd("LivePreview start")
              vim.g.liveserver_bufnr = vim.api.nvim_get_current_buf()
            else
              vim.cmd("LiveServer")
            end
          else
            if vim.o.filetype == "markdown" then
              vim.cmd("LivePreview close")
              vim.g.liveserver_bufnr = nil
            else
              vim.cmd("LiveServerStop")
            end
          end
        end,
        desc = "toggle live-server",
      },
    },
    config = function()
      require("livepreview.config").set()
    end,
  },
}
