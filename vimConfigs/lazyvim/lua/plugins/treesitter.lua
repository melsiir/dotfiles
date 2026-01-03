--this will earse the lazyvim list and add these instead if you
-- just want to extend the original list see examples.lua

return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vimdoc",
      "c",
      "bash",
      -- "kotlin",
      "lua",
      "python",
      "fish",
      "json",
      "csv",
      "html",
      "css",
      -- "toml",
      -- "yaml",
      "markdown",
      "tsx",
      "typescript",
      "javascript",
      "regex",
      -- "rust",
      -- "java",
    },
  },
}
