-- LSP Configuration for Neovim 0.11.5
local M = {}

-- Common on_attach function
M.on_attach = function(client, bufnr)
  -- Disable semantic highlighting if the client supports it to improve performance
  if client.supports_method 'textDocument/semanticTokens/full' then
    client.server_capabilities.semanticTokensProvider = nil
  end

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP functionality keymaps
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP declaration' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP definition' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP hover' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP implementation' })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP signature help' })
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = 'LSP add workspace folder' })
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = 'LSP remove workspace folder' })
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, desc = 'LSP list workspace folders' })
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP type definition' })
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP rename' })
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP code action' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'LSP references' })
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, { buffer = bufnr, desc = 'LSP format' })

  -- Enable inlay hints if available
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

-- Get capabilities from blink.cmp
M.get_capabilities = function()
  local capabilities = require('blink.cmp').get_lsp_capabilities()
  return capabilities
end

-- Configure and enable lua_ls using the new API
M.setup_lua_ls = function()
  local capabilities = M.get_capabilities()
  
  -- Register lua_ls configuration using the new vim.lsp.config API
  vim.lsp.config.lua_ls = {
    on_attach = M.on_attach,
    capabilities = capabilities,
    handlers = {
      ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
      ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
    },
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
        telemetry = { enable = false },
      },
    },
  }
  
  -- Enable the lua_ls server
  vim.lsp.enable("lua_ls")
end

return M