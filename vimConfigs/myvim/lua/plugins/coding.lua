return {
  -- Configures LuaLS to support auto-completion and type checking
  -- while editing your Neovim configuration.
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  -- Add lazydev source to cmp
  {
    "nvim-cmp",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sources, { name = "lazydev", group_index = 0 })
    end,
  },
}
