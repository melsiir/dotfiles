return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  version = false, -- last release is way too old and doesn't work on Windows
  -- event = "VeryLazy",  -- Load after startup to ensure the plugin is properly initialized
  -- dependencies = {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  -- },
  config = function()
    -- Safely require the treesitter configs module
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup({
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "bash",
        "diff",
        "lua",
        "python",
        "javascript",
        "typescript",
        "vimdoc",
        "vim",
        "regex",
        "sql",
        "toml",
        "json",
        "gitignore",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "tsx",
        "css",
        "html",
      },

      -- Autoinstall languages that are not installed
      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true },
    })
  end
  }
