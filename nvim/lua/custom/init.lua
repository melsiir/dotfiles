local map = require("core.utils").map

   map("n", "<leader>cc", ":Telescope <CR>")
   map("n", "<leader>q", ":q <CR>")
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
   map("n", "<leader>fp", ":Telescope projects<CR>", opt)
   map("n", "<leader>gl", ":Glow <CR>", opt)


-- NOTE: the 4th argument in the map function can be a table i.e options but its most likely un-needed so dont worry about it

-- Install plugins

local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
    
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

 
  use({
    "nvim-lualine/lualine.nvim",
     event = "VimEnter",
    config = [[require('custom.plugins.evil_lualine')]],
    after = "nvim-web-devicons",
  })

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


   use({
    "folke/which-key.nvim",
    event = "VimEnter",
    -- config = function()
    --   require("custom.plugins.keys")
    -- end,
  })
    

    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter",
  config = function ()
  require('nvim-ts-autotag').setup()
  end, 
})
    
    use {
  "blackCauldron7/surround.nvim",
  config = function()
    require("custom.plugins.surround")
  end,
}



    use({
      "ahmedkhalf/project.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
      config = "require('custom.plugins.project')",
    })
    -- require pkg install glow
    use({ "ellisonleao/glow.nvim", cmd = "Glow", config = "require('custom.plugins.glow')" })

   use({
     "hrsh7th/cmp-cmdline",
     after = "cmp-buffer",
     config = "require('custom.plugins.cmdline')",
   })

   use 'folke/tokyonight.nvim'

   use 'ful1e5/onedark.nvim'
   
   use 'rmehri01/onenord.nvim'

   use 'shaunsingh/nord.nvim'

 end)



 
-- Stop sourcing filetype.vim
vim.g.did_load_filetypes = 1

