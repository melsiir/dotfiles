require("plugins.configs.others").lsp_handlers()

local function on_attach(_, bufnr)
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   -- Enable completion triggered by <c-x><c-o>
   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
   require("core.mappings").lspconfig()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require "lspconfig"


--custom float diagnostics 

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      signs = true,
 })

--vim.cmd "autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()"
vim.cmd "autocmd CursorHold * lua vim.diagnostic.open_float()"
vim.cmd "autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()"




-- lspservers with default config
local servers = { "html", "cssls", "tsserver","pyright", "sumneko_lua" }

for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
         debounce_text_changes = 150,
      },
   }
end
