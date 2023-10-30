local keymap = vim.keymap
-- set leader key as shortcut for space
vim.g.mapleader = " "
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
--


keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')
-- Delete the rest of the line
keymap.set('n', 'dr', 'd$')
-- correct the rest of the line
keymap.set('n', 'cr', 'c$')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Reload configuration without restart nvim
keymap.set("n", "<leader>r", "<cmd>so %<CR>", {})

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set('n', 'tt', '<cmd>tabedit<Return>')

-- keymap.set("n", "tt", "<cmd>tabnew %<cr>", opts)
keymap.set("n", "tx", "<cmd>tabclose<cr>", opts)
keymap.set("n", "tr", "<cmd>tabonly<cr>", opts)
keymap.set("n", "<Tab>", "<cmd>bnext<CR>", opts)
keymap.set("n", "tn", "<cmd>bnext<CR>", opts)
keymap.set("n", "tp", "<cmd>bprevious<CR>", opts)
-- Split window
keymap.set('n', 'ss', '<cmd>split<Return><C-w>w')
keymap.set('n', 'sv', '<cmd>vsplit<Return><C-w>w')
-- Move window
keymap.set('n', '<leader>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- copy text up and down
-- keymap.set("n", "<C-A-j>", "m`yy<ESC>p``", opt)
-- keymap.set("i", "<C-A-j>", "<ESC>m`yyp``i", opt)
-- keymap.set("n", "<C-A-k>", "m`yy<ESC>[p``", opt)
-- keymap.set("i", "<C-A-k>", "<ESC>m`yy[p``i", opt)

-- move text up and down
-- keymap.set("n", "<A-j>", "<cmd>m +1 <CR>", opt)
-- keymap.set("i", "<A-j>", "<cmd>m +1 <CR>", opt)
-- keymap.set("n", "<A-k>", "<cmd>m -2 <CR>", opt)
-- keymap.set("i", "<A-k>", "<cmd>m -2 <CR>", opt)

-- Drag current line/s vertically and auto-indent
keymap.set('n', '<leader>k', '<cmd>move-2<CR>==', { desc = 'Move line up' })
keymap.set('n', '<leader>j', '<cmd>move+<CR>==', { desc = 'Move line down' })
keymap.set('x', '<leader>k', ":move'<-2<CR>gv=gv", { desc = 'Move selection up' })
keymap.set('x', '<leader>j', ":move'>+<CR>gv=gv", { desc = 'Move selection down' })



-- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
keymap.set('n', '<leader>d', 'm`""Y""P``', { desc = 'Duplicate line' })
keymap.set('x', '<leader>d', '""Y""Pgv', { desc = 'Duplicate selection' })

-- Duplicate paragraph
keymap.set('n', '<leader>cp', 'yap<S-}>p', { desc = 'Duplicate Paragraph' })

-- Remove spaces at the end of lines
keymap.set('n', '<leader>cw', '<cmd>lua MiniTrailspace.trim()<CR>', { desc = 'Erase Whitespace' })

-- exit insert mode
keymap.set("i", "jk", "<ESC>",{desc ='exit insert mode'})

-- save from buffer
keymap.set("v", "z", ":'<,'>w .svg<Left><Left><Left><Left>",{desc ='save text from buffer'})

-- Search & Replace
-- ===
-- Switch */g* and #/g#
keymap.set('n', '*', 'g*')
keymap.set('n', 'g*', '*')
keymap.set('n', '#', 'g#')
keymap.set('n', 'g#', '#')


-- Clear search with <Esc>
keymap.set('n', '<Esc>', '<cmd>noh<CR>', { desc = 'Clear Search Highlight' })


-- Use backspace key for matching parens
keymap.set({ 'n', 'x' }, '<BS>', '%', { remap = true, desc = 'Jump to Paren' })


-- Select last paste
keymap.set('n', 'gpp', "'`['.strpart(getregtype(), 0, 1).'`]'", { expr = true, desc = 'Select Paste' })

-- Quick substitute within selected area
keymap.set('x', 'sg', '<cmd>s//gc<Left><Left><Left>', { desc = 'Substitute Within Selection' })



-- saves and leaves
keymap.set("n", "<leader>q", "<cmd>q <CR>")
keymap.set("n", "<leader>qq", "<cmd>q! <CR>", opt)
keymap.set("n", "<leader>.", "<cmd>q! <CR>", opt)

-- Fast saving from all modes
keymap.set('n', '<leader>s', '<cmd>write<CR>', { desc = 'Save' })
keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>write<CR>', { desc = 'Save' })

-- toggle relative line numbers
keymap.set('n', '<C-n>l', '<cmd>set rnu!<CR>', opt)
keymap.set('n', '<C-n>', '<cmd>set nu!<CR>', opt)


-- plugin maps

-- telescope
keymap.set("n", "<leader>ff", '<cmd>Telescope find_files <CR>')
keymap.set("n", "<leader>fw", '<cmd>Telescope live_grep <CR>')
keymap.set("n", "<leader>fb", '<cmd>Telescope buffers <CR>')
keymap.set("n", "<leader>fo", '<cmd> Telescope oldfiles <CR>')
keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
keymap.set("n", "<leader>bm",  "<cmd> Telescope marks <CR>")
keymap.set("n", "<leader>fq",  "<cmd> Telescope quickfix <CR>")
keymap.set("n", "<leader>fd",  "<cmd> Telescope commands <CR>")
keymap.set("n", "<leader>fs",  "<cmd> Telescope git_status  <CR>")
keymap.set("n", "<leader>fc",  "<cmd> Telescope git_commits  <CR>")
keymap.set("n", "<leader>fz", '<cmd> Telescope current_buffer_fuzzy_find <CR>')

--  local status, telescope = pcall(require, "telescope.builtin")
-- if status then
-- 	-- Telescope
-- 	keymap.set("n", "<leader>ff", telescope.find_files)
-- 	keymap.set("n", "<leader>fg", telescope.live_grep)
-- 	keymap.set("n", "<leader>fb", telescope.buffers)
-- 	keymap.set("n", "<leader>fh", telescope.help_tags)
-- 	keymap.set("n", "<leader>fs", telescope.git_status)
-- 	keymap.set("n", "<leader>fc", telescope.git_commits)
--   keymap.set("n", "<leader>fz", telescope.current_buffer_fuzzy_find)
-- else
-- 	print("Telescope not found")
-- end

-- nvim tree
keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", {}) -- open/close
keymap.set("n", "<leader>nr", "<cmd>NvimTreeRefresh<CR>", {}) -- refresh
keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFile<CR>", {}) -- search file

-- comment
keymap.set("n", "<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment'})
keymap.set("v", "<leader>/", '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment'})

-- format buffer -- the function can be found in base.lua
-- keymap.set('n', '<leader>fm', '<cmd>lua FormatBuffer()<CR>', { desc = 'format buffer' })
keymap.set('n',  '<leader>fm', '<cmd>Format<CR>',{ desc = 'format buffer' })
-- lunch lazy.nvim
keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Open Lazy UI' })
