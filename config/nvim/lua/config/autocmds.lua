-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for lua files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "lua" },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })

vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
-- launch alpha if user closed all buffers
vim.api.nvim_create_autocmd({ "BufDelete" }, {
  group = "alpha_on_empty",
  callback = function()
    if vim.fn.bufname() == "" then
      vim.cmd("Alpha")
    end
  end,
})
