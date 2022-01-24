local M = {}


M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"



   local servers = { "html", "cssls", "pyright"}

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         -- on_attach = attach,
         on_attach = function(client, bufnr)
        -- disable default lsp formatter
         client.resolved_capabilities.document_formatting = false
      end,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end
   

 lspconfig.tsserver.setup {
      on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formatting = false
      end,
   }


 --lspconfig.tailwindcss.setup{}

--custom float diagnostics 

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

