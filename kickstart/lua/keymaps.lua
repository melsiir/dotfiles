-- Shorten function name
local keymap = vim.keymap.set
-- See `:help vim.keymap.set()`
-- Silent keymap option
local opts = { silent = true }
keymap('', '<Space>', '<Nop>', opts)
--Remap space as leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- neovim stocks maps
-- w - jump curser to the next word
-- -- o - append newline from normal mode
-- fs - jump to the next s
-- dd - to delete the entire line.
-- u - undo
-- ctrl-r - redo
-- rx - replace letter in the curser with x
-- p - paste deleted text after curser
-- ce - to correct words
-- ctrl-g - show the position of the curser in the file
-- gg -- go to the start of the file
-- 500gg -- go to the line number 500
-- G - go to the end of the file
-- % - jump to closing parenthies
-- / - search text - n - go to next result -- N - go to previous result
-- : %s/old/new/g - substitute "new" for  "old" in all accurance in the file
-- : %s/old/new/ - substitute "new" for "old" in every first match in every line
-- : s/old/new/ - substitute "new" for "old" only in the first match
-- : 2,6s/old/new/g - substitue new for old in all accurance between line 2 and line 6.
-- use gcc to comment with comment.nvim

--------------------------------------------

keymap('n', 'x', '"_x')

-- Increment/decrement
keymap('n', '+', '<C-a>')
keymap('n', '-', '<C-x>')

-- Delete a word backwards
keymap('n', 'dw', 'vb"_d')
-- Delete the rest of the line
keymap('n', 'dr', 'd$')
-- correct the rest of the line
keymap('n', 'cr', 'c$')

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G')

-- Reload configuration without restart nvim
keymap('n', '<leader>r', '<cmd>so %<CR>', {})

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap('n', 'tt', '<cmd>tabedit<Return>')

-- keymap("n", "tt", "<cmd>tabnew %<cr>", opts)
keymap('n', 'tc', '<cmd>BufferClose<cr>', opts)
keymap('n', 'trs', '<cmd>>BufferRestore<cr>', opts)
keymap('n', 'tr', '<cmd>tabonly<cr>', opts)
keymap('n', '<Tab>', '<cmd>BufferNext<CR>', opts)
keymap('n', 'tn', '<cmd>BufferNext<CR>', opts)
-- keymap("n", "tp", "<cmd>BufferPrevious<CR>", opts)
keymap('n', 'tp', '<cmd>BufferPin<CR>', opts)
keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Split window
keymap('n', 'ss', '<cmd>split<Return><C-w>w')
keymap('n', 'sv', '<cmd>vsplit<Return><C-w>w')
-- Move window
keymap('n', '<leader>', '<C-w>w')
keymap('', 'sh', '<C-w>h')
keymap('', 'sk', '<C-w>k')
keymap('', 'sj', '<C-w>j')
keymap('', 'sl', '<C-w>l')

-- Resize window
keymap('n', '<C-w><left>', '<C-w><')
keymap('n', '<C-w><right>', '<C-w>>')
keymap('n', '<C-w><up>', '<C-w>+')
keymap('n', '<C-w><down>', '<C-w>-')

-- copy text up and down
-- keymap("n", "<C-A-j>", "m`yy<ESC>p``", opt)
-- keymap("i", "<C-A-j>", "<ESC>m`yyp``i", opt)
-- keymap("n", "<C-A-k>", "m`yy<ESC>[p``", opt)
-- keymap("i", "<C-A-k>", "<ESC>m`yy[p``i", opt)

-- move text up and down
-- keymap("n", "<A-j>", "<cmd>m +1 <CR>", opt)
-- keymap("i", "<A-j>", "<cmd>m +1 <CR>", opt)
-- keymap("n", "<A-k>", "<cmd>m -2 <CR>", opt)
-- keymap("i", "<A-k>", "<cmd>m -2 <CR>", opt)

-- Drag current line/s vertically and auto-indent
keymap('n', '<leader>k', '<cmd>move-2<CR>==', { desc = 'Move line up' })
keymap('n', '<leader>j', '<cmd>move+<CR>==', { desc = 'Move line down' })
keymap('x', '<leader>k', ":move'<-2<CR>gv=gv", { desc = 'Move selection up' })
keymap('x', '<leader>j', ":move'>+<CR>gv=gv", { desc = 'Move selection down' })

-- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
keymap('n', '<leader>d', 'm`""Y""P``', { desc = 'Duplicate line' })
keymap('x', '<leader>d', '""Y""Pgv', { desc = 'Duplicate selection' })

-- Duplicate paragraph
keymap('n', '<leader>cp', 'yap<S-}>p', { desc = 'Duplicate Paragraph' })

-- Remove spaces at the end of lines
keymap('n', '<leader>cw', '<cmd>lua MiniTrailspace.trim()<CR>', { desc = 'Erase Whitespace' })

-- exit insert mode
keymap('i', 'jk', '<ESC>', { desc = 'exit insert mode' })

-- save from buffer
keymap('v', 'z', ":'<,'>w .svg<Left><Left><Left><Left>", { desc = 'save text from buffer' })

