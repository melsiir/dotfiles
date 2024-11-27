return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.exclude.filetypes, {
        "text",
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",

    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "trouble",
          "text",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
