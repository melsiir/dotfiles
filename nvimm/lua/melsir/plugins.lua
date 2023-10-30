
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{
  import = "plugins"
},
defaults = { lazy = true },
"nvim-tree/nvim-web-devicons",
-- "simrat39/symbols-outline.nvim",
"MunifTanjim/nui.nvim",

{'norcalli/nvim-colorizer.lua'},
-- extract terminal color
{ "psliwka/termcolors.nvim"},
-- {'nvim-lualine/lualine.nvim'},
"NvChad/nvterm",

-- telescope extentions
'nvim-telescope/telescope-media-files.nvim',
{
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
},
"andymass/vim-matchup",
-- "nvim-neo-tree/neo-tree.nvim",
"akinsho/toggleterm.nvim",
"norcalli/nvim-terminal.lua",

-- Autocompletion
{'hrsh7th/nvim-cmp',
dependencies = {
  -- Snippet Engine & its associated nvim-cmp source
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  -- Adds LSP completion capabilities
  -- 'hrsh7th/cmp-nvim-lsp',

  -- Adds a number of user-friendly snippets
  'rafamadriz/friendly-snippets',
}
},
-- themes 
{'folke/tokyonight.nvim'},
'AlexvZyl/nordic.nvim',
'catppuccin/nvim',   
-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
'kanagawa.nvim',
'bluz71/vim-nightfly-colors',
'shaunsingh/nord.nvim',
"Rigellute/rigel",
{ "rose-pine/neovim", name = "rose-pine" },

-- install = { colorscheme = { "catppuccin", "habamax" } },
performance = {
  rtp = {
    -- disable some rtp plugins
    disabled_plugins = {
      "2html_plugin",
      "tohtml",
      "getscript",
      "getscriptPlugin",
      "gzip",
      "logipat",
      "netrw",
      "netrwPlugin",
      "netrwSettings",
      "netrwFileHandlers",
      "matchit",
      "tar",
      "tarPlugin",
      "rrhelper",
      "spellfile_plugin",
      "vimball",
      "vimballPlugin",
      "zip",
      "zipPlugin",
      "tutor",
      "rplugin",
      "syntax",
      "synmenu",
      "optwin",
      "compiler",
      "bugreport",
      "ftplugin",
    },
  },
},
 })

 --require("lazy").setup({
 --  { import = "plugins" }
 --})


