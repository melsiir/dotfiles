return {
  {
    "neovim/nvim-lspconfig",
    opts = {

      -- disable in favor of rustaceanvim
      setup = {
        rust_analyzer = function()
          return true
        end,
      },

      servers = {
        html = {
          enabled = true,
          mason = true,
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
        lua_ls = {
          enabled = true,
          --do not install with mason
          mason = false,
        },

        marksman = {
          --do not install with mason
         enabled = false,
          mason = false,
        },
        clangd = {
          --do not install with mason
          mason = false,
        },
        ruff = {
          --do not install with mason
          mason = false,
          enabled = false,
        },
        -- shfmt = {
        --   mason = false,
        -- },
        -- stylua = {
        --   --do not install with mason
        --   enabled=  true,
        --   mason = false,
        -- },
        --
        -- codelldb = {
        --   mason = false,
        -- },

        -- rust_analyzer = {
        --   mason = false,
        --   keys = {
        --     { "<leader>cc", "<cmd>RustRunnables<cr>", desc = "Run rust" },
        --     { "<leader>ck", "<cmd>!cd %;!cargo run --bin %<cr>", desc = "Rust last runs" },
        --   },
        -- },
      },
    },
  },
}
