local M = {}

M.setup_lsp = function(attach, capabilities)
  -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
   local lspconfig = require "lspconfig"
   require("plugins.configs.others").lsp_handlers()
   lspconfig.tsserver.setup {
      on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formatting = false
         vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
      end,
   }

   
   -- lspservers with default config
   local servers = { "html", "cssls", "bashls", "clangd", "pyright" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach =function(client, bufnr)
         client.resolved_capabilities.document_formatting = false
         vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
      end, 
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
