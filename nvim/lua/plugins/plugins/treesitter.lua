local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
   return
end

ts_config.setup {
   ensure_installed = {
      "lua",
      "vim",
      "css",
      "typescript", "javascript",
      "tsx", "graphql",
      "scss", "python", "dockerfile",
      "dot", "json", "bash", "fish",
      "hjson", "vue", "svelte",
      --i disabled html because it has an issue with 
      --paresing html page
      -- "html",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
       disable = {},
   },
   context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
  },
  -- context_commentstring 
  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false,
  --   config = {
  --     javascript = {
  --       __default = '// %s',
  --       jsx_element = '{/* %s */}',
  --       jsx_fragment = '{/* %s */}',
  --       jsx_attribute = '// %s',
  --       comment = '// %s'
  --     }
  --   }
  -- },
}


