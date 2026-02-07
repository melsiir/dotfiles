return {
  {
    "saghen/blink.cmp",
    version = "*",
    -- enabled = false,
    -- event = { "InsertEnter", "CmdlineEnter" },
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("blink.cmp").setup({
        snippets = { preset = "default" },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "normal",
        },
        sources = {
          default = { "lsp", "path", "buffer", "snippets" },
          providers = {
            path = {
              name = "Path",
              module = "blink.cmp.sources.path",
              score_offset = 3,
              max_items = 2,
              -- When typing a path, I would get snippets and text in the
              -- suggestions, I want those to show only if there are no path
              -- suggestions
              fallbacks = { "snippets", "buffer" },
              opts = {
                trailing_slash = false,
                label_trailing_slash = true,
                get_cwd = function(context)
                  return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                end,
                show_hidden_files_by_default = true,
              },
            },
            buffer = {
              name = "Buffer",
              max_items = 5,
              module = "blink.cmp.sources.buffer",
              min_keyword_length = 3,
            },
            snippets = {
              name = "snippets",
              enabled = true,
              max_items = 5,
              module = "blink.cmp.sources.snippets",
              min_keyword_length = 2,
              -- score_offset = 80, -- the higher the number, the higher the priority
            },
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          preset = "enter",
          ["<C-y>"] = { "select_and_accept" },
          -- keymaps active
          ["<Tab>"] = { "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "fallback" },
          -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
          ["<C-UP>"] = { "scroll_documentation_up", "fallback" },
          ["<C-DOWN>"] = { "scroll_documentation_down", "fallback" },
          -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
          -- ["<C-e>"] = { "hide", "fallback" },
        },
        cmdline = {
          -- enabled = false,
          -- completion = { menu = { auto_show = true } },
          keymap = {
            ["<CR>"] = { "accept_and_enter", "fallback" },
          },
        },
        completion = {
          menu = {
            border = "rounded",
            winhighlight = "Normal:BlinkCmpMenu,FloatBorder:WinSeparator,CursorLine:PmenuSel,Search:None",
            scrollbar = false,
            draw = {
              -- align_to_component = "label", -- or 'none' to disable
              padding = 1,
              -- gap = 4,
              columns = {
                { "label", "label_description", gap = 1 },
                { "kind_icon", "kind" },
              },
            },
          },
          documentation = {
            auto_show = false,
            auto_show_delay_ms = 500,
            window = {
              border = "rounded",
              winhighlight = "Normal:BlinkCmpMenu,FloatBorder:WinSeparator,CursorLine:PmenuSel,Search:None",
              -- scrollbar = false,
            },
          },
          ghost_text = {
            enabled = true,
          },
        },
      })
    end,
  },
  -- lazydev
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
}
