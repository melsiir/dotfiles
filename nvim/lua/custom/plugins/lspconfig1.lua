local M = {}

M.setup_lsp = function(attach, capabilities)
   local function on_attach(client, bufnr)
      local function buf_set_option(...)
         vim.api.nvim_buf_set_option(bufnr, ...)
         -- disable default lsp formater cause i want to us null.ls
         client.resolved_capabilities.document_formatting = false
      end

      -- Enable completion triggered by <c-x><c-o>
      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
      require("core.mappings").lspconfig()
   end

   local lspconfig = require "lspconfig"

   lspconfig.tsserver.setup {
      on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formatting = false
         vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
      end,
   }

   local servers = { "html", "cssls", "pyright", "sumneko_lua" },

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end

   vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      signs = true,
   })

   --vim.cmd "autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()"
   vim.cmd "autocmd CursorHold * lua vim.diagnostic.open_float()"
   vim.cmd "autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()"
end

return M
