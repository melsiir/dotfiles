-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/

-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>qq", ":q! <CR>", opt)
map("n", "<leader>,", ":q! <CR>", opt)
map("n", "<leader>zm", ":TZMinimalist <CR>", opt)
map("n", "<leader>zz", ":TZAtaraxis <CR>", opt)
map("n", "<leader>zf", ":TZFocus <CR>", opt)
-- move text up and down
map("n", "<A-j>", ":m +1 <CR>", opt)
map("i", "<A-j>", ":m +1 <CR>", opt)
map("n", "<A-k>", ":m -2 <CR>", opt)
map("i", "<A-k>", ":m -2 <CR>", opt)
-- copy text up and down
map("n", "<C-A-j>", "m`yy<ESC>p``", opt)
map("i", "<C-A-j>", "<ESC>m`yyp``i", opt)
map("n", "<C-A-k>", "m`yy<ESC>[p``", opt)
map("i", "<C-A-k>", "<ESC>m`yy[p``i", opt)
map("n", "<leader>ft", ":lua vim.lsp.buf.formatting() <CR>", opt)
map("n", "<leader>fp", ":Telescope projects<CR>", opt)
map("n", "<leader>gl", ":Glow <CR>", opt)

-- NOTE: the 4th argument in the map function is be a table i.e options but its most likely un-needed so dont worry about it

