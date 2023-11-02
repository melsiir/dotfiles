-- vim.loader.enable()
require 'options'
require 'keymaps'

--[[   If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html
 ]]



-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
    ui = {
    border = 'rounded',
  },

  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    'stevearc/conform.nvim',
    lazy = true,
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>fm',
        function()
          require('conform').format()
        end,
        mode = { 'n', 'v' },
        desc = 'Format buffer',
      },
    },
    opts = {
      -- format_on_save = {
      --   -- These options will be passed to conform.format()
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        fish = { 'fish_indent' },
        json = { 'jq' },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ['_'] = { 'trim_whitespace' },
      },
    },
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'onedark'
    end,
  },
  'Mofiqul/dracula.nvim',
  { 'folke/tokyonight.nvim', priority = 1000 },
{
    -- Theme inspired by twitch colors
    'usirin/bleed-purple.nvim',
    priority = 1000,
    branch = 'phoenix-occupative',
    dependencies = {
      'rktjmp/lush.nvim',
    },
    config = function()
      -- vim.cmd.colorscheme 'bleed-purple'
    end,
  },

  -- {
  --   'roobert/palette.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     local colors = require('phoenix.blurple.colors').palette
  --
  --     local blurple = {
  --       main = {
  --         color0 = colors['plum.22'],
  --         color1 = colors['plum.20'],
  --         color2 = colors['plum.14'],
  --         color3 = colors['plum.12'],
  --         color4 = colors['plum.10'],
  --         color5 = colors['plum.8'],
  --         color6 = colors['plum.6'],
  --         color7 = colors['plum.4'],
  --         color8 = colors['plum.2'],
  --       },
  --       accent = {
  --         accent0 = '#707bf4',
  --         accent1 = '#7984f5',
  --         accent2 = '#949cf7',
  --         accent3 = '#9ba3f7',
  --         accent4 = '#a8aff8',
  --         accent5 = '#bcc1fa',
  --         accent6 = '#c9cdfb',
  --       },
  --       state = {
  --         error = '#f23f43',
  --         warning = '#f0b232',
  --         hint = '#828391',
  --         ok = '#248045',
  --         info = '#00aafc',
  --       },
  --     }
  --
  --     require('palette').setup {
  --       palettes = {
  --         main = 'blurple',
  --         accent = 'blurple',
  --         state = 'blurple',
  --       },
  --
  --       custom_palettes = {
  --         main = { blurple = blurple.main },
  --         accent = { blurple = blurple.accent },
  --         state = { blurple = blurple.state },
  --       },
  --     }
  --
  --     vim.cmd [[colorscheme palette]]
  --     vim.cmd [[highlight ColorColumn guibg=#1c1d26]]
  --     -- vim.cmd [[highlight CursorLine guibg=#1c1d26]]
  --     vim.cmd [[highlight diffRemoved guifg=#f23f43]]
  --     vim.cmd [[highlight diffAdded guifg=#248045]]
  --     vim.cmd [[highlight Comment guifg=#414252]]
  --     vim.cmd [[highlight link gitcommitFirstLine Search]]
  --     vim.cmd [[highlight link gitcommitSummary gitcommitFirstLine]]
  --   end,
  -- },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },


  

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  --Note this is my personal configuration plugins

  { import = 'melsir.plugins' },

  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})
-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[F]ind', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]ave', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

-- require 'autocmds'
-- set nvim theme
vim.cmd.colorscheme 'onedark'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
