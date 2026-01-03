-- Modernized LSP configuration for Neovim
local on_attach = function(client, bufnr)
  local function buf_set_keymap(mode, lhs, rhs, opts)
    opts = vim.F.npcall(vim.tbl_extend, "force", { noremap = true, silent = true }, opts) or
        { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  -- Keymaps for LSP functionality (using leader key as in original config)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "Goto Declaration" })
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Goto Definition" })
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "Goto Implementation" })
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Goto Type Definition" })
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "Hover" })
  buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature Help" })
  buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "Signature Help" })
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "References" })
  buf_set_keymap({ 'n', 'v' }, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code Action" })
  buf_set_keymap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "Rename" })
  buf_set_keymap('n', '<leader>ds', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', { desc = "Document Symbols" })
  buf_set_keymap('n', '<leader>ws', '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>', { desc = "Workspace Symbols" })
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { desc = "Add Workspace Folder" })
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { desc = "Remove Workspace Folder" })
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { desc = "List Workspace Folders" })
  buf_set_keymap('n', '<leader>cl', '<cmd>LspInfo<CR>', { desc = "Lsp Info" })
  buf_set_keymap({ 'n', 'v' }, '<leader>cc', '<cmd>lua vim.lsp.codelens.run()<CR>', { desc = "Run Codelens" })
  buf_set_keymap('n', '<leader>cC', '<cmd>lua vim.lsp.codelens.refresh()<CR>', { desc = "Refresh & Display Codelens" })

  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- Enable code lens if supported
  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
    })
  end
end

-- Setup diagnostic signs with the same icons as the original config
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Configure diagnostics appearance
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Use ● instead of icons for better compatibility
    spacing = 4,
    source = "if_many",
  },
  float = {
    border = "rounded",
    source = true,
    focusable = false,
  },
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
})

return {
  -- Mason (package manager for LSP servers, DAP servers, linters, and formatters)
  {
    "mason-org/mason.nvim",
    lazy = false,
    priority = 999,
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
    end,
  },

  -- Mason LSP Configuration
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "neovim/nvim-lspconfig",
      -- Use appropriate completion plugin capabilities based on user preference
      vim.g.blinkcmp and "saghen/blink.cmp" or { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp" },
    },
    opts = {
      ensure_installed = {
        -- Language servers
        -- "lua_ls",
        "pyright",
        "ts_ls", -- For JavaScript/TypeScript (tsserver was renamed to ts_ls in newer versions)
        "html",
        "cssls",
        "jsonls",
        "emmet_language_server",
        -- "clangd", -- For C/C++
        "bashls",
        "dockerls",
        "eslint",
        -- "marksman", -- For Markdown
      },
      -- Mason-lspconfig provides a wrapper around lspconfig to auto-configure language servers
      -- It provides the `ensure_installed` option to automatically install servers
      handlers = {
        -- Default handler
        function(server_name)
          local capabilities
          if vim.g.blinkcmp then
            -- Use Blink CMP capabilities
            local has_blink, blink = pcall(require, "blink.cmp")
            capabilities = has_blink and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
          else
            -- Use Mag-nvim-lsp capabilities (which appears as cmp_nvim_lsp)
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            capabilities = has_cmp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
          end

          require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            },
          }
        end,

        -- Specific server configurations
        ["lua_ls"] = function()
          local capabilities
          if vim.g.blinkcmp then
            -- Use Blink CMP capabilities
            local has_blink, blink = pcall(require, "blink.cmp")
            capabilities = has_blink and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
          else
            -- Use Mag-nvim-lsp capabilities (which appears as cmp_nvim_lsp)
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            capabilities = has_cmp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
          end

          require("lspconfig").lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                },
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          }
        end,

        ["pyright"] = function()
          local capabilities
          if vim.g.blinkcmp then
            -- Use Blink CMP capabilities
            local has_blink, blink = pcall(require, "blink.cmp")
            capabilities = has_blink and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
          else
            -- Use Mag-nvim-lsp capabilities (which appears as cmp_nvim_lsp)
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            capabilities = has_cmp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
          end

          require("lspconfig").pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "python" },
          }
        end,

        ["ts_ls"] = function()
          local capabilities
          if vim.g.blinkcmp then
            -- Use Blink CMP capabilities
            local has_blink, blink = pcall(require, "blink.cmp")
            capabilities = has_blink and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
          else
            -- Use Mag-nvim-lsp capabilities (which appears as cmp_nvim_lsp)
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            capabilities = has_cmp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
          end

          require("lspconfig").ts_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
          }
        end,

        ["eslint"] = function()
          local capabilities
          if vim.g.blinkcmp then
            -- Use Blink CMP capabilities
            local has_blink, blink = pcall(require, "blink.cmp")
            capabilities = has_blink and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
          else
            -- Use Mag-nvim-lsp capabilities (which appears as cmp_nvim_lsp)
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            capabilities = has_cmp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
          end

          require("lspconfig").eslint.setup {
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
              on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            settings = {
              codeAction = {
                disableRuleComment = {
                  enable = true,
                  location = "separateLine",
                },
                showDocumentation = {
                  enable = true,
                },
              },
              codeActionOnSave = {
                enable = true,
                mode = "all",
              },
              format = {
                enable = true,
              },
              nodePath = "",
              packageManager = "npm",
              quiet = false,
              rulesCustomizations = {},
              run = "onType",
              useESLintClass = false,
              validate = "on",
              workingDirectory = {
                mode = "auto",
              },
            },
          }
        end,
      },
    },
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Configure hover window borders
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "rounded",
        }
      )

      -- Configure signature help borders
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = "rounded",
        }
      )

      -- Enable inlay hints if supported (for Neovim 0.10+)
      if vim.lsp.inlay_hint then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
          end,
        })
      end
    end,
  },
}

