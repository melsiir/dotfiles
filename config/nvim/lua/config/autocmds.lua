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

-- nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- pattern = { "r", "rmd" },
--   command = [[:%s/\s\+$//e]],
--   group = TrimWhiteSpaceGrp,
-- })


-- goto dashboard_on_empty gemini after with some edits
-- vim.api.nvim_create_autocmd("BufDelete", {
--   group = vim.api.nvim_create_augroup("bufdelpost_autocmd", {}),
--   desc = "BufDeletePost User autocmd",
--   callback = function()
--     local bufs = vim.fn.getbufinfo({ buflisted = true })
--     -- open alpha if no buffers are left
--     if bufs[1] ~= nil then
--       vim.cmd([[:Alpha | bd#]])
--     end
--   end,
-- })
------------------------
vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("bufdelpost_autocmd", {}),
  desc = "BufDeletePost User autocmd",
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", {
        pattern = "BufDeletePost",
      })
    end)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BufDeletePost",
  group = vim.api.nvim_create_augroup("dashboard_delete_buffers", {}),
  desc = "Open Dashboard when no available buffers",
  callback = function(ev)
    local deleted_name = vim.api.nvim_buf_get_name(ev.buf)
    local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
    local deleted_bt = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
    local dashboard_on_empty = deleted_name == "" and deleted_ft == "" and deleted_bt == ""

    if dashboard_on_empty then
      vim.cmd([[:Alpha | bd#]])
    end
  end,
})
