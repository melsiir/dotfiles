-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- globals
vim.g.user_is_termux = vim.env.TERMUX_VERSION ~= nil
vim.g.transparent_enabled = true
vim.g.default_screen = false -- uses default neovim welcome screen instead of dashboard

local opt = vim.opt
opt.swapfile = false -- disable swap file because they anoying me
