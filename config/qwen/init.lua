-- Neovim Configuration
-- Author: Qwen Code Assistant
-- Description: A fast, aesthetically pleasing Neovim config with lazy loading
-- Optimized for Neovim 0.11.5 with VS Code-like appearance

-- Performance optimizations
local start_time = vim.loop.hrtime()
vim.loader.enable()

-- More performance optimizations
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' }

-- Set leader key early
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.conceallevel = 0
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.foldmethod = 'manual'
vim.opt.fillchars = { eob = ' ', fold = ' ', foldopen = '', foldclose = '' }

-- Initialize lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup('plugins', {
  defaults = { lazy = true },
  install = { colorscheme = { 'tokyonight', 'habamax' } },
  checker = { enabled = true, notify = false }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = false, -- Use Neovim's optimized startup
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Note: snacks.nvim is configured in the plugins file, no need to set it up here again

-- Load utility configurations
require('utils').setup()

-- Load mobile-specific configurations
require('mobile').setup()

-- Load profiling utilities
require('profile').optimize_for_mobile()

-- Setup lua_ls after plugins are loaded and show startup time
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
    -- Configure lua_ls using the new API after all plugins are loaded
    local lsp_config = require('lsp-config')
    lsp_config.setup_lua_ls()

    -- local stats = require('lazy').stats()
    -- local ms = math.floor((vim.loop.hrtime() - start_time) / 1000000)
    -- print(string.format('[%s] Plugin count: %s, Startup time: %s ms', 'LazyVim', stats.count, ms))
  end,
})
