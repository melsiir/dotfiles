vim.diagnostic.config({
  float = {
    source = true,
    focusable = false,
    header = { "   Diagnostics",
      "String"
    },
    border = "rounded",
  },
  wrap = true,
})
return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },

    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- Enable lsp cursor word highlighting
        document_highlight = {
          enabled = true,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            enabled = true,
            mason = not vim.env.TERMUX_VERSION,
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                -- diagnostics = {
                --   globals = { "vim" },
                -- },
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
          },
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
          marksman = {
            --do not install with mason
            enabled = false,
            mason = not vim.env.TERMUX_VERSION,
          },
          markdownlint_cli2 = {
            enabled = false,
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
          efm = {
            --do not install with mason
            mason = false,
            enabled = false,
          },
          -- shfmt = {
          --   mason = false,
          -- },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,

    config = function(_, opts)
      local icons = {
        diagnostics = {
          Error = " ",
          Warn = " ",
          Hint = "󰌵 ",
          Info = " ",
          Information = " ",
        },
      }

      -- diagnostics
      for name, icon in pairs(icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
            or function(diagnostic)
              for d, icon in pairs(icons.diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                  return icon
                end
              end
            end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        -- Create a function that lets us more easily define mappings specific LSP related items.
        -- It sets the mode, buffer and description for us each time.
        callback = function(event)
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
          map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
          map("n", "gr", vim.lsp.buf.references, "References")
          map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
          map("n", "gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
          map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")
          map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
          map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
          map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols") --
          map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
          map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
          map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "Workspace List Folders")
          map("n", "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, "Next Reference")
          map("n", "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, "Prev Reference")

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Ensure the servers and tools above are installed
      -- require("mason").setup()
      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {}
      -- vim.list_extend(ensure_installed, {
      -- 	"stylua", -- Used to format lua code
      -- })
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = vim.tbl_deep_extend(
            "force",
            ensure_installed,
            {}
          -- LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
          ),
          handlers = { setup },
        })
      end

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ui = {
        -- width = 1,
        -- height = 1,

        border = "rounded",
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = " ",
        }
      },
      ensure_installed = {
        -- "stylua",
        "shfmt",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
