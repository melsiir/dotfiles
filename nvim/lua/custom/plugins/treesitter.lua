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
      "tsx", "graphql", "html",
      "scss", "python", "dockerfile",
      "dot", "json", "bash", "fish",
      "hjson", "vue", "svelt",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
   autotag = {
    enable = true,
  }
}

