-- local signs = {
--   [vim.diagnostic.severity.ERROR] = " ",
--   [vim.diagnostic.severity.WARN] = " ",
--   [vim.diagnostic.severity.HINT] = "󰠠 ",
--   [vim.diagnostic.severity.INFO] = " ",
-- }
--
-- vim.diagnostic.config({
--   signs = {
--     text = signs,
--   },
-- })

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {
          enabled = true,
          mason = true,
        },
        jdtls = {
          -- enabled = true,
          mason = false,
        },
        emmet_language_server = {
          enabled = true,
          mason = true,
        },
        -- use cssls and jsonls and eslint and
        -- htmls form only one file since they all vscode extracted to save space
        cssls = {
          enabled = true,
          mason = false,
        },
        jsonls = {
          enabled = true,
          mason = false,
        },
        eslint = {
          enabled = true,
          mason = false,
        },
        clangd = {
          --do not install with mason
          mason = false,
        },
        ruff = {
          mason = false,
        },
        -- shfmt = {
        --   mason = false,
        -- },
        stylua = {
          mason = false,
        },
        lua_ls = {
          --do not install with mason
          mason = false,
        },
        marksman = {
          mason = false,
        },
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- automaticlly enable every lsp downloaded by mason even if not configured
      -- automatic_enable = false,
    },
  },
}
