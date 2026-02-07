-- Plugin specifications for lazy.nvim
return {
  
  -- Snacks.nvim - Essential utilities
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {},
    keys = {
      { '<leader>fn', function() require('snacks.rename').rename_file() end, desc = 'Rename File' },
      { '<leader>gg', function() require('snacks').lazygit() end, desc = 'LazyGit' },
      { '<leader>tt', function() require('snacks').terminal() end, desc = 'Toggle Terminal' },
      { '<leader>xx', function() require('snacks').toggle.diagnostics() end, desc = 'Toggle Diagnostics' },
      { '<leader>cc', function() require('snacks').toggle.colorizer() end, desc = 'Toggle Colorizer' },
      { '<leader>cb', function() require('snacks').toggle.background() end, desc = 'Toggle Background' },
      { '<leader>sh', function() require('snacks').session.save() end, desc = 'Save Session' },
      { '<leader>sl', function() require('snacks').session.load() end, desc = 'Load Session' },
      { '<leader>sd', function() require('snacks').session.delete() end, desc = 'Delete Session' },
      { '<leader>uL', function() require('snacks').words.jump() end, desc = 'Jump to Last Location' },
    },
  },

  -- Blink.cmp - Modern completion engine
  {
    'saghen/blink.cmp',
    event = 'VeryLazy',
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<C-e>'] = { 'cancel', 'fallback' },
      },
    },
  },

  -- Colorscheme - Tokyonight with VS Code-like appearance
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      style = 'moon',
      transparent = false,
      terminal_colors = true,
      styles = {
        sidebars = 'transparent',
        floats = 'dark',
      },
      on_colors = function(colors)
        colors.comment = '#737aa2'
      end,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      -- vim.cmd.colorscheme('tokyonight')
    end,
  },

  -- Mason for managing LSP servers, DAP servers, linters, and formatters
  {
    'mason-org/mason.nvim',
    event = 'VeryLazy',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },

  -- Mason-lspconfig to connect mason with lspconfig
  {
    'mason-org/mason-lspconfig.nvim',
    event = 'VeryLazy',
    opts = {
      -- NOTE: You'll need to install these servers manually with :Mason
      -- ensure_installed = {
      --   'lua_ls',
      --   'pyright',
      --   'tsserver',
      --   'eslint',
      --   'rust_analyzer',
      --   'gopls',
      --   'clangd',
      --   'dockerls',
      --   'jsonls',
      --   'yamlls',
      --   'html',
      --   'cssls',
      -- },
      handlers = {
        function(server_name) -- default handler (optional)
          -- Skip lua_ls as it's handled separately with the new API
          if server_name == 'lua_ls' then
            require('lsp-config').setup_lua_ls()
          else
            -- For other servers, use the traditional setup
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            local opts = {
              on_attach = require('lsp-config').on_attach,
              capabilities = capabilities,
              handlers = {
                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
                ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
              },
            }

            -- Server-specific configurations
            if server_name == 'tsserver' then
              opts.init_options = {
                preferences = {
                  includeInlayParamNameHints = 'all',
                  includeInlayParamNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              }
            elseif server_name == 'clangd' then
              opts.cmd = {
                'clangd',
                '--background-index',
                '--clang-tidy',
                '--header-insertion=iwyu',
                '--completion-style=detailed',
                '--function-arg-placeholders',
                '--fallback-style=llvm',
              }
            end

            require('lspconfig')[server_name].setup(opts)
          end
        end,
      },
    },
  },

  -- Mason-tool-installer for automatic installation of tools
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    opts = {
      -- NOTE: You'll need to install these tools manually with :Mason
      -- ensure_installed = {
      --   'stylua', -- lua formatter
      --   'prettier', -- general formatter
      --   'eslint-lsp', -- js/ts linter
      --   'biome', -- js/ts formatter and linter
      --   'black', -- python formatter
      --   'ruff', -- python linter
      --   'shellcheck', -- shell linter
      --   'shfmt', -- shell formatter
      --   'golangci-lint', -- go linter
      --   'gofumpt', -- go formatter
      --   'goimports', -- go imports
      -- },
    },
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  -- Treesitter for syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'c', 'cpp', 'go', 'lua', 'python', 'rust', 'javascript', 'typescript', 'tsx',
        'java', 'json', 'yaml', 'html', 'css', 'markdown', 'markdown_inline',
        'bash', 'vim', 'vimdoc', 'query', 'regex'
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },

  -- Telescope for fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable('make') == 1,
      },
    },
    keys = {
      { '<leader><space>', '<cmd>Telescope buffers<cr>', desc = 'Find Files (Buffers)' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files (Workspace)' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },
      { '<leader>fs', '<cmd>Telescope live_grep<cr>', desc = 'Find Text' },
      { '<leader>fc', '<cmd>Telescope grep_string<cr>', desc = 'Find Word Under Cursor' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
    },
    opts = {
      defaults = {
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { 'node_modules', '.git/' },
        path_display = { 'truncate' },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      },
    },
  },

  -- Comment plugin
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
      toggler = {
        line = '<leader>/',
        block = '<leader>cb',
      },
      opleader = {
        line = '<leader>/',
        block = '<leader>cb',
      },
      extra = {
        above = '<leader>cO',
        below = '<leader>co',
        eol = '<leader>ca',
      },
    },
  },

  -- Surround plugin
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    opts = {},
  },

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)

      -- Setup autopairs with blink.cmp
      -- Since we're using blink.cmp instead of cmp, we need to handle this differently
      -- For now, just setup the autopairs without cmp integration
    end,
  },

  -- Indent blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = {
        show_start = false,
      },
    },
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'dashboard', 'alpha', 'starter' },
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
          {
            function()
              local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
              local messages = vim.lsp.util.get_progress_messages()

              if #messages > 0 then
                local msg = messages[1]
                local title = msg.title or "LSP"
                local percentage = msg.percentage or 0
                local spin_i = math.floor(vim.loop.now() / 120) % #spinners
                return string.format("%s %s (%d%%)", spinners[spin_i + 1], title, percentage)
              else
                -- Show connected LSP servers when not processing
                local clients = vim.lsp.get_clients()
                local lsp_count = #clients
                if lsp_count > 0 then
                  return string.format(" %d", lsp_count)
                end
              end

              return ""
            end,
            color = { fg = "#a7c080" },
          },
          'encoding',
          'fileformat',
          'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = {'fugitive', 'nvim-tree'},
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
    },
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close Others' },
      { '<leader>bc', '<cmd>BufferLineCloseRight<cr>', desc = 'Close to the Right' },
    },
    opts = {
      options = {
        mode = 'tabs',
        separator_style = 'thin',
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
      },
    },
  },

  -- Alpha dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    opts = function()
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find File', '<cmd>Telescope find_files<cr>'),
        dashboard.button('n', '  New File', '<cmd>ene<cr>'),
        dashboard.button('r', '  Recent', '<cmd>Telescope oldfiles<cr>'),
        dashboard.button('g', '  Find Text', '<cmd>Telescope live_grep<cr>'),
        dashboard.button('c', '  Config', '<cmd>e $MYVIMRC<cr>'),
        dashboard.button('q', '  Quit', '<cmd>qa<cr>'),
      }
      dashboard.section.footer.val = 'Neovim for everyone'
      dashboard.section.footer.opts.hl = 'Type'

      -- Correctly define the layout
      local config = {
        layout = {
          { type = 'padding', val = 2 },
          dashboard.section.header,
          { type = 'padding', val = 2 },
          dashboard.section.buttons,
          { type = 'padding', val = 1 },
          dashboard.section.footer,
        },
        opts = {
          margin = 5,
        },
      }
      return config
    end,
  },

  -- Which-key for keybinding hints
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'modern',
      delay = 500,
      win = {
        border = 'single',
      },
    },
    keys = {
      { '<leader>?', mode = 'n', function() require('which-key').show({ global = false }) end, desc = 'Buffer Local Keymaps' },
    },
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gitsigns.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'Next Hunk' })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gitsigns.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'Prev Hunk' })

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = 'Stage Hunk' })
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = 'Reset Hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset Buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview Hunk' })
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'Blame Line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff This' })
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = 'Diff This ~' })
      end,
    },
  },

  -- Toggleterm for terminal
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    },
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
      { '<A-d>', '<cmd>ToggleTerm direction=float<cr>', desc = 'Float Terminal' },
      { '<A-h>', '<cmd>ToggleTerm size=10 direction=horizontal<cr>', desc = 'Horizontal Terminal' },
      { '<A-v>', '<cmd>ToggleTerm size=80 direction=vertical<cr>', desc = 'Vertical Terminal' },
    },
  },

  -- Harpoon for file navigation
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    opts = {},
    keys = {
      { '<leader>ha', function() require('harpoon'):list():add() end, desc = 'Harpoon add file' },
      { '<leader>hm', function() require('harpoon'):menu():toggle() end, desc = 'Harpoon menu' },
      { '<leader>hn', function() require('harpoon'):list():next() end, desc = 'Harpoon next' },
      { '<leader>hp', function() require('harpoon'):list():prev() end, desc = 'Harpoon prev' },
      { '<leader>h1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon goto 1' },
      { '<leader>h2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon goto 2' },
      { '<leader>h3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon goto 3' },
      { '<leader>h4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon goto 4' },
    },
  },

  -- Oil for file management
  {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    opts = {
      columns = {
        'icon',
        -- 'permissions',
        -- 'size',
        -- 'mtime',
      },
      view_options = {
        show_hidden = true,
      },
      win_options = {
        wrap = false,
        signcolumn = 'no',
      },
    },
    keys = {
      { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
      { '<leader>-', function() require('oil').open_float() end, desc = 'Open oil in floating window' },
    },
  },

  -- Formatter
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable autoformat on save for certain filetypes
        local disable_filetypes = { 'sql', 'lua' }
        return not vim.tbl_contains(disable_filetypes, vim.bo[bufnr].filetype)
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'black', 'isort' },
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
      },
    },
  },

  -- Linting
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('lint').linters_by_ft = {
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        python = { 'ruff' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },

  -- Smooth scroller
  {
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    opts = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
                   '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      hide_cursor = true,          -- Hide cursor while scrolling
      stop_eof = true,             -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil,       -- Default easing function
      pre_hook = nil,              -- Function to run before the scrolling animation starts
      post_hook = nil,             -- Function to run after the scrolling animation ends
    },
  },

  -- Better escape for terminal mode
  {
    'axkirillov/hbac.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Noice for enhanced UI
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
        },
      },
      messages = {
        enabled = true,
        view = 'mini',
      },
      popupmenu = {
        enabled = true,
        backend = 'blink',
      },
      lsp = {
        progress = {
          enabled = true,
          format = 'notification',
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          view = 'mini',
        },
      },
      views = {
        mini = {
          position = {
            row = -2,
          },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
}
