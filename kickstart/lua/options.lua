-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- vim.o.cmdheight = 0

vim.o.wrap = false -- No Wrap lines

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

function ftyle()
  local v = vim.api.nvim_buf_get_name(0)
  -- print(vim.fn.executable 'clang')
  print(v)
end
-- make function to format buffer

function FormatBuffer()
  local currentFileType = vim.bo.filetype
  local save_cursor = vim.fn.getpos '.'
  local save_view = vim.fn.winsaveview()
  -- the % will apply the command to entire buffer
  if currentFileType == 'fish' then
    vim.api.nvim_command ':%!fish_indent'
  elseif vim.fn.executable 'shfmt' == 1 and currentFileType == 'sh' then
    vim.api.nvim_command ':%!shfmt'
  elseif vim.fn.executable 'stylua' == 1 and currentFileType == 'lua' then
    vim.api.nvim_command ':%!stylua - --indent-type Spaces --indent-width 2 --call-parentheses None --quote-style AutoPreferDouble'
  elseif vim.fn.executable 'jq' == 1 and currentFileType == 'json' then
    vim.api.nvim_command ':%!jq'
  else
    vim.api.nvim_command 'normal! ggVG'
    vim.api.nvim_command 'normal! =='
    -- vim.api.nvim_command(':%s/ *$')
  -- remove white space at the end of lines
    vim.api.nvim_command(':%s/\\s\\+$//e')

    --remove spaces
    -- vim.api.nvim_command(':%s/ *)/)/g')
    -- vim.api.nvim_command(':%s/( */(/g')
    -- vim.api.nvim_command(':%s/ *}/}/g')
    -- vim.api.nvim_command(':%s/{ */{/g')
  end
  --return to where you were before formating
  vim.fn.setpos('.', save_cursor)
  vim.fn.winrestview(save_view)
end
