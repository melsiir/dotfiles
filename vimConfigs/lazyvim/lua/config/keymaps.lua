-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
---------------------- My Keymaps --------------------
-- jump to crossponding parenthess
map({ "n", "x", "v", "s" }, "<BS>", "%", { remap = true, desc = "Jump to Paren" })

-- tab management bufferline
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "switch between tabs" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "switch between tabs" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

map("i", "jk", "<Esc>", { desc = "Escape" })
map("i", "kj", "<Esc>", { desc = "Escape" })
map("i", "jj", "<Esc>", { desc = "Escape" })

-- Duplicate lines without affecting PRIMARY and CLIPBOARD selections.
map("n", "<leader>dd", 'm`""Y""P``', { desc = "Duplicate line" })
map("x", "<leader>dd", '""Y""Pgv', { desc = "Duplicate selection" })

-- open the current file in external editor
map("n", "<leader>o", "<cmd>!open % <CR>", { desc = "open in external editor" })

map(
  "n",
  "<leader>yp",
  ':let @* = expand("%:p") | echo "yanked: " . @*<CR>',
  { desc = "buffer: yank full path of file in current buffer" }
)

-- Duplicate a line and comment out the first line
-- map("n", "yc", ":normal! yypgcc<CR>", { desc = "yank and comment" })

map("n", "yc", function()
  local comment = require("mini.comment")
  vim.cmd("normal! yyp")
  vim.cmd("normal! k")
  comment.toggle_lines(vim.fn.line("."), vim.fn.line("."))
  vim.cmd("normal! jg$")
end, { desc = "duplicate line and comment copy" })

-- live-server

map("n", "<leader>us", function()
  if vim.g.liveserver_bufnr == nil then
    if vim.o.filetype == "markdown" then
      vim.cmd("LivePreview start")
      vim.g.liveserver_bufnr = vim.api.nvim_get_current_buf()
    else
      vim.cmd("LiveServer")
    end
  else
    if vim.o.filetype == "markdown" then
      vim.cmd("LivePreview close")
      vim.g.liveserver_bufnr = nil
    else
      vim.cmd("LiveServerStop")
    end
  end
end, { desc = "toggle live-server" })

map("n", "<leader>fx", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file", vim.log.levels.WARN)
    return
  end

  local perms = vim.fn.getfperm(file)
  -- perms = rwxr-xr-x
  local owner_executable = perms:sub(3, 3) == "x"
  local escaped_file = vim.fn.shellescape(file)

  if owner_executable then
    vim.cmd("silent !chmod u-x " .. escaped_file)
    vim.notify("Removed executable permission", vim.log.levels.INFO)
  else
    vim.cmd("silent !chmod u+x " .. escaped_file)
    vim.notify("Added executable permission", vim.log.levels.INFO)
  end
end, { desc = "Toggle executable permission" })

map(
  "n",
  "<leader>rU",
  [[:%s/\<<C-r><C-w>\>/<C-r>=toupper(expand('<cword>'))<CR>/gI<Left><Left><Left>]],
  { desc = "GLOBALLY replace word I'm on with UPPERCASE" }
)

-- Replaces the current word with the same word in lowercase, globally
map(
  "n",
  "<leader>rL",
  [[:%s/\<<C-r><C-w>\>/<C-r>=tolower(expand('<cword>'))<CR>/gI<Left><Left><Left>]],
  { desc = "GLOBALLY replace word I'm on with lowercase" }
)

-- replace globally
map("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "replace word under curser globally" })
-- replace globally of selected text
map("v", "<leader>rs", [[y:%s#\V<C-r>"##g<Left><Left>]], {
  desc = "replace selected text in all occurrences",
})
