-- This file is automatically loaded by lazyvim.config.init
-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", "<cmd>bdelete!<CR>", { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting
-- map({ "n", "v" }, "<leader>cf", function()
--   LazyVim.format({ force = true })
-- end, { desc = "Format" })
--
-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start
map("n", "<leader>uh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end, {desc = "toggle lsp hints"})
map("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end,{desc= "toggle lsp diagnostics"})
map("n", "<leader>uf", function()
  vim.g.autoformat = not vim.g.autoformat
end, {desc = "toggle autoformat"})
map("n", "<leader>ul", "<cmd>set wrap!<CR>", { desc = "toggle wordwrap" })
map("n", "<leader>un", "<cmd>set number!<CR>", { desc = "toggle line number" })
map("n", "<leader>uz", "<cmd>set relativenumber!<CR>", { desc = "toggle relativenumber" })

-- toggle options
-- LazyVim.toggle.map("<leader>uf", LazyVim.toggle.format())
-- LazyVim.toggle.map("<leader>uF", LazyVim.toggle.format(true))
-- LazyVim.toggle.map("<leader>us", LazyVim.toggle("spell", { name = "Spelling" }))
-- LazyVim.toggle.map("<leader>uw", LazyVim.toggle("wrap", { name = "Wrap" }))
-- LazyVim.toggle.map("<leader>uL", LazyVim.toggle("relativenumber", { name = "Relative Number" }))
-- LazyVim.toggle.map("<leader>ud", LazyVim.toggle.diagnostics)
-- LazyVim.toggle.map("<leader>ul", LazyVim.toggle.number)
-- LazyVim.toggle.map( "<leader>uc", LazyVim.toggle("conceallevel", { values = { 0, vim.o.conceallevel > 0 and vim.o.conceallevel or 2 } }))
-- LazyVim.toggle.map("<leader>uT", LazyVim.toggle.treesitter)
-- LazyVim.toggle.map("<leader>ub", LazyVim.toggle("background", { values = { "light", "dark" }, name = "Background" }))
-- if vim.lsp.inlay_hint then
--   LazyVim.toggle.map("<leader>uh", LazyVim.toggle.inlay_hints)
-- end
--
-- lazygit
-- map("n", "<leader>gg", function() LazyVim.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
-- map("n", "<leader>gG", function() LazyVim.lazygit() end, { desc = "Lazygit (cwd)" })
-- map("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
-- map("n", "<leader>gB", LazyVim.lazygit.browse, { desc = "Git Browse" })

-- map("n", "<leader>gf", function()
--   local git_path = vim.api.nvim_buf_get_name(0)
--   LazyVim.lazygit({args = { "-f", vim.trim(git_path) }})
-- end, { desc = "Lazygit Current File History" })
--
-- map("n", "<leader>gl", function()
--   LazyVim.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
-- end, { desc = "Lazygit Log" })
-- map("n", "<leader>gL", function()
--   LazyVim.lazygit({ args = { "log" } })
-- end, { desc = "Lazygit Log (cwd)" })
--
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- LazyVim Changelog
-- map("n", "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })


-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
-- LazyVim.toggle.map("<leader>wm", LazyVim.toggle.maximize)

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- tab management bufferline
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "switch between tabs" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "switch between tabs" })



--note
--press shift k to  open certain function or method documentation
--press shift and k again to focus on the documentation so you can browse
--the documentation with motions


-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
map("n", "<leader>dd", 'm`""Y""P``', { desc = "Duplicate line" })
map("x", "<leader>dd", '""Y""Pgv', { desc = "Duplicate selection" })

-- Duplicate paragraph
map("n", "<leader>dp", "yap<S-}>p", { desc = "Duplicate Paragraph" })
-- delete paragraph
map("n", "<leader>de", "dap", { desc = "Delete Paragraph" })
--copy paragraph
map("n", "<leader>cp", "yap", { desc = "copy Paragraph" })

-- leaves
map("n", "<leader>qw", "<cmd>wq <CR>", { desc = "save and exit" })
map("n", "<leader>qq", "<cmd>q! <CR>", { desc = "quiet without confirmation!" })

-- Select last paste
map("n", "gpp", "'`['.strpart(getregtype(), 0, 1).'`]'", { expr = true, desc = "Select Paste" })

-- Quick substitute within selected area
-- map("x", "sg", "<cmd>s//gc<Left><Left><Left>", { desc = "Substitute Within Selection" })
-- jump to crossponding parenthess
map({ "n", "x", "v", "s" }, "<BS>", "%", { remap = true, desc = "Jump to Paren" })

-- delete single character without copying into register
map("n", "x", '"_x')

--if you selected text and tried to replace it with text from clipboard neovim will save the selected
--text to the clipboard this key map will disable this behavier
-- Keep last yanked when pasting
map("v", "p", '"_dP', { desc = "Keep last yanked when pasting" })

-- open the current file in external editor
map("n", "<leader>o", "<cmd>!open % <CR>", { desc = "open in external editor" })

-- [,* ] Search and replace the word under the cursor.
-- current line
map("n", "<Leader>*", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "replace word under cursor" })
-- all occurrences
map("n", "<Leader>**", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "replace word under curser in all occurrences" })

-- Switch CWD to the directory of the open buffer
map("", "<Leader>c.", ":cd %:p:h<CR>:pwd<CR>", { desc = "Switch CWD to the directory of the open buffer" })
-- Replace word under cursor
map("n", "<leader>j", "*``cgn", { desc = "Replace word under cursor" })
------------------------------------
--- terminal
map("n", "<leader>ft", function()
  require("config.util.terminal").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })
map("n", "gt", function()
  require("config.util.terminal").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })
-- this ctrl - /
map("n", "<C-_>", function()
  require("config.util.terminal").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>fv", function()
  require("config.util.terminal").new { pos = "vsp" }
end, { desc = "terminal new vertical term" , remap = true })


-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
------------------------------------------------

-- live-server

map("n", "<leader>us", function ()
  if vim.g.liveserver_bufnr == nil then 
    if vim.o.filetype == "markdown" then
      vim.cmd("LivePreview start")
 vim.g.liveserver_bufnr = vim.api.nvim_get_current_buf()
    else
      vim.cmd("LiveServer")
    end
  else
     if vim.o.filetype == "markdown" then
      vim.cmd("LivePreview start")
 vim.g.liveserver_bufnr = vim.api.nvim_get_current_buf()
     
    end
    vim.cmd("LiveServerStop")
  end
end, {desc = "toggle live-server"})
