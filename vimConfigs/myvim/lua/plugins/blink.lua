if not vim.g.blinkcmp then
  return {}
end

return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    version = "*",
    -- tag = "v0.8.2",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = "*",
      },
    },
    event = "InsertEnter",
    opts = {
      -- snippets = {
      --   expand = function(snippet, _)
      --     return LazyVim.cmp.expand(snippet)
      --   end,
      -- },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      completion = {
        list = {
          max_items = 20,
        },
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
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

            -- components = {
            --   kind_icon = {
            --     highlight = function(ctx)
            --       local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
            --       return hl
            --     end,
            --   },
            --   label = {
            --     text = function(item)
            --       return item.label
            --     end,
            --     highlight = function(ctx)
            --       local _, hl, _ = require('mini.icons').get('lsp', ctx.label)
            --       return hl
            --     end,
            --   },
            --   kind = {
            --     text = function(item)
            --       return item.kind
            --     end,
            --     highlight = function(ctx)
            --       local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
            --       return hl
            --     end,
            --   },
            -- }
          },
        },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 200,
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

      -- expuerimental signature help support
      signature = { enabled = true },
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
        -- comment to enable cmdline completion
        -- cmdline = {},
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
        },
      },

      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
        -- keymaps active
        -- accept = "<CR>",
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        --
        -- ["<Up>"] = { "select_prev", "fallback" },
        -- ["<Down>"] = { "select_next", "fallback" },
        -- ["<C-p>"] = { "select_prev", "fallback" },
        -- ["<C-n>"] = { "select_next", "fallback" },
        --
        -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        --
        ["<C-UP>"] = { "scroll_documentation_up", "fallback" },
        ["<C-DOWN>"] = { "scroll_documentation_down", "fallback" },
        --
        -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        -- ["<C-e>"] = { "hide", "fallback" },
      },
      cmdline = {
        keymap = { preset = "super-tab" },
      },
    },

    config = function(_, opts)
      -- setup compat sources
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end
      -- Unset custom prop to pass blink.cmp validation
      opts.sources.compat = nil

      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
            end
            return items
          end

          -- Unset custom prop to pass blink.cmp validation
          provider.kind = nil
        end
      end

      require("blink.cmp").setup(opts)
    end,
  },

  -- add icons
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local icons = require("config.icons").vscode
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = vim.tbl_extend("keep", {
        Color = "██", -- Use block instead of icon for color items to make swatches more usable
      }, icons)
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
  -- catppuccin support
  -- {
  --   "catppuccin",
  --   optional = true,
  --   opts = {
  --     integrations = { blink_cmp = true },
  --   },
  -- },
}
