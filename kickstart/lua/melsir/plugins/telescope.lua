-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        -- sorting_strategy = "ascending",
        set_env = { COLORTERM = 'truecolor' },
        file_ignore_patterns = {
          '^.git/',
          '/.git/',
          'node_modules',
          '.git/',
          '%.jpg',
          '%.jpeg',
          '%.png',
          '%.svg',
          '%.otf',
          '%.ttf',
          '%.lock',
          '__pycache__',
          '%.sqlite3',
          '%.ipynb',
          'vendor',
          'node_modules',
          'dotbot',
          'packer_compiled.lua',
        },
        prompt_prefix = ' 🔮  ',
        -- selection_caret = "  ",
        -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        -- layout_config = {
        --   width = 100,
        --   height = 25,
        --   prompt_position = "top",
        -- },
      },
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    -- open telescope in nvim config directory
    vim.keymap.set('n', '<leader>fg', function()
      require('telescope.builtin').find_files { cwd = '~/.config/nvim' }
    end, { desc = 'find nvim config' })

    -- key map
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'find files' })
    vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep, { desc = 'find word in directory' })
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'find in current buffer' })
    vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = 'find old files' })
    vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = 'resume your last work' })
    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'find help tags' })
    vim.keymap.set('n', '<leader>bm', require('telescope.builtin').marks, { desc = 'find bookmarks' })
    vim.keymap.set('n', '<leader>fq', require('telescope.builtin').quickfix, { desc = 'find quickfix' })
    vim.keymap.set('n', '<leader>fd', require('telescope.builtin').commands, { desc = 'find commands' })
    vim.keymap.set('n', '<leader>fs', require('telescope.builtin').git_status, { desc = 'find git status' })
    vim.keymap.set('n', '<leader>fc', require('telescope.builtin').git_commits, { desc = 'find git commits' })
    vim.keymap.set('n', '<leader>fz', require('telescope.builtin').current_buffer_fuzzy_find, { desc = 'fuzzy find in current buffer' })
    -- vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
  end,
}
