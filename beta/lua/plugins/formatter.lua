return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
    {
      "<leader>cf",
      function()
        require("conform").format({ timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      format_on_save = function(bufnr)
        -- if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        if vim.g.autoformat == false then
          return
        end
        return { timeout_ms = 3000, lsp_fallback = true }
      end,
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        javascript = { "prettier" },
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },
      -- config = M.setup,
    })
  end,
}
