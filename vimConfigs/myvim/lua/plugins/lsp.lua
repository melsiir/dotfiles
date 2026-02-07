-- ========================
-- LSP basics
-- ========================

-- Keymaps
local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>cl", function()
    Snacks.picker.lsp_config()
  end, "Lsp Info")
  map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
  map("n", "gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("n", "K", function()
    return vim.lsp.buf.hover()
  end, "Hover")
  map("n", "gK", function()
    return vim.lsp.buf.signature_help()
  end, "Signature Help")
  map("n", "<c-k>", function()
    return vim.lsp.buf.signature_help()
  end, "Signature Help")
  map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")
  map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
  map("n", "<leader>cR", function()
    Snacks.rename.rename_file()
  end, "Rename File")
  map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
end

-- Capabilities (nvim-cmp compatible)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, "blink.cmp")
if ok then
  capabilities = blink.get_lsp_capabilities()
else
end

-- ========================
-- Diagnostics
-- ========================

vim.diagnostic.config({
  virtual_text = {
    prefix = "", -- Use ● instead of icons for better compatibility
    spacing = 4,
    source = "if_many",
  },
  float = {
    border = "rounded",
    source = true,
    focusable = false,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
})

-- ========================
-- Plugins
-- ========================

return {
  -- Mason: installs servers
  {

    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ui = {
        -- width = 1,
        -- height = 1,

        border = "rounded",
        icons = {
          package_installed = " ",
          package_pending = " ",
          package_uninstalled = " ",
        },
      },
    },
  },
  -- Mason → Neovim LSP
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- automaticlly enable every lsp downloaded by mason even if not configured
      automatic_enable = false,
      lspensure_installed = {
        -- "lua_ls",
        "pyright",
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
        "bashls",
        "eslint",
      },
    },
  },

  -- Native Neovim 0.11 LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Default config for most servers
      local default = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- Register servers using vim.lsp.config (NEW)
      vim.lsp.config("pyright", default)
      vim.lsp.config("ts_ls", default)
      vim.lsp.config("html", default)
      vim.lsp.config("cssls", default)
      vim.lsp.config("jsonls", default)
      vim.lsp.config("bashls", default)

      -- Lua (Neovim specific)
      vim.lsp.config("lua_ls", {
        filetypes = { "lua" },
        root_markers = { ".git", ".luarc.json", ".luarc.jsonc" },

        on_attach = on_attach,
        capabilities = capabilities,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      })
      --manully enable the lsp
      vim.lsp.enable("lua_ls")
      -- ESLint (fix on save)
      vim.lsp.config("eslint", {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })
    end,
  },
}
