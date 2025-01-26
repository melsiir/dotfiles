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
    opts_extend = { "spec" },
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          {
            "<leader>i",
            function()
              require("nvim-toggler").toggle()
            end,
            desc = "toggle true and false",
          },
        }
      }
    }
  }
}
