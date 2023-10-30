

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim',
  commit = '6c921ca12321edaa773e324ef64ea301a1d0da62',
  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
},
config = function(_)
  require("telescope").setup({
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
    defaults = {
      -- sorting_strategy = "ascending",
      set_env = { COLORTERM = 'truecolor' },
      file_ignore_patterns = {
      "^.git/", "/.git/",  "node_modules",
      '.git/',  '%.jpg',  '%.jpeg',  '%.png',
      '%.svg',  '%.otf',  '%.ttf',  '%.lock',
      '__pycache__',  '%.sqlite3',  '%.ipynb',
      'vendor',  'node_modules',  'dotbot',
      'packer_compiled.lua', },
      prompt_prefix = " 🔮  ",
      -- prompt_prefix = " 🔭  ",
      -- selection_caret = "  ",
      -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      -- layout_config = {
      --   width = 100,
      --   height = 25,
      --   prompt_position = "top",
      -- }, 
  }
})
  -- To get fzf loaded and working with telescope, you need
  -- load_extension, somewhere after setup function:
  require('telescope').load_extension('fzf')
  -- require('telescope').load_extension('lsp_handlers')
  -- require('telescope').load_extension('dap')
  -- require('telescope').load_extension('session-lens')
  require('telescope').load_extension('file_browser')
  -- require('telescope').load_extension('themes')
end
}
