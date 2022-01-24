local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local lspconfig = require "lspconfig"

local M = {}
local formatting = null_ls.builtins.formatting

-- local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity

M.setup = function()
      null_ls.setup {
  -- debug = false,
  sources = {
    -- formatting.eslint_d,
    formatting.prettierd,
    -- .with {
    --   filetypes = {
    --     "javascript",
    --     "javascriptreact",
    --     "typescript",
    --     "typescriptreact",
    --     "vue",
    --     "css",
    --     "scss",
    --     "less",
    --     "html",
    --     "json",
    --     "yaml",
    --     "markdown",
    --     "graphql",
    --     -- "solidity",
    formatting.black.with { extra_args = { "--fast" },
  },
  formatting.stylua,
  
     },
      -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    }
end


return M
	
