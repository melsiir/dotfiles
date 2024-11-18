return {
  {
    "nguyenvukhang/nvim-toggler",
    event = "VeryLazy",

    config = function()
      -- local toggleTF = function()
      --   require("nvim-toggler").toggle()
      -- end
      -- vim.keymap.set("n", "<leader>i", toggleTF, { desc = "Toggle (true <> false)" })

      require("nvim-toggler").setup({
        inverses = {
          ["0"] = "1",
        },
        remove_default_keybindings = true,
      })
    end,
  },
  {

    "folke/which-key.nvim",
    optional = true,
    config = function()
      local wk = require("which-key")
      wk.add({
        {
          "<leader>i",
          function()
            require("nvim-toggler").toggle()
          end,
          desc = "Toggle ",
          mode = "n",
        },
      })
    end,
  },
}
