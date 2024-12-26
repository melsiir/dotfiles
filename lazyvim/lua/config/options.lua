-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
vim.g.transparent_enabled = true
opt.relativenumber = false -- Relative line numbers
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- opt.confirm = false -- Confirm to save changes before exiting modified buffer
opt.cursorline = false -- Enable highlighting of the current line
-- opt.wrap = true -- Disable line wrap
-- opt.arabic = true
opt.foldcolumn = '1'    -- '0' is not bad
opt.foldlevel = 99      -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldenable = true   -- Enable folding
opt.updatetime = 300    -- Faster completion