-- Search & Replace
-- ===
-- Switch */g* and #/g#
keymap('n', '*', 'g*')
keymap('n', 'g*', '*')
keymap('n', '#', 'g#')
keymap('n', 'g#', '#')

-- Clear search with <Esc>
keymap('n', '<Esc>', '<cmd>noh<CR>', { desc = 'Clear Search Highlight' })

-- Use backspace key for matching parens
keymap({ 'n', 'x' }, '<BS>', '%', { remap = true, desc = 'Jump to Paren' })

-- Select last paste
keymap('n', 'gpp', "'`['.strpart(getregtype(), 0, 1).'`]'", { expr = true, desc = 'Select Paste' })

-- Quick substitute within selected area
keymap('x', 'sg', '<cmd>s//gc<Left><Left><Left>', { desc = 'Substitute Within Selection' })

-- saves and leaves
keymap('n', '<leader>q', '<cmd>q <CR>')
keymap('n', '<leader>qq', '<cmd>q! <CR>', opt)
keymap('n', '<leader>.', '<cmd>q! <CR>', opt)

-- Fast saving from all modes
keymap('n', '<leader>s', '<cmd>write<CR>', { desc = 'Save' })
keymap({ 'n', 'i', 'v' }, '<C-s>', '<cmd>write<CR>', { desc = 'Save' })

-- toggle relative line numbers
keymap('n', '<C-n>l', '<cmd>set rnu!<CR>', opt)
keymap('n', '<C-n>', '<cmd>set nu!<CR>', opt)

-- plugin maps

-- telescope
keymap('n', '<leader>ff', '<cmd>Telescope find_files <CR>', {desc = "find files"})
keymap('n', '<leader>fw', '<cmd>Telescope live_grep <CR>', {desc = "find word in directory"})
keymap('n', '<leader>fb', '<cmd>Telescope buffers <CR>' ,{desc = "find in current buffer"})
keymap('n', '<leader>fo', '<cmd> Telescope oldfiles <CR>', {desc = "find old files"})
keymap('n', '<leader>fg', '<cmd> Telescope find_files ({cwd="$HOME/.config/nvim"}) <CR>', {desc = "find config"})
keymap('n', '<leader>ft', '<cmd> lua require("telescope.builtin").find_files({cwd="$HOME/.config/nvim"}) <CR>', {desc = "find config"})
keymap('n', '<leader>fr', '<cmd> Telescope resume <CR>', {desc = "resume your last work"})
keymap('n', '<leader>fh', '<cmd> Telescope help_tags <CR>', {desc = "find help tags"})
keymap('n', '<leader>bm', '<cmd> Telescope marks <CR>', {desc = "find bookmarks"})
keymap('n', '<leader>fq', '<cmd> Telescope quickfix <CR>', {desc = "find quickfix"})
keymap('n', '<leader>fd', '<cmd> Telescope commands <CR>', {desc = "find commands"})
keymap('n', '<leader>fs', '<cmd> Telescope git_status  <CR>', {desc = "find git status"})
keymap('n', '<leader>fc', '<cmd> Telescope git_commits  <CR>', {desc = "find git commits"})
keymap('n', '<leader>fz', '<cmd> Telescope current_buffer_fuzzy_find <CR>', {desc = "fuzzy find in current buffer"})
-- vim.keymap.set('n', '<leader>fk', require('telescope.builtin').find_files({cwd="config"}), { desc = '[S]earch [c]onfig' })
--  local status, telescope = pcall(require, "telescope.builtin")
-- if status then
-- 	-- Telescope
-- 	keymap("n", "<leader>ff", telescope.find_files)
-- 	keymap("n", "<leader>fg", telescope.live_grep)
-- 	keymap("n", "<leader>fb", telescope.buffers)
-- 	keymap("n", "<leader>fh", telescope.help_tags)
-- 	keymap("n", "<leader>fs", telescope.git_status)
-- 	keymap("n", "<leader>fc", telescope.git_commits)
--   keymap("n", "<leader>fz", telescope.current_buffer_fuzzy_find)
-- else
-- 	print("Telescope not found")
-- end

-- nvim neo-tree
keymap('n', '<leader>n', '<cmd>Neotree toggle<CR>', {}) -- open/close
keymap('n', '<leader>nr', '<cmd>NvimTreeRefresh<CR>', {}) -- refresh
keymap('n', '<leader>nf', '<cmd>NvimTreeFindFile<CR>', {}) -- search file

-- keymap("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", {}) -- open/close
-- keymap("n", "<leader>nr", "<cmd>NvimTreeRefresh<CR>", {}) -- refresh
-- keymap("n", "<leader>nf", "<cmd>NvimTreeFindFile<CR>", {}) -- search file

-- comment
keymap('n', '<leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
keymap('v', '<leader>/', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment' })

-- format buffer -- the function can be found in base.lua
-- keymap('n', '<leader>fm', '<cmd>lua FormatBuffer()<CR>', { desc = 'format buffer' })
keymap('n', '<leader>fm', '<cmd>lua require("conform").format()<CR>', { desc = 'format buffer' })

-- lunch lazy.nvim
keymap('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Open Lazy UI' })


-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


