-- This is an example init file , its supposed to be placed in /lua/custom dir
-- lua/custom/init.lua


local hooks = require "core.hooks"
local override_req = require("core.utils").override_req

-- MAPPINGS
-- To add new plugins, use the "setup_mappings" hook,

hooks.add("setup_mappings", function(map)
   map("n", "<leader>cc", ":Telescope <CR>", opt)
   map("n", "<leader>q", ":q <CR>", opt)
   map("n", "<leader>qq", ":q! <CR>", opt)
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
   
end)


hooks.add("install_plugins", function(use)
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
          require("custom.plugin_confs.truezen")
      end
   }
   
   
   use { "nathom/filetype.nvim" }
  
  
   use {
     "dstein64/vim-startuptime"
   }
   
   use {
   	"mattn/emmet-vim"
   }


   use {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugin_confs.null-ls").setup()
      end,
   }

--    use {
--   'nvim-lualine/lualine.nvim',
--   after = 'nvim-web-devicons',
--   config = "require('custom.plugins.lualine')"
--    -- config = function()
--    -- require('custom.plugins.line').setup()
-- end
-- }
    
 
  use({ {
    "nvim-lualine/lualine.nvim",
    -- requires = { "rlch/github-notifications.nvim" },
    -- event = "VimEnter",
    --
    config = [[require('custom.plugins.evil_lualine')]],
    after = "nvim-web-devicons",
  },
            {
                'arkav/lualine-lsp-progress',
                after = 'lualine.nvim',
            },
})

  --  use({
  --   "folke/which-key.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     require("custom.plugins.keys")
  --   end,
  -- })
    
    -- use {"ellisonleao/glow.nvim"}
    use({ "ellisonleao/glow.nvim", cmd = "Glow", config = "require('custom.plugins.glow')" })

    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })



    use({
      "ahmedkhalf/project.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
      config = "require('custom.plugins.project')",
    })


   use 'folke/tokyonight.nvim'

   use 'ful1e5/onedark.nvim'
   
   use 'rmehri01/onenord.nvim'

   use({
	"catppuccin/nvim",
	as = "catppuccin"
})

   -- If you are using Packer
      use 'shaunsingh/nord.nvim'

end)


   -- Stop sourcing filetype.vim
vim.g.did_load_filetypes = 1


