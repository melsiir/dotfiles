return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vimdoc",
      "vim",
      "regex",
      "toml",
      "json",
      -- "groovy",
      "gitignore",
      "yaml",
      "markdown",
      "markdown_inline",
      "bash",
      "fish",
    },
  },
}
