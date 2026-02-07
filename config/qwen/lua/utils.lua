-- Additional utility configurations
local M = {}

-- Better window movement
M.window_movement = function()
  vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
end

-- Better resizing
M.window_resizing = function()
  vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
  vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
  vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
  vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })
end

-- Better buffer switching
M.buffer_switching = function()
  vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
  vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
  vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
end

-- Better searching
M.searching = function()
  vim.keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
  vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
  vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
  vim.keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
  vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
  vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
end

-- Better yanking
M.yanking = function()
  vim.keymap.set('n', 'Y', 'yg$', { desc = 'Yank to end of line' })
end

-- Better indentation
M.indentation = function()
  vim.keymap.set('v', '<', '<gv', { desc = 'Unindent selection' })
  vim.keymap.set('v', '>', '>gv', { desc = 'Indent selection' })
end

-- Clear highlights
M.clear_highlights = function()
  vim.keymap.set('n', '<leader>nh', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })
end

-- Toggle numbers
M.toggle_numbers = function()
  vim.keymap.set('n', '<leader>n', function()
    if vim.wo.number and vim.wo.relativenumber then
      vim.wo.number = false
      vim.wo.relativenumber = false
    elseif vim.wo.number then
      vim.wo.number = false
      vim.wo.relativenumber = true
    else
      vim.wo.number = true
      vim.wo.relativenumber = true
    end
  end, { desc = 'Toggle line numbers' })
end

-- Toggle spell check
M.toggle_spell = function()
  vim.keymap.set('n', '<leader>us', function()
    vim.wo.spell = not vim.wo.spell
  end, { desc = 'Toggle spelling' })
end

-- Toggle wrap
M.toggle_wrap = function()
  vim.keymap.set('n', '<leader>uw', function()
    vim.wo.wrap = not vim.wo.wrap
  end, { desc = 'Toggle wrap' })
end

-- Toggle paste mode
M.toggle_paste = function()
  vim.keymap.set('n', '<leader>up', function()
    vim.o.paste = not vim.o.paste
  end, { desc = 'Toggle paste mode' })
end

-- Toggle sign column
M.toggle_sign_column = function()
  vim.keymap.set('n', '<leader>ug', function()
    if vim.wo.signcolumn == 'yes' then
      vim.wo.signcolumn = 'no'
    else
      vim.wo.signcolumn = 'yes'
    end
  end, { desc = 'Toggle sign column' })
end

-- Toggle cursor line
M.toggle_cursor_line = function()
  vim.keymap.set('n', '<leader>ul', function()
    vim.wo.cursorline = not vim.wo.cursorline
  end, { desc = 'Toggle cursor line' })
end

-- Toggle color column
M.toggle_color_column = function()
  vim.keymap.set('n', '<leader>uc', function()
    if vim.o.colorcolumn == '80' then
      vim.o.colorcolumn = ''
    else
      vim.o.colorcolumn = '80'
    end
  end, { desc = 'Toggle color column at 80' })
end

-- Quick save and quit
M.quick_save_quit = function()
  vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save file' })
  vim.keymap.set('n', '<C-q>', '<cmd>q<cr>', { desc = 'Quit' })
  vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save file' })
  vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
  vim.keymap.set('n', '<leader>Q', '<cmd>qa<cr>', { desc = 'Quit all' })
  vim.keymap.set('n', '<leader>x', '<cmd>x<cr>', { desc = 'Save and quit' })
end

-- Move lines
M.move_lines = function()
  vim.keymap.set('n', '<A-j>', '<cmd>move .+1<cr>==', { desc = 'Move down' })
  vim.keymap.set('n', '<A-k>', '<cmd>move .-2<cr>==', { desc = 'Move up' })
  vim.keymap.set('i', '<A-j>', '<esc><cmd>move .+1<cr>==gi', { desc = 'Move down' })
  vim.keymap.set('i', '<A-k>', '<esc><cmd>move .-2<cr>==gi', { desc = 'Move up' })
  vim.keymap.set('v', '<A-j>', ":move '>+1<cr>gv=gv", { desc = 'Move down' })
  vim.keymap.set('v', '<A-k>', ":move '<-2<cr>gv=gv", { desc = 'Move up' })
end

-- Better escape
M.better_escape = function()
  vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape' })
  vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Escape' })
end

-- Run all configurations
M.setup = function()
  M.window_movement()
  M.window_resizing()
  M.buffer_switching()
  M.searching()
  M.yanking()
  M.indentation()
  M.clear_highlights()
  M.toggle_numbers()
  M.toggle_spell()
  M.toggle_wrap()
  M.toggle_paste()
  M.toggle_sign_column()
  M.toggle_cursor_line()
  M.toggle_color_column()
  M.quick_save_quit()
  M.move_lines()
  M.better_escape()
end

return M