return {

  {
    "adibhanna/nvim-newfile.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Example key mappings (add to your init.lua)
      vim.keymap.set("n", "<leader>nf", ":NewFile<CR>", { desc = "Create new file" })
      vim.keymap.set("n", "<leader>nh", ":NewFileHere<CR>", { desc = "Create new file here" })
      require("nvim-newfile").setup({
        -- Optional configuration
      })
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  },
}
