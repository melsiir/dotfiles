return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = false,
  },
  -- to add ignore list add it to your home .gitignore
  -- change some options
  opts = {
    defaults = {
      prompt_prefix = "   ",
    },

    -- if you use fd as a finder its ignore file
    -- can be found in $HOME/.config/fd/ignore
    -- if you want to use custom ignore file use ignore-file flag
    pickers = {
      find_files = {
        find_command = {
          "fd",
          "--type",
          "f",
          "--color",
          "never",
          "-E",
          ".git",
          -- "--ignore-file",
          -- vim.fn.expand("$HOME") .. "/.gitignore", -- for some reason fd does not seem to recognize globle gitignore file
        },
        hidden = true,
      },
    },
  },
  -- config = function()
  --   require("telescope").load_extension("ui-select")
  -- end,
}
