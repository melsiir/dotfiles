-- return {
--   {
--     "cameron-wags/rainbow_csv.nvim",
--     -- enabled = false,
--     -- event = "VeryLazy",
--     config = true,
--     ft = {
--       "csv",
--       "tsv",
--       "csv_semicolon",
--       "csv_whitespace",
--       "csv_pipe",
--       "rfc_csv",
--       "rfc_semicolon",
--     },
--     cmd = {
--       "RainbowDelim",
--       "RainbowDelimSimple",
--       "RainbowDelimQuoted",
--       "RainbowMultiDelim",
--     },
--   },
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = {
--       highlight = {
--         disable = { "csv" }
--       }
--     }
--     -- opts = function(_, opts)
--     --   if type(opts.ensure_installed) == "table" then
--     --     vim.list_extend(opts.ensure_installed, { "csv" })
--     --   end
--     --
--     --   -- disable csv highlighting as the treesitter has auto install. use the rainbow_csv.nvim highlighting instead.
--     --   if type(opts.highlight.disable) == "table" then
--     --     vim.list_extend(opts.highlight.disable, { "csv" })
--     --   else
--     --     opts.highlight.disable = { "csv" }
--     --   end
--     -- end,
--   }
-- }


return {
  "mechatroner/rainbow_csv", -- modify and query CSV files
  ft = {
    "csv",
    "tsv",
    "psv",
    "csv_pipe",
    "csv_semicolon",
  },
  config = function()
    vim.g.disable_rainbow_hover = 1
    vim.keymap.set("n", "<leader>uh", function()
      if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
        if vim.api.nvim_get_var("disable_rainbow_hover") == 1 then
          vim.api.nvim_set_var("disable_rainbow_hover", 0)
        else
          vim.api.nvim_set_var("disable_rainbow_hover", 1)
        end
        vim.cmd(":ed %")
      end
    end, { desc = "RainbowCSV Toggle Hover" })
    vim.keymap.set("n", "<M-Left>", function()
      if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
        vim.cmd("RainbowCellGoLeft")
      end
    end, { desc = "RainbowCSV Cell Go Left" })
    vim.keymap.set("n", "<M-Right>", function()
      if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
        vim.cmd("RainbowCellGoRight")
      end
    end, { desc = "RainbowCSV Cell Go Right" })
    vim.keymap.set("n", "<M-Up>", function()
      if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
        vim.cmd("RainbowCellGoUp")
      end
    end, { desc = "RainbowCSV Cell Go Up" })
    vim.keymap.set("n", "<M-Down>", function()
      if vim.api.nvim_buf_get_var(0, "rbcsv") == 1 then
        vim.cmd("RainbowCellGoDown")
      end
    end, { desc = "RainbowCSV Cell Go Down" })
  end,
}
