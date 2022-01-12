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
      "hjson", "vue", "svelt",
      --i disabled html because it has an issue with 
      --paresing html page
      -- "html",
   },
   highlight = {
      enable = true,
      -- use_languagetree = true,
       disable = { "html" },
   },
   autotag = {
    enable = true,
  }
}

