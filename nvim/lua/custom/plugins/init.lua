-- Example plugins file!
-- (suggestion) -> lua/custom/plugins/init.lua or anywhere in custom dir

return {
   { "elkowar/yuck.vim", ft = "yuck" },

    { "nvim-treesitter/playground", after = "nvim-treesitter" },

    { "hrsh7th/cmp-emoji", after = { "nvim-cmp" } },

    {
      "karb94/neoscroll.nvim",
      opt = true,
      config = function()
         require("neoscroll").setup()
      end,

      -- lazy loading
      setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   },

    {
      "Pocco81/TrueZen.nvim",
      cmd = {
         "TZAtaraxis",
         "TZMinimalist",
         "TZFocus",
      },
      config = function()
         require "custom.plugin_confs.truezen"
      end,
   },


    {
      "dstein64/vim-startuptime",
   },

    {
      "mattn/emmet-vim",
      event = "VimEnter",
   },

    {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugin_confs.null-ls").setup()
      end,
   },

    {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = [[require('custom.plugins.lualine')]],
      after = "nvim-web-devicons",
   },
   
   
   {
      "folke/which-key.nvim",
      event = "VimEnter",
      -- config = function()
      --   require("custom.plugins.keys")
      -- end,
   },

{
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("custom.plugins.todo")
  end
},

    { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },

    { "JoosepAlviste/nvim-ts-context-commentstring",
   module = "ts_context_commentstring",
   after = { "nvim-treesitter" } },
   --
    {
      "blackCauldron7/surround.nvim",
      config = function()
         require "custom.plugins.surround"
      end,
   },

    {
      "ahmedkhalf/project.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
      config = "require('custom.plugins.project')",
   },
   -- require pkg install glow
    { "ellisonleao/glow.nvim", cmd = "Glow", config = "require('custom.plugins.glow')" },

    {
      "code-biscuits/nvim-biscuits",
      after = "nvim-treesitter",
      -- config = require('nvim-biscuits').setup({}),
      config = function()
         require("nvim-biscuits").setup {
            toggle_keybind = "<leader>cb",
            show_on_start = false,
            default_config = {
               prefix_string = "ﲕ  ",
            },
         }
      end,
   },

    {
      "hrsh7th/cmp-cmdline",
      -- after = "cmp-buffer",
      after = "nvim-cmp",
      config = "require('custom.plugins.cmdline')",
   },


   {"tpope/vim-repeat"}, -- Make repeat (.) command smarter
   -- themes

    {"folke/tokyonight.nvim"},
   --
   --  'ful1e5/onedark.nvim'
   --
   --  'rmehri01/onenord.nvim'
   --
   --  'shaunsingh/nord.nvim'
}
