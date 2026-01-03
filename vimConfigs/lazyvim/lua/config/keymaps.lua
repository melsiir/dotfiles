-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--note
--press shift k to  open certain function or method documentation
--press shift and k again to focus on the documentation so you can browse
--the documentation with motions

local map = vim.keymap.set

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Drag current line/s vertically and auto-indent
-- note that LazyVim already have this but in defrent shortcut
-- alt j
--  alt k
-- map("n", "<leader>k", "<cmd>move-2<CR>==", { desc = "Move line up" })
-- map("n", "<leader>j", "<cmd>move+<CR>==", { desc = "Move line down" })
-- map("x", "<leader>k", ":move'<-2<CR>gv=gv", { desc = "Move selection up" })
-- map("x", "<leader>j", ":move'>+<CR>gv=gv", { desc = "Move selection down" })

-- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
map("n", "<leader>dd", 'm`""Y""P``', { desc = "Duplicate line" })
map("x", "<leader>dd", '""Y""Pgv', { desc = "Duplicate selection" })

-- Duplicate paragraph
map("n", "<leader>dp", "yap<S-}>p", { desc = "Duplicate Paragraph" })
-- delete paragraph
map("n", "<leader>de", "dap", { desc = "Delete Paragraph" })
--copy paragraph
map("n", "<leader>cp", "yap", { desc = "copy Paragraph" })

-- tab management bufferline
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "switch between tabs" })

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
map("n", "gS", [[:s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "replace word under cursor" })
-- all occurrences
map("n", "gs", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "replace word under curser in all occurrences" })

-- Switch CWD to the directory of the open buffer
map("", "<Leader>c.", ":cd %:p:h<CR>:pwd<CR>", { desc = "Switch CWD to the directory of the open buffer" })
