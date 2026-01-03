return {
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('minuet').setup {
        -- provider = 'codestral',
        provider = 'gemini',
        request_timeout = 4,
        throttle = 2000,
        virtualtext = {
          auto_trigger_ft = { 'python', 'lua' },
          keymap = {
            accept = '<A-A>',
            accept_line = '<A-a>',
            prev = '<A-[>',
            next = '<A-]>',
            dismiss = '<A-e>',
          },
        },
        notify = 'error',

        GEMINI_API_KEY = os.getenv("gemini_key"),
        provider_options = {
          gemini = {
            -- model = 'gemini-1.5-flash-latest',
            optional = {
              generationConfig = {
                maxOutputTokens = 256,
              },
              safetySettings = {
                {
                  -- HARM_CATEGORY_HATE_SPEECH,
                  -- HARM_CATEGORY_HARASSMENT
                  -- HARM_CATEGORY_SEXUALLY_EXPLICIT
                  category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
                  -- BLOCK_NONE
                  threshold = 'BLOCK_ONLY_HIGH',
                },
              },
            },
          },
        }
      }
    end
  },
  { 'nvim-lua/plenary.nvim' },
  {
    "iguanacucumber/magazine.nvim",
    opts = function(_, opts)
      -- if you wish to use autocomplete
      table.insert(opts.sources, 1, {
        name = 'minuet',
        group_index = 1,
        priority = 100,
      })

      opts.performance = {
        -- It is recommended to increase the timeout duration due to
        -- the typically slower response speed of LLMs compared to
        -- other completion sources. This is not needed when you only
        -- need manual completion.
        fetching_timeout = 2000,
      }

      opts.mapping = vim.tbl_deep_extend('force', opts.mapping or {}, {
        -- if you wish to use manual complete
        ['<A-y>'] = require('minuet').make_cmp_map(),
      })
    end,
  }
}
