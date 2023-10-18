local opt = vim.opt
vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'fish'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- make tab completion for files/buffers act like bash
opt.wildmenu = true

vim.opt.wildignore = opt.wildignore + {"*/node_modules/*", "*/.git/*", "*/vendor/*"}
-- allow neovim to access the system clipboard
opt.clipboard = "unnamedplus"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }


-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end


-- make function to format buffer

function FormatBuffer()
  local save_cursor = vim.fn.getpos('.')
  local save_view = vim.fn.winsaveview()

  vim.api.nvim_command('normal! ggVG')
  vim.api.nvim_command('normal! ==')
  -- vim.api.nvim_command(':%s/ *$')

  --remove spaces
  -- vim.api.nvim_command(':%s/ *)/)/g')
  -- vim.api.nvim_command(':%s/( */(/g')
  -- vim.api.nvim_command(':%s/ *}/}/g')
  -- vim.api.nvim_command(':%s/{ */{/g')

  vim.fn.setpos('.', save_cursor)
  vim.fn.winrestview(save_view)
end

