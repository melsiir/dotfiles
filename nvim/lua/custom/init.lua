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

-- NOTE: the 4th argument in the map function can be a table i.e options but its most likely un-needed so dont worry about it

-- Install plugins

local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
   -- use { "lewis6991/impatient.nvim" }

   --lsp-config
   use {
      "neovim/nvim-lspconfig",
      module = "lspconfig",

      config = function()
         require "custom.plugins.lspconfig"
      end,

      -- lazy load!
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lspconfig"
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      opt = true,
   }

   use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.signature"
      end,
   }

   use { "nvim-treesitter/playground", after = "nvim-treesitter" }

   -- completion 

   -- load luasnips + cmp related in insert mode only
   use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require "custom.plugins.cmp"
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         local luasnip = require "luasnip"
         luasnip.config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
         }
         require("luasnip/loaders/from_vscode").load()
      end,
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   }

   use {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   }

   use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
         local autopairs = require "nvim-autopairs"
         local cmp_autopairs = require "nvim-autopairs.completion.cmp"

         autopairs.setup { fast_wrap = {} }

         local cmp = require "cmp"
         cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
   }

   use { "hrsh7th/cmp-emoji", after = { "nvim-cmp" } }

   use {
      "karb94/neoscroll.nvim",
      opt = true,
      config = function()
         require("neoscroll").setup()
      end,

      -- lazy loading
      setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   }

   use {
      "Pocco81/TrueZen.nvim",
      cmd = {
         "TZAtaraxis",
         "TZMinimalist",
         "TZFocus",
      },
      config = function()
         require "custom.plugin_confs.truezen"
      end,
   }

   use { "nathom/filetype.nvim" }

   use {
      "dstein64/vim-startuptime",
   }

   use {
      "mattn/emmet-vim",
      event = "VimEnter",
   }

   use {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugin_confs.null-ls").setup()
      end,
   }

   use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = [[require('custom.plugins.lualine')]],
      after = "nvim-web-devicons",
   }

   --   use({ {
   --     "nvim-lualine/lualine.nvim",
   --      event = "VimEnter",
   --     config = [[require('custom.plugins.evil_lualine')]],
   --     after = "nvim-web-devicons",
   --   },
   --             {
   --                 'arkav/lualine-lsp-progress',
   --                 after = 'lualine.nvim',
   --             },
   -- })

   use {
      "folke/which-key.nvim",
      event = "VimEnter",
      -- config = function()
      --   require("custom.plugins.keys")
      -- end,
   }

   use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }

   use { "JoosepAlviste/nvim-ts-context-commentstring", after = { "nvim-treesitter", "Comment.nvim" } }
   --
   use {
      "blackCauldron7/surround.nvim",
      config = function()
         require "custom.plugins.surround"
      end,
   }

   use {
      "ahmedkhalf/project.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
      config = "require('custom.plugins.project')",
   }
   -- require pkg install glow
   use { "ellisonleao/glow.nvim", cmd = "Glow", config = "require('custom.plugins.glow')" }

   use {
      "hrsh7th/cmp-cmdline",
      -- after = "cmp-buffer",
      after = "nvim-cmp",
      config = "require('custom.plugins.cmdline')",
   }

   --   use({ 'JoosepAlviste/nvim-ts-context-commentstring',
   --   requires = {  "nvim-treesitter/nvim-treesitter" },
   -- after = "nvim-teesitter",
   -- -- config = "require('custom.plugins.context')",
   -- })

   --    use({
   -- 	"tamton-aquib/dynamic-cursor.nvim",
   --       config = function()
   -- 	  require("dynamic-cursor").setup()
   --     end,
   -- })

   use "tpope/vim-repeat" -- Make repeat (.) command smarter
   -- themes

   use "folke/tokyonight.nvim"
   --
   -- use 'ful1e5/onedark.nvim'
   --
   -- use 'rmehri01/onenord.nvim'
   --
   -- use 'shaunsingh/nord.nvim'
end)

-- Stop sourcing filetype.vim
vim.g.did_load_filetypes = 1
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50i\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
