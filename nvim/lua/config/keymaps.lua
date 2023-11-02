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

-- maps are automatically loaded on the VeryLazy event
-- Default maps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional maps here

local map = vim.keymap.set

-- Delete a word backwards
-- map('n', 'dw', 'vb"_d', {desc = "Delete a word backwards"})
-- -- Delete the rest of the line
-- map('n', 'dr', 'd$', {desc = "Delete the rest of the line"})
-- -- correct the rest of the line
-- map('n', 'cr', 'c$', {desc = "correct the rest of the line"})

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Split window
-- map('n', 'ss', '<cmd>split<Return><C-w>w')
-- map('n', 'sv', '<cmd>vsplit<Return><C-w>w')

-- Drag current line/s vertically and auto-indent
map("n", "<leader>k", "<cmd>move-2<CR>==", { desc = "Move line up" })
map("n", "<leader>j", "<cmd>move+<CR>==", { desc = "Move line down" })
map("x", "<leader>k", ":move'<-2<CR>gv=gv", { desc = "Move selection up" })
map("x", "<leader>j", ":move'>+<CR>gv=gv", { desc = "Move selection down" })

-- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
map("n", "<leader>d", 'm`""Y""P``', { desc = "Duplicate line" })
map("x", "<leader>d", '""Y""Pgv', { desc = "Duplicate selection" })

-- Duplicate paragraph
map("n", "<leader>cp", "yap<S-}>p", { desc = "Duplicate Paragraph" })

-- save from buffer
map("v", "z", ":'<,'>w .svg<Left><Left><Left><Left>", { desc = "save text from buffer" })

--tab management
map("n", "<Tab>", "<cmd>BufferNext<CR>", { desc = "switch between tabs" })
map("n", "tc", "<cmd>BufferClose<cr>", { desc = "Close Tab" })
map("n", "tp", "<cmd>BufferPin<CR>", opts)
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

-- Select last paste
map("n", "gpp", "'`['.strpart(getregtype(), 0, 1).'`]'", { expr = true, desc = "Select Paste" })

-- Quick substitute within selected area
map("x", "sg", "<cmd>s//gc<Left><Left><Left>", { desc = "Substitute Within Selection" })

map({ "n", "x" }, "<BS>", "%", { remap = true, desc = "Jump to Paren" })

-- saves and leaves
map("n", "<leader>qw", "<cmd>wq <CR>", { desc = "save and exit" })
map("n", "<leader>qa", "<cmd>q! <CR>", { desc = "quiet without confirmation!" })

-- comment
-- map('n', '<leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle comment' })
-- map('v', '<leader>/', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle comment' })

-- format buffer -- the function can be found in base.lua
-- map('n', '<leader>fm', '<cmd>lua FormatBuffer()<CR>', { desc = 'format buffer' })
map("n", "<leader>fm", '<cmd>lua require("conform").format()<CR>', { desc = "format buffer" })
