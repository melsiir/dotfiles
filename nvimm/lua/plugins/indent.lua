

return {
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = "BufReadPost", 
  opts = {
   enabled = false,
   indent = {
   char = "▏",
   -- char = "|",
   -- tab_char = { "a", "b", "c" },
   -- highlight = { "Function", "Label" },
   -- smart_indent_cap = true,
   -- priority = 2,
  },
   -- whitespace =    {
   -- highlight = { "Function", "Label" },
   -- remove_blankline_trail = true,
   -- },
   exclude = { filetypes = {"help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy"} },

  },
}

}
