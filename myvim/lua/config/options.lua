-- check if its termux
-- vim.env.TERMUX_VERSION
--conform auto format
vim.g.autoformat = true
vim.g.transparent_enabled = true
vim.g.blinkcmp = true
vim.g.ai_cmp = true
vim.g.enableLualine = true
vim.g.dashboard = true
vim.g.autocomment = false
-- Optionally setup the terminal to use
-- This sets `vim.o.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
-- config.functions.terminal.setup("pwsh")

-- Set LSP servers to be ignored when used with `util.root.detectors.lsp`
-- for detecting the LSP root
vim.g.root_lsp_ignore = { "copilot" }

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- Show the current document symbols location from Trouble in lualine
-- You can disable this for a buffer by setting `vim.b.trouble_lualine = false`
vim.g.trouble_lualine = false

local opt = vim.opt

-- vim.o.hlsearch = false -- Set highlight on search
opt.autowrite = true -- Enable auto write
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2                                    -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true                                      -- Confirm to save changes before exiting modified buffer
-- opt.cursorline = true -- Enable highlighting of the current line
-- vim.o.cursorlineopt = "both" -- to enable cursorline!
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  -- eob = " ",
}
opt.foldlevel = 99
opt.showcmd = true
-- opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3         -- global statusline
opt.linebreak = true       -- Wrap lines at convenient points
opt.list = true            -- Show some invisible characters (tabs...
opt.mouse = "a"            -- Enable mouse mode
opt.number = true          -- Print line number
-- opt.numberwidth = 2 -- numbers column width default is 4
-- opt.pumblend = 15 -- Popup blend -- popup transpernancy --cause glitch in cmp icons
opt.pumheight = 10                                                -- Maximum number of entries in a popup
opt.relativenumber = true                                         -- Relative line numbers
opt.scrolloff = 4                                                 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true                                             -- Round indent
opt.shiftwidth = 2                                                -- Size of an indent
opt.shortmess:append({ W = true, I = false, c = true, C = true }) --this will hide neovim intro message
opt.showmode = false                                              -- Dont show mode since we have a statusline
opt.sidescrolloff = 8                                             -- Columns of context
opt.signcolumn =
"yes"                                                             -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true                                              -- Don't ignore case with capitals
opt.smartindent = true                                            -- Insert indents automatically
opt.spelllang = { "en" }
opt.spelloptions:append("noplainbuffer")
opt.splitbelow = true    -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true    -- Put new windows right of current
-- opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
opt.tabstop = 2          -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
-- enable this if you using which-key
opt.timeoutlen = 300     -- Lower than default (1000) to quickly trigger which-key
-- opt.timeoutlen = 1000 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap
if vim.fn.has("nvim-0.10") == 1 then
  -- cause echo with smear-corsur disable for now
  -- opt.smoothscroll = true
  -- opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = "expr"
  opt.foldtext = ""
else
  opt.foldmethod = "indent"
  -- opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
